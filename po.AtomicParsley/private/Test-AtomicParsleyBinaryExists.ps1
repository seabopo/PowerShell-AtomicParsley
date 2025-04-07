function Test-AtomicParsleyBinaryExists {
    <#
    .DESCRIPTION
        Determines if the AtomicParsley binary is installed.
    #>
    [OutputType([Bool])]
    [CmdletBinding()]
    param ( )

    process {

        try {

            Write-Msg -p -ps -m 'Testing if the AtomicParsley binary is installed ...'

            if ( $null -eq $env:PS_ATOMIC_PARSLEY_PATH ) {
                Write-Msg -d -il 1 -m $( 'AtomicParsley path not set by user.')
                Write-Msg -d -il 2 -m $( 'Environment variable not set: PS_ATOMIC_PARSLEY_PATH' )
                Write-Msg -d -il 2 -m $( 'AtomicParsley will need to be in the system environment path.')
                $env:PS_ATOMIC_PARSLEY_PATH = $PS_ATOMIC_PARSLEY_DEFAULT_PATH
            }
            else {
                Write-Msg -d -il 1 -m $( 'AtomicParsley path set by user.' )
                Write-Msg -d -il 2 -m $( 'Path: {0}' -f $env:PS_ATOMIC_PARSLEY_PATH )
            }

            $test = Invoke-Cmd -c $('{0} -version' -f $env:PS_ATOMIC_PARSLEY_PATH) -r 0 -f -s

            if ( $test.Success ) {
                Write-Msg -d -m $( 'AtomicParsley test was successful.' )
                $PS_ATOMIC_PARSLEY_INSTALLED = $true
            }
            else {
                Write-Msg -d -il 1 -m $( 'AtomicParsley test failed.' )
                Write-Msg -d -il 2 -m $( $test.message )
            }

        }
        catch {
            $errMsg = 'An error occurred while attempting to validate that the AtomicParsley binary is installed.'
            Write-Msg -x -m $( "{0} `r`n" -f $errMsg ) -o $_
        }

        return $PS_ATOMIC_PARSLEY_INSTALLED

    }
}
