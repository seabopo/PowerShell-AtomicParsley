function Build-iTunesMovieXML {
    <#
    .DESCRIPTION
        Rebuilds the plist XML document embedded in a media file's "iTunesMovie" atom
        (AtomID iTunMOVI, domain com.apple.iTunes) from its flattened components — lists of
        Cast/CoDirectors/Directors/Producers/Screenwriters in "Name:adamId" CSV strings.

    .OUTPUTS
        [String] The plist XML document suitable for writing back as the iTunesMovie atom's value.

    .PARAMETER Atoms
        REQUIRED. Hashtable. Alias: -a. A collection of metadata / atoms in name/value pairs.

    .EXAMPLE
        Build-iTunesMovieXML -Atoms $atoms
    #>
    [OutputType([String])]
    [CmdletBinding()]
    param (
        [Parameter()] [Alias('a')] [Hashtable] $Atoms
    )

    begin {

      # Rebuilds a single "<key>role</key><array>...</array>" item from the "Name:adamId" string.
        function ConvertTo-PersonArrayXml ( [String[]] $People ) {
            if ( -not $People -or $People.Count -eq 0 ) { return '<array/>' }
            $entries = $People | ForEach-Object {
                $name, $id = $_ -split ':', 2
                if ( [string]::IsNullOrEmpty($id) ) {
                    "`t`t<dict>`n`t`t`t<key>name</key>`n`t`t`t<string>$name</string>`n`t`t</dict>"
                } else {
                    "`t`t<dict>`n`t`t`t<key>adamId</key>`n`t`t`t<integer>$id</integer>`n`t`t`t<key>name</key>`n`t`t`t<string>$name</string>`n`t`t</dict>"
                }
            }
            "<array>`n$($entries -join "`n")`n`t</array>"
        }

    }

    process {

        Write-Msg -FunctionCall -IncludeParameters

        $xml = @"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>cast</key>
	$(ConvertTo-PersonArrayXml $Atoms.iTunesMovieCast)
	<key>codirectors</key>
	$(ConvertTo-PersonArrayXml $Atoms.iTunesMovieCoDirectors)
	<key>directors</key>
	$(ConvertTo-PersonArrayXml $Atoms.iTunesMovieDirectors)
	<key>producers</key>
	$(ConvertTo-PersonArrayXml $Atoms.iTunesMovieProducers)
	<key>screenwriters</key>
	$(ConvertTo-PersonArrayXml $Atoms.iTunesMovieScreenwriters)
	<key>studio</key>
	<string>$($Atoms.iTunesMovieStudio)</string>
</dict>
</plist>
"@

        Write-Msg -FunctionResult -m 'iTunesMovie XML rebuilt.'

        return $xml

    }

}
