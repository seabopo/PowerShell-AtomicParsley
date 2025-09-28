#==================================================================================================================
#==================================================================================================================
# Sample Code :: Write AtomicParsley Atoms
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

using namespace System.Collections.Generic
using namespace System.Collections.Specialized

# Load the standard test initialization file.
. $(Join-Path -Path $PSScriptRoot -ChildPath '_init-test-environment.ps1')

# Override the Default Debug Logging Setting
  # $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

#==================================================================================================================
# Run Tests
#==================================================================================================================

#---------------------------
# Repo Movie Test for MacOS
#---------------------------

    $testFileName = 'Movies/Abominable (2019) [1080p WS iTunes+ HD DD].m4v'
    $testFilePath = Join-Path -Path $mediaPath -ChildPath $testFileName

    Write-Msg -p -fw -ps -m $( 'Processing SOURCE file: {0}' -f $file.Name )

    if ( -not (Test-Path -LiteralPath $testFilePath) ) {
        Write-Msg -e -ps -m $( 'Source file does not exist: {0}' -f $testFilePath )
    }
    else {
        
        Write-Msg -s -ps -m $( 'Source file found: {0}' -f $testFilePath )

        $file       = Get-Item -LiteralPath $testFilePath
        $path       = $file.FullName
        $directory  = $file.DirectoryName
        $name       = $file.BaseName
        $ext        = $file.Extension
        $targetName = '{0} [TEST-COPY]{1}' -f $name, $ext
        $targetPath = Join-Path -Path $directory -ChildPath $targetName

        Write-Msg -p -fw -ps -m $( 'Processing TEST file: {0}' -f $file.Name )

        if ( -not (Test-Path -LiteralPath $targetPath) ) {
            Write-Msg -a -il 1 -m $( 'Test file NOT found: {0}' -f $targetPath )
            Write-Msg -a -il 2 -m $( 'Copying {0}' -f $path )
            Write-Msg -a -il 3 -m $( 'to {0}' -f $targetPath )
            Copy-Item -LiteralPath $path -Destination $targetPath | Out-Null
        }
        else {
            Write-Msg -a -il 1 -m $( 'Test File Found: {0}' -f $targetPath )
        }

        $newAtoms = [SortedDictionary[String,String]]@{
            title         = 'Abominable (2019)'
            mediaType     = 'Movie'
            artist        = 'Jill Culton'
            contentRating = 'PG'
            description   = 'Mischievous friends Yi (Chloe Bennet), Jin, and Peng discover a young yeti on their roof.'
            genre         = 'Kids & Family'
            hdVideo       = '2'
            releaseDate   = '2019-09-27T07:00:00Z'
        }

        Write-Msg -a -il 1 -m $( 'Cleaning TEST file and writing atoms ...' )
        Write-AtomicParsleyAtoms -File $targetPath -Atoms $newAtoms -RemoveAll | Out-Null
        Write-Msg -d -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Reading atoms from TEST file ...' )
        $testAtoms = Read-AtomicParsleyAtoms -File $targetPath # -SaveToFile 
        Write-Msg -d -il 2 -m $( 'Complete.' )

        $testAtoms.remove('RawAtomData') | Out-Null
        $testAtoms.remove('coverArt') | Out-Null
        Write-Msg -s -ps -m $( 'TEST File Atoms:' )
        $testAtoms.keys | ForEach-Object {
            Write-Msg -a -m $( '{0}: {1}' -f $_, $atoms[$_] )
        }

    }

    exit
