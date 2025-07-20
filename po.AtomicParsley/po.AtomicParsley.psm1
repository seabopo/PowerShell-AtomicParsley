#==================================================================================================================
#==================================================================================================================
# po.AtomicParsley
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Module Initializations
#==================================================================================================================

using namespace System.Collections.Generic
using namespace System.Collections.Specialized

$ErrorActionPreference = "Stop"

Set-Variable -Scope 'Script' -Name "PS_MODULE_ROOT"  -Value $PSScriptRoot
Set-Variable -Scope 'Script' -Name "PS_MODULE_NAME"  -Value $($PSScriptRoot | Split-Path -Leaf)

Set-Variable -Scope 'Script' -Name "AP_INSTALLED"    -Value $false
Set-Variable -Scope 'Script' -Name "AP_VERSION"      -Value '20240608.083822.1ed9031'
Set-Variable -Scope 'Script' -Name "AP_ATOMS"        -Value $null
Set-Variable -Scope 'Script' -Name "AP_ATOMS_PATH"   -Value $(Join-Path -Path $PSScriptRoot -ChildPath 'data/atoms.csv')

if ( $null -eq $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES ) {
    $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $false
}

if ( $null -eq $env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES ) {
    $env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Header","Process","Information","Debug"]'
}

if ( $null -eq $env:PS_ATOMICPARSLEY_DEFAULTDOMAIN ) {
    $env:PS_ATOMICPARSLEY_DEFAULTDOMAIN = 'com.AtomicParsley'
}

#==================================================================================================================
# Load Functions and Export Public Functions and Aliases
#==================================================================================================================

# Define the root folder source lists for public and private functions
$publicFunctionsRootFolders  = @('Public')
$privateFunctionsRootFolders = @('Private')

# Load all public functions
$publicFunctionsRootFolders | ForEach-Object {
    Get-ChildItem -Path "$PS_MODULE_ROOT/$_/*.ps1" -Recurse | ForEach-Object { . $($_.FullName) }
}

# Export all the public functions and aliases (enable for testing only)
  Export-ModuleMember -Function * -Alias *

# Load all private functions
$privateFunctionsRootFolders | ForEach-Object {
    Get-ChildItem -Path "$PS_MODULE_ROOT/$_/*.ps1" -Recurse | ForEach-Object { . $($_.FullName) }
}

#==================================================================================================================
# Validate AtomicParsley Binary Initialization
#==================================================================================================================

if ( -not $( Test-AtomicParsleyBinaryExists ) ) {
    Show-MissingBinaryMessage
}

#==================================================================================================================
# Load the List of Atomic Parsley Known Atoms
#==================================================================================================================

$Script:AP_ATOMS = Import-Csv -Path $Script:AP_ATOMS_PATH -Delimiter ',' | #-Encoding 'UTF8'
    ForEach-Object {
        $_.WriteSupported = [System.Convert]::ToBoolean($_.WriteSupported)
        $_
    }

Export-ModuleMember -Variable AP_ATOMS
