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
#   $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

#==================================================================================================================
# Run Tests
#==================================================================================================================

#-----------------------------------------
# Repo Movie Test
#-----------------------------------------

    Write-Msg -p -ps -m 'Movie' -fw
    $testFileName = 'Movies/Abominable (2019) [1080p WS iTunes+ HD DD].m4v'
    $testFilePath = Join-Path -Path $mediaPath -ChildPath $testFileName
    $r = Read-AtomicParsleyAtoms -File $testFilePath
    if ( $r.success ) {
        $atoms = $r.value
        $atoms
    }
    else {
        Write-Msg -e -ps -m $r.message
    }
    exit

#---------------------------------------
# Repo TV Show Test
#---------------------------------------

    Write-Msg -p -ps -m 'TV Episode' -fw
    $testFileName = 'TVEpisodes/Breaking In - s01e06 - Breaking Out [1080p WS iTunes HD DD].m4v'
    $testFilePath = Join-Path -Path $mediaPath -ChildPath $testFileName
    $r = Read-AtomicParsleyAtoms -File $testFilePath
    if ( $r.success ) {
        $atoms = $r.value
        $atoms
    }
    else {
        Write-Msg -e -ps -m $r.message
    }
    exit

#---------------------------------------
# Local File Test for MacOS
#---------------------------------------
#
# Please see the ReadMe file for information about file/folder permissions on MacOS.
# https://github.com/seabopo/PowerShell-AtomicParsley/blob/main/README.md
#
    Write-Msg -p -ps -m 'Local File' -fw
    $localFilePath = '/Users/{0}/Movies/Movie (1080p HD).m4v' -f [Environment]::UserName
    $r = Read-AtomicParsleyAtoms -File $localFilePath
    if ( $r.success ) {
        $atoms = $r.value
        $atoms
        $atoms.iTunesMovie
    }
    else {
        Write-Msg -e -ps -m $r.message
    }
    exit

#-----------------------------------------
# Network File Test for MacOS
#-----------------------------------------
#
# This sample assumes you have connected to a network share named 'Media' and it is available on your desktop.
#
    Write-Msg -p -ps -m 'Network File' -fw
    $networkFilePath = '/Volumes/Media/@ Tools/@ [MediaSamples]/Movie (1080p HD).m4v'
    $r = Read-AtomicParsleyAtoms -File $networkFilePath
    if ( $r.success ) {
        $atoms = $r.value
        $atoms
        $atoms.iTunesMovie
    }
    else {
        Write-Msg -e -ps -m $r.message
    }
    exit
