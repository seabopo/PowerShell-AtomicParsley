function Read-AtomicParsleyAtoms {
    <#
    .DESCRIPTION
        Returns a collection of iTunes-style metadata from an mp3 or mp4 media file.

    .OUTPUTS
        A hashtable containing the iTunes-style metadata from the file specified in the FilePath parameter.

    .PARAMETER FilePath
        REQUIRED. String. Alias: -p. The fully-qualified file path of a file containing iTunes-style metadata.

    .PARAMETER SaveToFile
        OPTIONAL. Switch. Alias: -s. Saves the metadata to a text file. The file will be located in the same
        directory as the file specified in the FilePath parameter and will have the same name with a '.txt'
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

            $File |
                Invoke-AtomicParsleyCommand -Command '--textdata' -SaveToFile:$SaveToFile |
                    New-AtomicParsleyAtomCollection

            return

        }
        catch {
            Write-Msg -x -o $_
        }

    }

}
