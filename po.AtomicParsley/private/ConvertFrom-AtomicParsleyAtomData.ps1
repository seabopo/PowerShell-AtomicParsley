function ConvertFrom-AtomicParsleyAtomData {
    <#
    .DESCRIPTION
        Converts a single AtomicParsley atom definition to a object key/value pair.

    .OUTPUTS
        A string array containing exactly two elements: the atom id and the atom value.

    .PARAMETER AtomData
        REQUIRED. String. Alias: -d. A string containing a single set of atom data as returned by AtomicParsley.

        Example Data (the function expect a single line on each call):
            Atom "©nam" contains: Movie Title
            Atom "gnre" contains: Comedy
            Atom "©day" contains: 2019-06-14T07:00:00Z
            Atom "desc" contains: In a sleepy small town, something is not quite right.
            Atom "hdvd" contains: 2
            Atom "stik" contains: Movie

    .EXAMPLE
        ConvertFrom-AtomicParsleyAtomData -AtomData 'Atom "©nam" contains: The Dead Don't Die'

    .NOTES
        Atom names come in two formats: "©day" and "---- [com.apple.iTunes;iTunEXTC]".
    #>
    [OutputType(([String],[String]))]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('d')] [String] $AtomData
    )

    begin {
        $knownRdnsAtoms = $Script:AP_ATOMS | Where-Object { $_.AtomDomain -ne 'moov.udta.meta.ilst' } |
                          ForEach-Object { $('{0};{1}' -f $_.AtomDomain, $_.AtomID ) }
    }

    process {

        Write-Msg -FunctionCall -IncludeParameters
        
        if ( $AtomData.StartsWith('Atom ') ) {

            Write-Msg -d -il 1 -m $( 'Data appears to be a valid atom.' )

           #$id,$value = $( ( $AtomData.Replace('"','').Substring(5).Trim() ) -Split " contains: " )
            $atomParts = $AtomData -Split ' contains: '
            $id = $atomParts[0].Replace('"','').Substring(5).Trim()
            $value = $atomParts[1]

            if ( $id.StartsWith('---- [') ) {
                Write-Msg -d -il 1 -m $( 'ReverseDNS atom found.' )
                $id = $id.Substring(6,$id.length - 7)
            }
            else {
                Write-Msg -d -il 1 -m $( 'Standard atom found.' )
            }

            if  ( $knownRdnsAtoms -contains $id ) {
                Write-Msg -d -il 1 -m $( 'ReverseDNS atom is known.' )
                $id = $id.Split(';')[1]
            }

            if ( -not [String]::IsNullOrEmpty($value) ) {
                if ( $value.StartsWith("'") -and $value.EndsWith("'") ) {
                    Write-Msg -d -il 1 -m $( 'Terminating single quotes removed.' )
                    $value = $value.TrimStart("'").TrimEnd("'")
                }
                Write-Msg -d -il 1 -m $( 'Value trimmed.' )
                $value = $value.Trim()
            }

            if ( $id -eq 'iTunEXTC' ) {
                Write-Msg -d -il 1 -m $( 'ReverseDNS atom is iTunEXTC. Filtering value to ContentRating.' )
                $association, $value, $code, $unused = $Value.Split('|')
            }

        }
        else {
            Write-Msg -d -il 1 -m $( 'Data does not appear to be a valid atom.' )
        }

        return $id,$value

    }

}
