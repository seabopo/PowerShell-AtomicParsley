function ConvertTo-UTCstring {
    <#
    .DESCRIPTION
        Converts a date to a UTC string.

    .OUTPUTS
        String.

    .PARAMETER Date
        REQUIRED. String. Alias: -i. A valid iTunes Atom ID.

    .EXAMPLE
        Find-PropertyNameFromAtomID -AtomID '©nam'

    .NOTES
        The function uses an 'endsWith' comparison to match the Atom ID as some of the atoms have special
        characters in the id (for example, '©day') which are sometimes stripped out depending on the OS an
        it's character support.
    #>
    [OutputType([String])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [Alias('d')] $DateValue
    )

    process {

        Write-Msg -FunctionCall -IncludeParameters

        if ( $DateValue -as [datetime] -is [datetime] ) {
            $result = ([datetime]$DateValue).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss'Z'")
        }
        elseif ( $DateValue -as [int] -is [int] -and $DateValue.toString().Length -eq 4 ) {
            $result = $DateValue.ToString()
        }
        else {
            $result = ''
        }

        Write-Msg -FunctionResult -m $( 'PropertyName: {0}' -f $result )

        return $result

    }

}
