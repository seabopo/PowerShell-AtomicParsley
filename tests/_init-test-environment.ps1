#==================================================================================================================
#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Process","Information","Debug","FunctionCall","FunctionResult"]'
$env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $false

Set-Location  -Path $PSScriptRoot
Push-Location -Path $PSScriptRoot

if (((Get-Location).Path) -match 'PowerShell-[^/\\]*') {
    $repoName   = $Matches[0]
    $repoPath   = ((Get-Location).Path -Replace $('{0}.*' -f $repoName),$repoName)
    $reposPath  = ((Get-Location).Path -Replace $('{0}.*' -f $repoName),'')
    $modulePath = Join-Path -Path $repoPath -ChildPath $($repoName.Replace('PowerShell-','po.'))
    $mediaPath  = Join-Path -Path $reposPath -ChildPath 'sample-media'
}
else {
    Write-Host 'Unexpected repo path found. Script execution halted.' -ForegroundColor Red
    exit
}

Import-Module $modulePath -Force
