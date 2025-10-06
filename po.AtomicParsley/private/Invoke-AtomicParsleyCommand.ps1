function Invoke-AtomicParsleyCommand {
    <#
    .DESCRIPTION
        Executes an AtomicParsley command against a file and returns the results.

    .OUTPUTS
        A string array containing the results of the command.

    .PARAMETER File
        REQUIRED. String. Alias: -f. The fully-qualified file path of a file with to read or write iTunes metadata.

    .PARAMETER Command
        REQUIRED. String. Alias: -c. The command line that AtomicParsley should execute. The default value of
        this parameter is '--textdata', which will output the list of atoms defined in the file.

    .PARAMETER SaveToFile
        OPTIONAL. Switch. Alias: -s. Saves the results of the command text file. The file will be located in the
        same directory as the file specified in the File parameter and will have the same name with a
        '.txt' file extension.

    .EXAMPLE
        Invoke-AtomicParsleyCommand -File 'C:\myfile.mp4' -Command '--textdata' -SaveToFile

    .EXAMPLE
        Invoke-AtomicParsleyCommand -f 'C:\myfile.mp4' -c '--textdata' -s

    .NOTES
        Results are returned as a string array of console line results.
    #>
    [OutputType([String[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('f')] [String] $File,
        [Parameter()]                            [Alias('c')] [String] $Command = '--textdata',
        [Parameter()]                            [Alias('s')] [Switch] $SaveToFile
    )

    process {

        Write-Msg -FunctionCall -IncludeParameters
        
        if ( $SCRIPT:AP_INSTALLED ) {

            if ( Test-Path -LiteralPath $File -ErrorAction Ignore ) {

                Write-Msg -d -il 1 -m $( 'File Exists: {0}' -f $File )

                [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
                $r = Invoke-Cmd -c $( "AtomicParsley `"{0}`" {1}" -f $File, $Command ) -r 0 -x

                Write-Msg -d -m 'Command Result: ' -il 1 -o $r

                if ( $r.success ) {
                    $result = @{ success = $true; value = $( $r.value | Where-Object { $_ -ne "" } ) }
                    if ( $SaveToFile ) { 
                        $r.value | Where-Object { $_.StartsWith('Atom ') -and $_ -notlike "*iTunes;iTunMOVI*" } | 
                                    Sort-Object | Out-File -LiteralPath "FileSystem::$File.txt"
                        $r.value | Where-Object { $_.StartsWith('Atom ') -and $_ -like "*iTunes;iTunMOVI*" } | 
                                    Out-File -LiteralPath "FileSystem::$File.txt" -Append
                        $r.value | Where-Object { -not $_.StartsWith('Atom ') } | 
                                    Out-File -LiteralPath "FileSystem::$File.txt" -Append
                    }
                }
                else {
                    $result = @{ success = $false; message = $r.message }
                }

            }
            else {
                $result = @{ success = $false; message = $('The specified file was not found: {0}' -f $File) }
            }
            
        }
        else {
            $result = @{ success = $false; message = 'Meta-data cannot be read or written. AtomicParsley was not found.' }
        }

        Write-Msg -FunctionResult -o $result

        return $result

    }
}
