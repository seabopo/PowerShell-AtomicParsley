#==================================================================================================================
#==================================================================================================================
# Test-AtomicParsleyAtomsReadAndWrite
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Set Test Variables
#==================================================================================================================

$testFileTypes = @('.mp4', '.m4v')


#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Process","Information","Debug"]'
$env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $false

Set-Location  -Path $PSScriptRoot
Push-Location -Path $PSScriptRoot

$projectPath = ((Get-Location).Path -Replace 'PowerShell-AtomicParsley.*','PowerShell-AtomicParsley')
$modulePath  = Join-Path -Path $projectPath -ChildPath 'po.AtomicParsley'
$mediaPath   = Join-Path -Path $projectPath -ChildPath 'test-media'
$repoPath    = $((Get-Item $($projectPath)).Parent.FullName)
$toolkitPath = Join-Path -Path $repoPath -ChildPath 'PowerShell-Toolkit/po.Toolkit'

Import-Module $toolkitPath -Force
Import-Module $modulePath  -Force

#==================================================================================================================
# Read and Write AtomicParsley Atoms
#==================================================================================================================
#
# Loop through the test media folder.
# - Copy each file to a new test file ending with [X] in the name.
# - Read the atoms from the original file.
# - Wipe the atoms from the new file.
# - Write the atoms to the new file.
# - Read the atoms from the new file.
# - Compare the atoms from the original and new file.
#
#==================================================================================================================

Write-Msg -h -ps -b -m $( ' Running AtomicParsley Read/Write Tests' )

Get-ChildItem $mediaPath -Recurse -File | 
    Where-Object {  $_.Extension -in $testFileTypes -and $_.Name -notlike '*[X]*' } |
    Foreach-Object {

        $path       = $_.FullName
        $directory  = $_.DirectoryName
        $name       = $_.BaseName
        $ext        = $_.Extension
        $targetName = '{0} [X]{1}' -f $name, $ext
        $targetPath = Join-Path -Path $directory -ChildPath $targetName
        $shouldCopy = $name.endsWith(' [X]') ? $false : $true

        Write-Msg -a -ps -m $( 'Processing Source file: {0}' -f $path )

        if ( $shouldCopy -and -not (Test-Path -LiteralPath $targetPath) ) {
            Write-Msg -a -il 1 -m $( 'Test file NOT found: {0}' -f $path )
            Write-Msg -a -il 2 -m $( 'Copying {0}' -f $path )
            Write-Msg -a -il 3 -m $( '... to {0}' -f $targetPath )
            Copy-Item -LiteralPath $path -Destination $targetPath
        }
        else {
            Write-Msg -a -il 1 -m $( 'Test file exists: {0}' -f $targetPath )
        }

        Write-Msg -a -il 1 -m $( 'Reading atoms from source file ...' )
        $sourceAtoms = Read-AtomicParsleyAtoms -File $path -SaveToFile
        Write-Msg -a -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Cleaning file and writing atoms ...' )
        Write-AtomicParsleyAtoms -File $targetPath -Atoms $sourceAtoms -RemoveAll | Out-Null
        Write-Msg -a -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Reading atoms from test file ...' )
        $targetAtoms = Read-AtomicParsleyAtoms -File $targetPath -SaveToFile 
        Write-Msg -a -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Comparing atoms ...' )
        foreach ( $atom in $sourceAtoms.keys ) {
            Write-Msg -a -il 2 -m $( 'Checking atom: {0}' -f $atom)
            if ( $atom -eq 'RawAtomData' ) {
                Write-Msg -a -il 3 -m $( 'Skipping RawAtomData atom.' )
            }
            else {
                Write-Msg -a -il 3 -m $( 'Source value: {0}'  -f $sourceAtoms[$atom])
                if ( $targetAtoms.ContainsKey( $atom ) ) {
                    Write-Msg -a -il 3 -m $( 'Target value: {0}' -f $targetAtoms[$atom])
                    if ( $targetAtoms[$atom] -eq $sourceAtoms[$atom] ) {
                        Write-Msg -a -il 2 -m $( 'Atoms match.' )
                    }
                    else {
                        Write-Msg -e -il 2 -m $( 'Atoms do NOT match.' )
                    }
                }
                else {
                    $testAtom = $AP_ATOMS | Where-Object { $_.PropertyName -eq $atom }
                    if ( [String]::IsNullOrEmpty($testAtom) ) {
                    Write-Msg -e -il 3 -m $( 'Source atom is not defined in the atoms data file.' )
                    }
                    else {
                        if ( $testAtom.WriteSupported ) {
                            Write-Msg -e -il 3 -m $( 'Target value: missing' )
                        }
                        else {
                            Write-Msg -w -il 3 -m $( 'Atomic parsley does not support writing this atom.' )
                        }
                    }
                }
            }
        }

    }

exit
