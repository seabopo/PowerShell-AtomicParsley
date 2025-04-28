#==================================================================================================================
#==================================================================================================================
# Test-AtomicParsleyAtomsReadAndWrite
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Header","Process","Information","Debug"]'
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

Get-ChildItem $mediaPath -Recurse -File | 
    Foreach-Object {

        $path       = $_.FullName
        $directory  = $_.DirectoryName
        $name       = $_.BaseName
        $ext        = $_.Extension
        $targetName = '{0} [X]{1}' -f $name, $ext
        $targetPath = Join-Path -Path $directory -ChildPath $targetName
        $shouldCopy = $name.endsWith(' [X]') ? $false : $true

        Write-Msg -s -ps -m $( 'Processing Source file: {0}' -f $path )

        if ( $shouldCopy -and -not (Test-Path -LiteralPath $targetPath) ) {
            Write-Msg -a -il 1 -m $( 'Test file NOT found: {0}' -f $path )
            Write-Msg -a -il 2 -m $( 'Copying {0}' -f $path )
            Write-Msg -a -il 3 -m $( '... to {0}' -f $targetPath )
            Copy-Item -LiteralPath $path -Destination $targetPath
        }
        else {
            Write-Msg -a -il 1 -m $( 'Test file exists: {0}' -f $targetPath )
        }

        $atoms = Read-AtomicParsleyAtoms -File $path -SaveToFile
        Write-AtomicParsleyAtoms -File $targetPath -Atoms $atoms -RemoveAll
        Read-AtomicParsleyAtoms -File $targetPath -SaveToFile | Out-Null

    }

exit
