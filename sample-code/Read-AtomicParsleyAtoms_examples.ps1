#==================================================================================================================
#==================================================================================================================
# Sample Code :: Read AtomicParsley Atoms
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

# Load the standard test initialization file.
. $(Join-Path -Path $PSScriptRoot -ChildPath '_init-test-environment.ps1')

# Override the Default Debug Logging Setting
  # $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

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
