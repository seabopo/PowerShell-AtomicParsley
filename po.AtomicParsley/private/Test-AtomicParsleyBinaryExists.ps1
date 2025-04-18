function Test-AtomicParsleyBinaryExists {
    <#
    .DESCRIPTION
        Determines if the AtomicParsley binary is installed and available in the system path.

    .OUTPUTS
        Boolean. True if the AtomicParsley binary is installed and available in the system path, otherwise false.

    .EXAMPLE
        Test-AtomicParsleyBinaryExists
    #>
    [OutputType([Bool])]
    [CmdletBinding()]
    param ( )

    process {

        try {

            Write-Msg -FunctionCall

            $test = Invoke-Cmd -c $( 'AtomicParsley -version' ) -r 0 -f -s
            if ( $test.Success ) {
                Write-Msg -d -il 1 -m $( 'AtomicParsley found. Test successful.' )
                $Script:AP_INSTALLED = $true
            }
            else {
                Write-Msg -d -il 1 -m $( 'AtomicParsley NOT found. Test failed.' )
                Write-Msg -d -il 2 -m $( $test.message )
            }

        }
        catch {
            $errMsg = 'An error occurred while attempting to validate that the AtomicParsley binary is installed.'
            Write-Msg -x -m $( "{0} `r`n" -f $errMsg ) -o $_
        }

        return $Script:AP_INSTALLED

    }
}
