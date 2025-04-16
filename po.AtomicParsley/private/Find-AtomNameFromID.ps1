function Find-AtomNameFromID {
    <#
    .DESCRIPTION
        Returns the iTunes metadata property name based on the Atom ID.

    .OUTPUTS
        String. The iTunes atom property name.

    .PARAMETER AtomID
        REQUIRED. String. Alias: -i. A valid iTunes Atom ID.

    .EXAMPLE
        Find-AtomNameFromID -AtomID '©nam'

    .NOTES
        The function uses an 'endsWith' comparison to match the Atom ID as some of the atoms have special
        characters in the id (for example, '©day') which are sometimes stripped out depending on the OS an
        it's character support.
    #>
    [OutputType([string])]
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('i')] [string] $AtomID
    )

    process {

        $Script:AP_ATOMS |
            Where-Object { $_.AtomID.endsWith($AtomID) } |
                Select-Object -ExpandProperty 'PropertyName'

        return

    }

}
