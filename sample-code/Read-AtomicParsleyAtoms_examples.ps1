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
# Run Tests
#==================================================================================================================

#---------------------------
# Local File Test for MacOS
#---------------------------
#
# Please see the ReadMe file for information about file/folder permissions on MacOS.
# https://github.com/seabopo/PowerShell-AtomicParsley/blob/main/README.md
#
    $localFilePath = '/Users/{0}/Movies/Movie (1080p HD).m4v' -f [Environment]::UserName
    $atoms = Read-AtomicParsleyAtoms -File $localFilePath
    $atoms
    $atoms.iTunesMovie
    exit

#-----------------------------
# Network File Test for MacOS
#-----------------------------
#
# This sample assumes you have connected to a network share named 'Media' and it is available on your desktop.
#
    $networkFilePath = '/Volumes/Media/Movies/Movie (1080p HD).m4v'
    $atoms = Read-AtomicParsleyAtoms -File $networkFilePath

