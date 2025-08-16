function Write-AtomicParsleyAtoms {
    <#
    .DESCRIPTION
        Writes a collection of iTunes-style metadata to an mp3 or mp4 media file.

    .OUTPUTS
        Boolean indicating if the process was successful or not.

    .PARAMETER File
         REQUIRED. String. Alias: -f. The fully-qualified file path of a file to write iTunes-style metadata.

    .PARAMETER Atoms
        OPTIONAL. System.Collections.Generic.SortedDictionary. Alias: -a. An ordered dictionary containing 
        a set of metadata / atoms.

    .PARAMETER RemoveAll
        OPTIONAL. Switch. Alias: -r. Removes all metadata from the file. If both this parameter and the atoms
        parameter is specified the file will be cleared of all metadata before writing the new metadata.

    .EXAMPLE
        Write-AtomicParsleyAtoms -File 'C:\myfile.mp4' -Atoms $atoms -RemoveAll

    #>
    [OutputType([Boolean])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [Alias('f')] [String] $File,
        [Parameter()]          [Alias('a')] [SortedDictionary[String,String]] $Atoms,
        [Parameter()]          [Alias('r')] [Switch] $RemoveAll
    )

    begin {

        $ignoreList = @( 'RawAtomData' )

    }

    process {

        try {

            Write-Msg -FunctionCall -IncludeParameters

            if ( $RemoveAll ) {
                $cmd = '--metaEnema --overWrite'
                Invoke-AtomicParsleyCommand -Command $cmd -File $File | Out-Null
            }

            if ( $null -ne $Atoms ) {

                $Atoms.Keys | Where-Object { $_ -like @("iTunesMovie*") } |
                              ForEach-Object { $ignoreList += $_.ToString() }

                $parameters = Build-AtomicParsleyParameterList -Atoms $Atoms -IgnoreList $ignoreList

                $parameters += '--overWrite'

                Write-Msg -p -ps -m $( 'Parameters:' )
                $parameters | ForEach-Object {
                    Write-Msg -d -m $_
                }

                Invoke-AtomicParsleyCommand -Command ($parameters -Join ' ') -File $File | Out-Null

            }

            $returnValue = $true

        }
        catch {
            $returnValue = $false
            Write-Msg -x -o $_
        }

        Write-Msg -FunctionResult -m $( 'Atoms Written: {0}' -f $returnValue )

        return $returnValue

    }

}
