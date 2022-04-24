#!/usr/bin/env pwsh
# Launch VSCode server remote
if (!(Get-Command 'code')) {
    return
}
# powershell -executionpolicy RemoteSigned -file setup-project.ps1
# https://github.com/microsoft/vscode-remote-release/issues/2133
$APP_FOLDER_NAME='.dev'

$ROOT_PWD=$(get-location).Path
$PWD=${ROOT_PWD}+'\'+${APP_FOLDER_NAME}
$p = $PWD.ToCharArray() | %{$h=''}{$h += ('{0:x}' -f [int]$_)}{$h}
echo $p
code --folder-uri "vscode-remote://dev-container+$p/workspace"
