function Invoke-AtomicParsleyCommand {
    <#
    .DESCRIPTION
        Executes an AtomicParsley command against a file and returns the results.

    .OUTPUTS
        A string array containing the results of the command.

    .PARAMETER File
        REQUIRED. String. Alias: -p. The fully-qualified file path of a file with to read or write iTunes metadata.

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
        Invoke-AtomicParsleyCommand -p 'C:\myfile.mp4' -c '--textdata' -s

    .NOTES
        Results are returned as a string array of console line results.
    #>
    [OutputType([string[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('f')] [string] $File,
        [Parameter()]                            [Alias('c')] [string] $Command = '--textdata',
        [Parameter()]                            [Alias('s')] [switch] $SaveToFile
    )

    process {

        Write-Msg -FunctionCall -IncludeParameters
        
        if ( $SCRIPT:AP_INSTALLED ) {

            if ( Test-Path -LiteralPath $File -ErrorAction Ignore ) {

                Write-Msg -d -il 1 -m $( 'File Exists: {0}' -f $File )

                [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
                $cmd = $( "AtomicParsley `"{0}`" {1}" -f $File, $Command )
                $result = Invoke-Cmd -c $cmd -r 0

                Write-Msg -d -m 'Command Result: ' -il 1 -o $result

                if ( -not $result.success ) { Throw $result.message }

                if ( $SaveToFile ) { $result.value | Out-File -LiteralPath "FileSystem::$File.txt" }

                $cleanResult = $result.value | Where-Object { $_ -ne "" }

            }
            else {
                Throw $('The specified file was not found: {0}' -f $File)
            }
            
        }
        else {
            Throw 'iTunes data cannot be read or written. AtomicParsley was not found.'
        }

        return $cleanResult

    }
}
