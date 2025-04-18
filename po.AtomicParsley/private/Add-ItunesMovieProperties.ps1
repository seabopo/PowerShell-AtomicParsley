function Add-ItunesMovieProperties {
    <#
    .DESCRIPTION
        Adds a set of properties to the atoms collection based on the lists embedded in the iTunesMovie property.

    .OUTPUTS
        An updated hashtable.

    .PARAMETER Atoms
        REQUIRED. Hashtable. Alias: -a. A hashtable containing a set of metadata / atoms.

    .EXAMPLE
        $atoms | Add-ItunesMovieProperties

    #>
    [OutputType([Hashtable])]
    [CmdletBinding()]
    param (
        [parameter(Mandatory, ValueFromPipeline)] [Alias('a')] [Hashtable] $Atoms
    )

    process {

        Write-Msg -FunctionCall -IncludeParameters

      # Sanitize all linebreaks and whitespace between the xml tags to make the regex easier to work with.
        $movieData = $Atoms.iTunesMovie -Replace '`n','' -Replace '`r','' -replace '\s+', ' ' -replace '> <', '><'

      # Get the names of the string properties to add to the atom list. Example: Studio
        $propertyNames = (([regex]'<key>[a-zA-Z]*<\/key><string>').Matches($movieData) | 
                         Select-Object -Unique -ExpandProperty value) -replace '<[^>]+>','' |
                         Where-Object { $_ -notmatch 'name' }

      # Add the string properties to the atom list.
        foreach ( $property in $propertyNames ) {
            $value = ([regex]('<key>{0}<\/key><string>[^<]*<\/string>' -f $property)).Matches($movieData) |
                     Select-Object -First 1 -ExpandProperty 'value' |
                     ForEach-Object { $_ -replace ('<key>{0}<\/key>' -f $property),'' -replace '<[^>]+>','' }
            $Atoms[$( 'iTunesMovie{0}' -f (Get-Culture).TextInfo.ToTitleCase($property) )] = $value
        }

      # Get the names of the list properties to to add to the the atom list. Example: Cast, Directors, etc.
        $propertyNames = (([regex]'<key>[a-zA-Z]*<\/key><array>').Matches($movieData) | 
                         Select-Object -ExpandProperty value) -replace '<[^>]+>',''
                     
      # Add the list properties to the atom list.
        foreach ( $property in $propertyNames ) {
            [String[]]$value = (([regex]('<key>{0}<\/key><array>(.*?)<\/array>' -f $property)).Matches($movieData) |
                                Select-Object -First 1 -ExpandProperty 'value' ) -split '<dict>' |
                                ForEach-Object {
                                    $name = ([regex]('<string>(.*?)<\/string>')).Matches($_) |
                                            Select-Object -ExpandProperty 'value' |
                                            ForEach-Object { $_ -replace '<[^>]+>','' }
                                    $id = ([regex]('<integer>(.*?)<\/integer>')).Matches($_) |
                                            Select-Object -ExpandProperty 'value' |
                                            ForEach-Object { $_ -replace '<[^>]+>','' }
                                    if ( $null -ne $name ) { $( '{0}:{1}' -f $name, $id ) }
                                }
            $Atoms[$( 'iTunesMovie{0}' -f (Get-Culture).TextInfo.ToTitleCase($property) )] = $value
        }
        
    }

    end {
        Write-Msg -p -ps -m $( 'Function Result: Add-ItunesMovieProperties' )
        Write-Msg -d -il 1 -m $( 'Atom Collection: ') -o $Atoms
        return $Atoms
    }

}
