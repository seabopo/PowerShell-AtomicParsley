function New-AtomicParsleyAtomCollection {
    <#
    .DESCRIPTION
        Returns a hashtable of iTunes atom names and values based on the raw dump of atom ids and values created
        by the AtomicParsley --metadata command.

    .OUTPUTS
        A hashtable containing the iTunes metadata of a media file.

    .PARAMETER AtomData
        REQUIRED. String. Alias: -d. A string containing a single line item of atom data returned by the
        AtomicParsley --metadata command.

        Example Data (the function expect a single line on each call):
            Atom "©nam" contains: Movie Title
            Atom "gnre" contains: Comedy
            Atom "©day" contains: 2019-06-14T07:00:00Z
            Atom "desc" contains: In a sleepy small town, something is not quite right.
            Atom "hdvd" contains: 2
            Atom "stik" contains: Movie

    .EXAMPLE
        New-AtomCollection -AtomData 'Atom "©nam" contains: The Dead Don't Die'

    .NOTES
        THIS FUNCTION IS NOT INTENDED TO BE CALLED DIRECTLY. IT IS INTENDED TO BE PIPELINED
        from a string array containing the output of the AtomicParsley --metadata command.

        The function processes the atom data one line at a time and returns the hashtable
        only after the pipeline has completed. Don't fee the output of this function to
        another function if you want the output to be a hashtable containing the full
        collection of metadata.
    #>
    [OutputType([hashtable[]])]
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('d')] [String] $AtomData
    )

    begin {
        [Hashtable] $AtomCollection = @{ RawAtomData = ""; UnknownAtoms = "" }
    }

    process {

        if ( -not [string]::IsNullOrEmpty($AtomData) ) {

            if ( $AtomData.StartsWith('Atom ') -and $AtomData -like "* contains: *" ) {

                $AtomCollection.RawAtomData += ("{0}`r`n" -f $AtomData)

                $AtomID,$AtomValue = $AtomData | ConvertFrom-AtomicParsleyAtomData
                $AtomName = $AtomID | Find-AtomNameFromID

                if ( [string]::IsNullOrEmpty($AtomName) ) {
                    $AtomCollection.UnknownAtoms += ("{0} :: {1}`r`n" -f $AtomID,$AtomValue)
                }
                else {
                    if ( -not $AtomCollection.ContainsKey($AtomName) ) {
                        $AtomCollection.Add( $AtomName, $AtomValue )
                    }
                }

            }

        }

    }

    end {
        return $AtomCollection
    }

}