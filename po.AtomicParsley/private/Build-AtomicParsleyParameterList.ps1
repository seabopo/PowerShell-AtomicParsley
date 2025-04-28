function Build-AtomicParsleyParameterList {
    <#
    .DESCRIPTION
        Creates a list of AtomicParsley parameters based on a collection of atoms.

    .OUTPUTS
        Array of strings containing the parameters to be passed to AtomicParsley.

    .PARAMETER Atoms
        OPTIONAL. System.Collections.Generic.SortedDictionary. Alias: -a. An ordered dictionary containing 
        a set of metadata / atoms.

    .PARAMETER IgnoreList
        OPTIONAL. Array of String. Alias: -i. A list of parameter names to ignore when creating the parameter list.

    .EXAMPLE
        Build-AtomicParsleyParameterList -Atoms $atoms -IgnoreList @('RawAtomData')

    #>
    [OutputType([String[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [Alias('a')] [SortedDictionary[String,String]] $Atoms,
        [Parameter()]          [Alias('i')] [String[]] $IgnoreList
    )

    process {

        try {

            Write-Msg -FunctionCall -IncludeParameters

            if ( $null -ne $Atoms ) {

                [String[]] $parameters = @() 
                $Atoms.Keys | Where-Object { $_ -notin $ignoreList } | 
                    ForEach-Object {
                    
                        $propertyName = $_
                        $parameterName, $dataType = Find-ParameterFromPropertyName -n $propertyName -d
                        $propertyValue = switch ( $dataType ) {
                            "string"         { '"' + ($Atoms[$propertyName]).Replace('"','""') + '"'     }
                            "url"            { '"' + $Atoms[$propertyName] + '"'                         }
                            "numberOfnumber" { $Atoms[$propertyName].Replace(' of ','/').Replace(' ','') }
                            "datetime"       { $Atoms[$propertyName].Replace(' ','T')                    }
                            default          { $Atoms[$propertyName]                                     }
                        }

                        if ( $parameterName.StartsWith('name=') ) {
                            $parameter = '--rDNSatom ' + $propertyValue + ' ' + $parameterName
                        }
                        else {
                            $parameter = '--' + $parameterName + ' ' + $propertyValue
                        }
                        
                        Write-Msg -FunctionResult -m $( 'Parameter: ' + $parameter )

                        $parameters += $parameter

                    }

                Write-Msg -p -ps -m $( 'Parameters:' )
                $parameters | ForEach-Object {
                    Write-Msg -d -m $_
                }

            }

        }
        catch {
            Write-Msg -x -o $_
        }

        return  $parameters

    }
    
}
