Function Get-LocalPortAvailable
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [int]$Port
  )
  $result = netstat -an | findstr /R "\<127\.0\.0\.1:$Port\>"
  return -not $result
}

Function Get-RemotePortAvailable
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RemoteHost,
    [Parameter(Mandatory = $true, Position = 1)]
    [int]$Port
  )

  $result = [int]$(ssh $RemoteHost "netstat -tuln | grep -q '127.0.0.1:$Port' && echo 1 || echo 0")
  return -not $result
}

Function Get-OneAvaliableConnection
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RemoteHost
  )

  # generate a local port
  $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 0)
  $listener.Start()
  $local_port = $listener.LocalEndpoint.Port
  $listener.Stop()

  # assume remote one is same as local one
  $remote_port = $local_port
  while (-not $(Get-RemotePortAvailable $RemoteHost $remote_port))
  {
    $remote_port += 1
    $remote_port = $remote_port % 65535

    if ($remote_port -le 1024)
    {
      $remote_port += 1024
    }
  }

  $Conn = @{}
  $Conn["local_port"] = $local_port
  $Conn["remote_port"] = $remote_port

  return $Conn
}

Function Get-SshConfigHostInfo
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RemoteHost,

    [Parameter(Mandatory = $false, Position = 1)]
    [string]$ConfigFilePath = $(Resolve-Path '~/.ssh/config').Path
  )

  # get host block
  $config_lines = Get-Content $ConfigFilePath | Select-String -Pattern "Host\s+$RemoteHost\s*$" -Context 0, 100

  $about_lines = $config_lines.Context.PostContext
  $about_lines = ,$config_lines.Line + $about_lines

  $host_block = @()
  $in_hostblock = $false
  foreach ($line in $about_lines)
  {
    if ($line -match "^Host\s+(.+)$")
    {
      if ($in_hostblock)
      {
        break
      } else
      {
        $in_hostblock = $true
      }
    }

    if ($in_hostblock)
    {
      $host_block += $line
    }
  }
  # find RemoteHostIpAddr
  $RemoteHostIpAddr = $null
  foreach($line in $host_block)
  {
    if ($line -match "^\s*Hostname\s+(\S+)$")
    {
      $RemoteHostIpAddr = $Matches[1]
    }
  }

  if (-not $RemoteHostIpAddr)
  {
    throw "Not avaliable Host in config"
  }

  # collect local foward connections
  $LocalForwardConns = @()
  foreach ($line in $host_block)
  {
    $local_port = $null
    $remote_port = $null
    if ($line -match "^\s*LocalForward\s+(localhost|127.0.0.1):(\d+)\s+(localhost|127.0.0.1):(\d+)\s*$")
    {
      $local_port = $matches[2]
      $remote_port = $matches[4]
    }

    if ($local_port -and $remote_port)
    {
      $conn = @{}
      $conn["local_port"] = $local_port
      $conn["remote_port"] = $remote_port
      # add to array
      $LocalForwardConns += $conn
    }
  }

  $parsed_hostblock = @{}
  $parsed_hostblock["Host"] = $RemoteHost
  $parsed_hostblock["Hostname"] = $RemoteHostIpAddr
  $parsed_hostblock["LocalForwards"] = $LocalForwardConns

  return $parsed_hostblock
}


# remote nvim session
Function Get-RemoteNeovideSessionFromSshConfig
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$RemoteHost,

    [Parameter(Mandatory = $false, Position = 1, ValueFromPipeline = $true)]
    [string]$DirOrFilePath,

    [Parameter(Mandatory = $false, Position = 2)]
    [string]$Path = $(Resolve-Path "~/.ssh/config")
  )

  begin
  {
    # get host_block
    $HostBlock = Get-SshConfigHostInfo $RemoteHost $Path
    # check all connections to found one avaliable
    $AvaliableConn = $null
    foreach($Conn in $HostBlock["LocalForwards"])
    {
      if($(Get-LocalPortAvailable $Conn["local_port"]) -and $(Get-RemotePortAvailable $HostBlock["Host"] $Conn["remote_port"]))
      {
        $AvaliableConn = $Conn
        
        Write-Host "Found an avaliable connection"
        break
      }
    }
    
    $UseGeneratedConn = -not $AvaliableConn
    # no avaliable connection, try to generate one
    if ($UseGeneratedConn)
    {
      Write-Host "No avaliable connection found, try to generate one"
      $AvaliableConn = Get-OneAvaliableConnection $RemoteHost
    }
    $remote_port = $AvaliableConn["remote_port"]
    $local_port = $AvaliableConn["local_port"]
  }

  process
  {
    # finally we have a avaliable connection, so try to establish
    Write-Host "Try to establish: local_port: $local_port, remote_port: $remote_port"
    $cmd = "zsh -i -c '(cd $DirOrFilePath && nvim --headless --listen 127.0.0.1:$remote_port);exit'"
    if ($UseGeneratedConn)
    {
      ssh -L "${local_port}:localhost:${remote_port}" $RemoteHost $cmd &
    } else
    {
      ssh $RemoteHost $cmd &
    }
  }
  end
  {
    # start a new neovide session attached to remote
    while($(Get-RemotePortAvailable $RemoteHost $remote_port))
    {
      Start-Sleep -Milliseconds 300
    }
    neovide --server localhost:$local_port
  }
}



