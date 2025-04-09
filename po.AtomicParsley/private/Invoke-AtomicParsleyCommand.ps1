function Invoke-AtomicParsleyCommand {
    <#
    .DESCRIPTION
        Executes an AtomicParsley command against a file and returns the results.

    .OUTPUTS
        A string array containing the results of the command.

    .PARAMETER FilePath
        REQUIRED. String. Alias: -p. The fully-qualified file path of a file with to read or write iTunes metadata.

    .PARAMETER Command
        REQUIRED. String. Alias: -c. The command line that AtomicParsley should execute. The default value of
        this parameter is '--textdata', which will output the list of atoms defined in the file.

    .PARAMETER SaveToFile
        OPTIONAL. Switch. Alias: -s. Saves the results of the command text file. The file will be located in the
        same directory as the file specified in the FilePath parameter and will have the same name with a
        '.txt' file extension.

    .EXAMPLE
        Invoke-AtomicParsleyCommand -FilePath 'C:\myfile.mp4' -Command '--textdata' -SaveToFile

    .EXAMPLE
        Invoke-AtomicParsleyCommand -p 'C:\myfile.mp4' -c '--textdata' -s

    .NOTES
        Results are returned as a string array of console line results.
    #>
    [OutputType([string[]])]
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('p')] [string] $FilePath,
        [parameter()]                             [Alias('c')] [string] $Command = '--textdata',
        [parameter()]                             [Alias('s')] [switch] $SaveToFile
    )

    process {

        if ( $SCRIPT:AP_INSTALLED ) {

            if ( Test-Path -LiteralPath $FilePath -ErrorAction Ignore ) {

                [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

                $cmd = $( "AtomicParsley `"{0}`" {1}" -f $FilePath, $Command )

                $atoms = Invoke-Cmd -c $cmd -r 0

                if ( -not $atoms.success ) { Throw $atoms.message }

                if ( $SaveToFile ) { $output | Out-File -LiteralPath "FileSystem::$FilePath.txt" }

                $cleanAtoms = $atoms.value | Where-Object { $_ -ne "" }

            }
            else {
                Throw $('The specified file was not found: {0}' -f $FilePath)
                #Write-Msg -e -m 'iTunes data cannot be read or written. The specified file was not found.'
                #Write-Msg -e -il 1 -m $('File Path: {0}', $FilePath)
            }
        }
        else {
            Throw 'iTunes data cannot be read or written. AtomicParsley was not found.'
            #Write-Msg -e -m 'iTunes data cannot be read or written. AtomicParsley was not found.'
        }

        return $cleanAtoms

    }
}
