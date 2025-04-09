function ConvertFrom-AtomicParsleyAtomData {
    <#
    .DESCRIPTION
        Converts a single AtomicParsley raw atom data text definition to a key/value pair.

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
    #>
    [OutputType([string],[string])]
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('d')] [String] $AtomData
    )

    begin {
        $atomDomains = @( '---- [com.apple.iTunes;iTun', '---- [org.themoviedb;', '---- [com.thetvdb;', ']')
    }

    process {

        if ( $AtomData.StartsWith('Atom ') ) {

            $id,$value = $( ( $AtomData.Replace('"','').Substring(5).Trim() ) -Split " contains: " )

            $atomDomains | ForEach-Object { $id = $id.Replace($_,'') }

            if ( -not [String]::IsNullOrEmpty($value) ) {
                if ( $value.StartsWith("'") -and $value.EndsWith("'") ) {
                    $value = $value.TrimStart("'").TrimEnd("'")
                }
                $value = $value.Trim()
            }

            if ( $id -eq 'EXTC' ) { $association, $value, $code, $unused = $Value.Split('|') }
        }

        return $id,$value

    }

}
