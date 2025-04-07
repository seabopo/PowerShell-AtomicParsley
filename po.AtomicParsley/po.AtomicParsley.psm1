#==================================================================================================================
#==================================================================================================================
# po.AtomicParsley
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Module Initializations
#==================================================================================================================

$ErrorActionPreference = "Stop"

Set-Variable -Scope 'Local' -Name "PS_MODULE_ROOT" -Value $PSScriptRoot
Set-Variable -Scope 'Local' -Name "PS_MODULE_NAME" -Value $($PSScriptRoot | Split-Path -Leaf)

Set-Variable -Scope 'Local' -Name "PS_ATOMIC_PARSLEY_INSTALLED"    -Value $false
Set-Variable -Scope 'Local' -Name "PS_ATOMIC_PARSLEY_VERSION"      -Value '20240608.083822.1ed9031'
Set-Variable -Scope 'Local' -Name "PS_ATOMIC_PARSLEY_DEFAULT_PATH" -Value $('AtomicParsley')

#Set-Variable -Scope 'Local' -Name "PS_ATOMIC_PARSLEY_DEFAULT_PATH" -Value $('{0}/bin/AtomicParsley' -f $PS_MODULE_ROOT)
#if ( $isWindows ) { $PS_ATOMIC_PARSLEY_DEFAULT_PATH += '.exe' }

if ( $null -eq $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES ) {
    $env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $false
}

if ( $null -eq $env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES ) {
    $env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Header","Process","Information","Debug"]'
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
