# Load Starship
Invoke-Expression (&starship init powershell)


# Alias
Set-Alias -Name cat -Value bat
Set-Alias -Name which -Value Get-Command
Set-Alias -Name sudo -Value gsudo
Set-Alias -Name rnh -Value Get-RemoteNeovideSessionFromSshConfig

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

Function icat()
{
  chafa -f sixels $args
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

Function btop()
{
  gsudo btop $args
}

Function wgt()
{
  winget $args --proxy http://127.0.0.1:2080
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
    pwsh -noe -c '&{Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell 0466a435}'
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

  # pacman upgrade
  Write-Host "[PACMAN]"
  pacman -Syu --noconfirm
}

function y
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

Import-Module "$(Split-Path $PROFILE)/RemoteNeovide.psm1"
Import-Module "$(Split-Path $PROFILE)/custom-func.psm1"
