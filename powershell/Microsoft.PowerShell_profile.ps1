# Load oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin_latte.omp.json" | Invoke-Expression

# Alias
Set-Alias -Name cat -Value bat
Set-Alias -Name which -Value Get-Command
Set-Alias -Name sudo -Value gsudo

Remove-Alias ls -ErrorAction SilentlyContinue

# config manager
Function config()
{
  git --git-dir=$HOME\.dotfiles\ --work-tree=$HOME\.config\ $args
}


# Unix like command
Function ls()
{
  lsd -F -h $args
}

Function ll()
{
  lsd -F -h -l $args
}

Function touch
{
  param (
    [string[]]$paths
  )
    
  foreach ($path in $paths)
  {
    $directory = Split-Path $path -Parent
        
    if ($directory -and -not (Test-Path $directory))
    {
      New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
        
    if (-not (Test-Path $path))
    {
      New-Item -ItemType File -Path $path -Force | Out-Null
    } else
    {
      (Get-Item $path).LastWriteTime = Get-Date
    }
  }
}

# Extra Function
Function Set-SessionProxy
{
  if ($env:HTTP_PROXY)
  {
    Remove-Item env:HTTP_PROXY
    Remove-Item env:HTTPS_PROXY
    Write-Host "unset proxy"
  } else
  {
    $env:HTTP_PROXY="http://127.0.0.1:2080"
    $env:HTTPS_PROXY="http://127.0.0.1:2080"
    Write-Host "set proxy"
  }
}

Function Import-Toolchain
{
  $type = $args[0];

  if ("msvc" -eq $type)
  {
    pwsh -noe -c '&{Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell 34d3ac92}'
  } 
  if ("msys2-ucrt")
  {
    pwsh -noe -c '&{$env:Path = "C:\msys64\usr\bin;" + $env:Path; $env:Path = "C:\msys64\ucrt64\bin;" + $env:Path;}'
  }
}

Function paru
{
  $env:HTTP_PROXY = "http://127.0.0.1:2080"
  $env:HTTPS_PROXY = "http://127.0.0.1:2080"

  # winget update
  Write-Host "[WINGET]"
  winget update --all --proxy http://127.0.0.1:2080

  # scoop update
  Write-Host "[SCOOP]"
  scoop update *

  # yarn update
  Write-Host "[NODEJS]"
  npm -g upgrade
  pnpm -g upgrade

  # rustup update
  Write-Host "[RUSTUP]"
  rustup update

  # pip upgrade
  Write-Host "[PIP]"
    (pip list --outdated) | Select-Object -Skip 2 | ForEach-Object {python -m pip install --upgrade $($_.split(' ')[0])}

  Remove-Item env:HTTP_PROXY
  Remove-Item env:HTTPS_PROXY
}


# remote nvim session
Function Get-RemoteNeovideSession
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$RemoteHost
  )

  begin
  {
    # collect local port and remote port from ssh config file
    # default ssh config file
    $CONFIG_FILE = Resolve-Path "~/.ssh/config"
    # find the local forward info about $Host
    # get host block
    $config_lines = Get-Content $CONFIG_FILE | Select-String -Pattern "Host\s+$RemoteHost\s*$" -Context 0, 100

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
    # extract local port and remote port from first LocalForward line
    $local_port = $null
    $remote_Port = $null

    foreach ($line in $host_block)
    {
      if ($line -match "^\s*LocalForward\s+localhost:(\d+)\s+localhost:(\d+)\s*$")
      {
        $local_port = $matches[1]
        $remote_port = $matches[2]
      }

      if ($local_port -and $remote_port)
      {
        break
      } else
      {
        $local_port = $null
        $remote_port = $null

      }
    }
  }

  process
  {
    # check if local port is be used
    $is_used = Test-NetConnection -ComputerName "localhost" -Port $local_port -InformationLevel Quiet
    if($is_used)
    {
      Write-Host "Local port $local_port is used, may be a connection is already established"
    } else
    {
      # use ssh to establish a connection
      ssh $RemoteHost nvim --headless --listen localhost:$remote_port &
    }
  }

  end
  {
    # start a new neovide session attached to remote
    neovide --server localhost:$local_port
  }
}