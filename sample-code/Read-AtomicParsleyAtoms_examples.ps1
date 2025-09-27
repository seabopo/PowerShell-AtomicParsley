#==================================================================================================================
#==================================================================================================================
# Sample Code :: Read AtomicParsley Atoms
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
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
   $modulePath = Join-Path -Path $repoPath  -ChildPath $($repoName.Replace('PowerShell-','po.'))
   $mediaPath  = Join-Path -Path $repoPath  -ChildPath 'sample-media'
}
else {
    Write-Host 'Unexpected repo path found. Script execution halted.' -ForegroundColor Red
    exit
}

Import-Module $modulePath -Force

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
    $networkFilePath = '/Volumes/Media/@ Tools/@ [MediaSamples]/Movie (1080p HD).m4v'
    $atoms = Read-AtomicParsleyAtoms -File $networkFilePath
    $atoms
    $atoms.iTunesMovie
    exit
