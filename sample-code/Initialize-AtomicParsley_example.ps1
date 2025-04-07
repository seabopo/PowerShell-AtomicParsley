#==================================================================================================================
#==================================================================================================================
# Sample Code :: Initialize-PipelineObject
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Header","Process","Information","Debug"]'
$env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

Set-Location  -Path $PSScriptRoot
Push-Location -Path $PSScriptRoot

$projectPath = ((Get-Location).Path -Replace 'PowerShell-AtomicParsley.*','PowerShell-AtomicParsley')
$modulePath  = Join-Path -Path $projectPath -ChildPath 'po.AtomicParsley'
$repoPath    = $((Get-Item $($projectPath)).Parent.FullName)
$toolkitPath = Join-Path -Path $repoPath -ChildPath 'PowerShell-Toolkit/po.Toolkit'

Import-Module $toolkitPath -Force
Import-Module $modulePath  -Force

#==================================================================================================================
# Testing Functions (Initialize-PipelineObject is meant to interrogate functions.)
#==================================================================================================================


#==================================================================================================================
# Run Tests
#==================================================================================================================

# $env:PS_ATOMIC_PARSLEY_PATH = $null
# $env:PS_ATOMIC_PARSLEY_PATH = '/usr/local/bin/atomicparsley'

#Initialize-AtomicParsleyBinary


