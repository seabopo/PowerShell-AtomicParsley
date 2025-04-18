function Write-AtomicParsleyAtoms {
    <#
    .DESCRIPTION
        Write itunes meta data to an mp4 file.

    .PARAMETER FilePath
        REQUIRED. String. The fully-qualified file path of a file to embedded iTunes atoms.

    .PARAMETER CommandLine
        REQUIRED. String. A complete commandline containing all of the Atomic Parsley parameters and values.

    .EXAMPLE
        Write-AtomicParsleyAtoms -FilePath 'C:\myfile.mp4' -CommandLine "--title `"Gilligan's Island`""

    #>
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('fp')] [string] $FilePath,
        [Parameter()]                             [Alias('cl')] [string] $CommandLine
    )

    Process
    {
        $FilePath |
            Invoke-AtomicParsleyCommand -Command $CommandLine | Out-Null
                return
    }
}
