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
   $tvShowPath = Join-Path -Path $mediaPath -ChildPath 'TVShows'
   $moviePath  = Join-Path -Path $mediaPath -ChildPath 'Movies'
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
# Project Sample Media
#---------------------------

$testFileTypes = @('.mp4', '.m4v')

Get-ChildItem $mediaPath -Recurse -File | 
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

        Write-Msg -a -il 1 -m $( 'Reading atoms from SOURCE file ...' )
        $sourceAtoms = Read-AtomicParsleyAtoms -File $path -SaveToFile
        if ( $sourceAtoms.ContainsKey('coverArt') ) { 
            $sourceAtoms.Remove('coverArt') | Out-Null
            Write-Msg -a -il 3 -m $( 'Removing coverArt atom.' )
        }
        if ( $sourceAtoms.ContainsKey('RawAtomData') ) { 
            $sourceAtoms.Remove('RawAtomData') | Out-Null
            Write-Msg -a -il 3 -m $( 'Removing RawAtomData atom.' )
        }
        Write-Msg -d -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Cleaning TEST file and writing atoms ...' )
        Write-AtomicParsleyAtoms -File $targetPath -Atoms $sourceAtoms -RemoveAll | Out-Null
        Write-Msg -d -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Reading atoms from TEST file ...' )
        $targetAtoms = Read-AtomicParsleyAtoms -File $targetPath -SaveToFile 
        Write-Msg -d -il 2 -m $( 'Complete.' )

        Write-Msg -a -il 1 -m $( 'Comparing atoms ...' )
        foreach ( $atom in $sourceAtoms.keys ) {
            Write-Msg -a -il 2 -m $( 'Checking atom: {0}' -f $atom)
            if ( $atom -like 'iTunesMovie*' ) {
                Write-Msg -w -il 3 -m $( 'iTunesMovie properties are not supported yet.' )
            }
            else {
                if ( $targetAtoms.ContainsKey( $atom ) ) {
                    $test = $targetAtoms[$atom] -eq $sourceAtoms[$atom]
                    Write-Msg -d -il 3 -m $( 'Source value: {0}'  -f $sourceAtoms[$atom]) -fw:$(-not $test)
                    Write-Msg -d -il 3 -m $( 'Target value: {0}'  -f $targetAtoms[$atom]) -fw:$(-not $test)
                    Write-Msg -sof -il 3 -m $( 'Atoms match: {0}' -f $test ) -ttr $test
                }
                else {
                    Write-Msg -d -il 3 -m $( 'Source value: {0}'  -f $sourceAtoms[$atom])
                    $testAtom = $AP_ATOMS | Where-Object { $_.PropertyName -eq $atom }
                    if ( [String]::IsNullOrEmpty($testAtom) ) {
                        Write-Msg -e -il 3 -m $( 'Target value: Source atom is not defined in the atoms data file.' )
                    }
                    elseif ( $testAtom.WriteSupported -and $testAtom.DataType -eq 'boolean' -and 
                             $sourceAtoms[$atom] -eq 'false' ) 
                    {
                        Write-Msg -w -il 3 -m $( 'Atomic parsley does not support writing false boolean values.' )
                    }
                    elseif ( $testAtom.WriteSupported ) {
                        Write-Msg -e -il 3 -m $( 'Target value: missing' )
                    }
                    else {
                        Write-Msg -w -il 3 -m $( 'Target value: Atomic parsley does not support writing this atom.' )
                    }
                }
            }
        }

    }

    exit
