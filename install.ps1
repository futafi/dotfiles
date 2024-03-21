#!/usr/bin/env pwsh

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
Write-Host "Script dir: $SCRIPT_DIR"
$DOT_DIR = Join-Path $SCRIPT_DIR "dotfiles"

# find all file in dotfiles directory no recursing
$DOTFILES = Get-ChildItem -Path $DOT_DIR -Recurse:$false -File

# create symlinks
ForEach-Object {
    $target = $_.FullName
    $link = Join-Path $HOME $_.Name
    Write-Host "Creating symlink: $link -> $target"
    New-Item -ItemType SymbolicLink -Path $link -Value $target
} $DOTFILES

winget install --id=Git.MinGit
winget install --id=OpenSSH.OpenSSH.Beta


$KIIDIR = Join-Path $SCRIPT_DIR "kiiconfig"
# if KIIDIR is not exists; then clone it
if (!(Test-Path $KIIDIR)) {
    Write-Host "Cloning KII config"
    git clone git@github.com:futafi/kiiconfig.git $kIIDIR
}
else {
    Write-Host "Updating KII config"
    git -C $KIIDIR pull
}
pwsh -File $KIIDIR\install.ps1