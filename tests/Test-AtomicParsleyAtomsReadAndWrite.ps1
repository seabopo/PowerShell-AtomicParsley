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
  $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

#==================================================================================================================
# Run Tests
#==================================================================================================================

#---------------------------
# Project Sample Media
#---------------------------

$testFileTypes = @('.mp4', '.m4v')

Get-ChildItem $moviePath -Recurse -Depth 2 -File |
    Where-Object {  $_.Extension -in $testFileTypes -and $_.Name -notlike '*`[TEST-COPY`]*' } |
    ForEach-Object {

        $path       = $_.FullName
        $directory  = $_.DirectoryName
        $name       = $_.BaseName
        $ext        = $_.Extension
        $targetName = '{0} [TEST-COPY]{1}' -f $name, $ext
        $targetPath = Join-Path -Path $directory -ChildPath $targetName

        Write-Msg -p -fw -ps -m $( 'Processing SOURCE file: {0}' -f $_.Name )

        if ( -not (Test-Path -LiteralPath $targetPath) ) {
            Write-Msg -a -il 1 -m $( 'TEST file NOT found: {0}' -f $targetName )
            Write-Msg -a -il 2 -m $( 'Copying {0}' -f $path )
            Write-Msg -a -il 3 -m $( '... to {0}' -f $targetPath )
            Copy-Item -LiteralPath $path -Destination $targetPath
        }
        else {
            Write-Msg -a -il 1 -m $( 'TEST file exists: {0}' -f $targetName )
        }

        Write-Msg -p -fw -ps -m $( 'Reading atoms from SOURCE file ...' )
        $r = Read-AtomicParsleyAtoms -File $path # -SaveToFile
        if ( $r.success ) {
            $sourceAtoms = $r.value
        }
        else {
            Write-Msg -e -m $r.message
            exit
        }
        if ( $sourceAtoms.ContainsKey('coverArt') ) { 
            $sourceAtoms.Remove('coverArt') | Out-Null
            Write-Msg -a -il 1 -m $( 'Removing coverArt atom.' )
        }
        if ( $sourceAtoms.ContainsKey('RawAtomData') ) { 
            $sourceAtoms.Remove('RawAtomData') | Out-Null
            Write-Msg -a -il 1 -m $( 'Removing RawAtomData atom.' )
        }
        Write-Msg -d -il 1 -m $( 'Complete.' )

        Write-Msg -p -ps -fw -m $( 'Cleaning TEST file and writing atoms ...' )
         $r = Write-AtomicParsleyAtoms -File $targetPath -Atoms $sourceAtoms -RemoveAll
        Write-Msg -d -il 1 -m $( 'Complete.' )
        if ( -not $r.success ) {
            Write-Msg -e -m $r.message
            exit
        }

        Write-Msg -p -ps -fw  -m $( 'Reading atoms from TEST file ...' )
        $r = Read-AtomicParsleyAtoms -File $targetPath -SaveToFile 
        Write-Msg -d -il 1 -m $( 'Complete.' )
        if ( $r.success ) {
            $targetAtoms = $r.value
        }
        else {
            Write-Msg -e -m $r.message
            exit
        }

        Write-Msg -p -ps -fw -m $( 'Comparing atoms ...' )
        foreach ( $atom in $sourceAtoms.keys ) {
            Write-Msg -a -il 1 -m $( 'Checking atom: {0}' -f $atom)
            if ( $atom -like 'iTunesMovie*' ) {
                Write-Msg -w -il 2 -m $( 'iTunesMovie properties are not supported yet.' )
            }
            else {
                if ( $targetAtoms.ContainsKey( $atom ) ) {
                    $test = $targetAtoms[$atom] -eq $sourceAtoms[$atom]
                    Write-Msg -d -il 2 -m $( 'Source value: {0}'  -f $sourceAtoms[$atom]) -fw:$(-not $test)
                    Write-Msg -d -il 2 -m $( 'Target value: {0}'  -f $targetAtoms[$atom]) -fw:$(-not $test)
                    Write-Msg -sof -il 2 -m $( 'Atoms match: {0}' -f $test ) -ttr $test
                }
                else {
                    Write-Msg -d -il 2 -m $( 'Source value: {0}'  -f $sourceAtoms[$atom])
                    $testAtom = $AP_ATOMS | Where-Object { $_.PropertyName -eq $atom }
                    if ( -not $testAtom.WriteSupported ) {
                        Write-Msg -w -il 2 -m $( 'Target value: Atomic parsley does not support writing this atom.' )
                    }
                    elseif ( [String]::IsNullOrEmpty($sourceAtoms[$atom]) ) {
                        Write-Msg -d -il 2 -m $( 'Target value: <not in collection>')
                        Write-Msg -w -il 2 -m $( 'AtomicParsley removes an atom when the value is null.' )
                    }
                    elseif ( $testAtom.DataType -eq 'boolean' -and $sourceAtoms[$atom] -eq 'false' ) {
                        Write-Msg -d -il 2 -m $( 'Target value: <not in collection>')
                        Write-Msg -w -il 2 -m $( 'Atomic parsley does not support writing false boolean atoms.' )
                    }
                    else {
                        Write-Msg -e -il 2 -m $( 'Target value: Source atom is not defined in the atoms data file.' )
                    }
                }
            }
        }

    }

    exit
