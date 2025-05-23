function New-AtomicParsleyAtomCollection {
    <#
    .DESCRIPTION
        Returns a hashtable of iTunes atom names and values based on the raw dump of atom ids and values created
        by the AtomicParsley --metadata command.

    .OUTPUTS
        [System.Collections.Generic.SortedDictionary[string,string]] of metadata atoms.

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
        'Atom "©nam" contains: The Dead Don't Die' | New-AtomCollection

    .NOTES
        THIS FUNCTION IS NOT INTENDED TO BE CALLED DIRECTLY. IT IS INTENDED TO BE PIPELINED
        from a string array containing the output of the AtomicParsley --metadata command
        so that only one element of the collection is processed at a time.

        The function processes the atom data one line at a time and returns the hashtable
        only after the pipeline has completed.
    #>
    [OutputType([SortedDictionary[String,String]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('d')] [String] $AtomData
    )

    begin {
        $AtomCollection = [SortedDictionary[String,String]]::new()
        $AtomCollection.Add( 'RawAtomData', "" )
    }

    process {

        Write-Msg -FunctionCall -IncludeParameters

        if ( -not [String]::IsNullOrEmpty($AtomData) ) {

            if ( $AtomData.StartsWith('Atom ') -and $AtomData -like "* contains: *" ) {

                $AtomCollection.RawAtomData += ("{0}`r`n" -f $AtomData)

                $AtomID,$AtomValue = $AtomData | ConvertFrom-AtomicParsleyAtomData
                Write-Msg -d -il 1 -m $( 'Atom ID: {0}' -f $AtomID )
                Write-Msg -d -il 1 -m $( 'Atom Value: {0}' -f $AtomValue )
                $AtomName = $( $AtomID | Find-PropertyNameFromAtomID ) ?? $AtomID

                if ( -not $AtomCollection.ContainsKey($AtomName) ) {
                    $AtomCollection.Add( $AtomName, $AtomValue )
                }
                
            }

        }

    }

    end {
        Write-Msg -r -m $( 'Atom Collection: ') -o $AtomCollection
        Write-Output $AtomCollection
    }

}