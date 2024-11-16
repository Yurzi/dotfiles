# Load oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin_latte.omp.json" | Invoke-Expression

# Alias
Set-Alias -Name cat -Value bat
Set-Alias -Name which -Value Get-Command
Set-Alias -Name sudo -Value gsudo
Set-Alias -Name rnh -Value Get-RemoteNeovideSession

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

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# remote nvim session
Function Get-RemoteNeovideSession
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$RemoteHost,

    [Parameter(Mandatory = $false, Position = 1)]
    [string]
    $DirOrFilePath
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
      if ($line -match "^\s*LocalForward\s+(localhost|127.0.0.1):(\d+)\s+(localhost|127.0.0.1):(\d+)\s*$")
      {
        $local_port = $matches[2]
        $remote_port = $matches[4]
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

    if ($local_port -and $remote_port)
    {
      Write-Host "Local port: $local_port, Remote port: $remote_port"
    } else
    {
      Write-Host "No LocalForward found in ssh config file"
      return
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
      ssh $RemoteHost nvim --headless --listen localhost:$remote_port $DirOrFilePath &
    }
  }

  end
  {
    # start a new neovide session attached to remote
    neovide --server localhost:$local_port
  }
}
