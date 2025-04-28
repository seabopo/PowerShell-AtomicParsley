function Find-ParameterFromPropertyName {
    <#
    .DESCRIPTION
        Returns the AtomicParsley parameter name based on the iTunes metadata property name.

    .OUTPUTS
        String. The AtomicParsley parameter name.

    .PARAMETER PropertyName
        REQUIRED. String. Alias: -n. A valid iTunes metadata property name.

    .EXAMPLE
        Find-ParameterFromPropertyName -PropertyName 'title'

    .NOTES
        If the property name is not found in the list of known iTunes metadata property names
        the function will return the property name as is, and it will be added to the media
        file as a custom property. In this case, the property name should be in the reverseDNS
        format (for example, 'com.myApp;myProperty').
    #>
    [OutputType([String])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('n')] [String] $PropertyName,
        [Parameter()]                            [Alias('d')] [Switch] $IncludeDataType
    )

    process {

        Write-Msg -FunctionCall -IncludeParameters

        $atom = $Script:AP_ATOMS | Where-Object { $_.PropertyName -eq $PropertyName }
        if ( [String]::IsNullOrEmpty($atom) ) {
            Write-Msg -d -il 1 -m $( 'Custom Atom Found: {0}' -f $PropertyName )
            $type = 'string'
            $nameParts = $PropertyName -Split ';'
            if ( $nameParts.count -eq 2 ) {
                $name = 'name={0} domain={1}' -f $nameParts[1], $nameParts[0]
            }
            else {
                $name = 'name={0} domain={1}' -f $nameParts[0], $env:PS_ATOMICPARSLEY_DEFAULTDOMAIN
            }
        }
        else {
            Write-Msg -d -il 1 -m $( 'Known Atom Found: {0}' -f $PropertyName )
            $type = $atom.DataType
            if ( [String]::IsNullOrEmpty($atom.ParameterName) ) {
                $name = 'name={0} domain={1}' -f $atom.AtomID, $atom.AtomDomain
            }
            else {
                $name = $atom.ParameterName
            }
        }

        Write-Msg -d -il 1 -m $( 'Property: {0} => Parameter: {1}' -f $PropertyName, $($name ?? '<Not Found>') )
        Write-Msg -d -il 1 -m $( 'DataType: {0}' -f $type )

        if ( $IncludeDataType ) { return $name,$type } else { return $name }

    }

}
