#==================================================================================================================
#==================================================================================================================
# Sample Code :: Write AtomicParsley Atoms
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

    $testFile = '/Users/{0}/Movies/Movie (1080p HD).m4v' -f [Environment]::UserName

    if ( -not (Test-Path -LiteralPath $testFile) ) {
        Write-Msg -e -ps -m $( 'Source file does not exist: {0}' -f $testFile )
    }
    else {

        Write-Msg -s -ps -m $( 'Source file found: {0}' -f $testFile )

        $file       = Get-Item $testFile
        $path       = $file.FullName
        $directory  = $file.DirectoryName
        $name       = $file.BaseName
        $ext        = $file.Extension
        $targetName = '{0} [X]{1}' -f $name, $ext
        $targetPath = Join-Path -Path $directory -ChildPath $targetName

        if ( -not (Test-Path -LiteralPath $targetPath) ) {
            Write-Msg -a -il 1 -m $( 'Test file NOT found: {0}' -f $targetPath )
            Write-Msg -a -il 2 -m $( 'Copying {0}' -f $path )
            Write-Msg -a -il 3 -m $( 'to {0}' -f $targetPath )
            Copy-Item -LiteralPath $path -Destination $targetPath | Out-Null
        }
        else {
            Write-Msg -a -il 1 -m $( 'Test File Found: {0}' -f $targetPath )
        }

        $atoms = Read-AtomicParsleyAtoms -File $path -SaveToFile
        $atoms.remove('RawAtomData') | Out-Null
        Write-Msg -s -ps -m $( 'Source File Atoms:' )
        $atoms.keys | ForEach-Object {
            Write-Msg -a -m $( '{0}: {1}' -f $_, $atoms[$_] )
        }

        Write-AtomicParsleyAtoms -File $targetPath -Atoms $atoms -RemoveAll | Out-Null
        $atoms = Read-AtomicParsleyAtoms -File $targetPath -SaveToFile
        $atoms.remove('RawAtomData')
        Write-Msg -s -ps -m $( 'Target File Atoms:' )
        $atoms.keys | ForEach-Object {
            Write-Msg -a -m $( '{0}: {1}' -f $_, $atoms[$_] )
        }

    }

    exit
