function Read-AtomicParsleyAtoms {
    <#
    .DESCRIPTION
        Returns a collection of iTunes-style metadata from an mp3 or mp4 media file.

    .OUTPUTS
        A Hashtable containing the iTunes-style metadata from the specified file.

    .PARAMETER File
        REQUIRED. String. Alias: -f. The fully-qualified file path of a file containing iTunes-style metadata.

    .PARAMETER SaveToFile
        OPTIONAL. Switch. Alias: -s. Saves the metadata to a text file. The file will be located in the same
        directory as the file specified in the File parameter and will have the same name with a '.txt'
        file extension.

    .EXAMPLE
        Read-AtomicParsleyAtoms -FilePath 'C:\myfile.mp4' -SaveToFile

    .EXAMPLE
        Read-AtomicParsleyAtoms -p 'C:\myfile.mp4' -s
    #>
    [OutputType([Hashtable])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)] [Alias('f')] [String] $File,
        [Parameter()]                             [Alias('s')] [Switch] $SaveToFile
    )

    process {

        try {

            Write-Msg -FunctionCall -IncludeParameters

            $r = $File | Invoke-AtomicParsleyCommand -Command '--textdata' -SaveToFile:$SaveToFile 
            if ( $r.success ) {
                $atoms = $r.value | Merge-MultiLineAtoms | 
                                    New-AtomicParsleyAtomCollection | 
                                    Add-ItunesMovieProperties
                $result = @{ success = $true; value = $atoms }
            }
            else {
                $result = $r
            }
            
        }
        catch {
            $result = @{ success = $false; message = $_.Exception.Message; trace = $_.ScriptStackTrace }
        }

        Write-Msg -FunctionResult -o $result

        return $result

    }

}
