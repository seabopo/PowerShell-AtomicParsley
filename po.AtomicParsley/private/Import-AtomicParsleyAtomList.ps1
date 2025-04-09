function Import-AtomicParsleyAtomList {
    <#
    .DESCRIPTION
        Returns a hashtable of the iTunes atoms supported by AtomicParsley for ID / Name / command-line
        parameter lookups.

    .OUTPUTS
        A hashtable of know atoms supported by AtomicParsley.

    .EXAMPLE
        Import-AtomicParsleyAtomList
    #>
    [OutputType([hashtable])]
    [CmdletBinding()]
    param()

    return @{
        "Title"               = @{ Name = "Title";               ID = "©nam"; Parameter = "title" }
        "Description"         = @{ Name = "Description";         ID = "desc"; Parameter = "description" }
        "LongDescription"     = @{ Name = "LongDescription";     ID = "ldes"; Parameter = "longdesc" }
        "GenrePredefined"     = @{ Name = "GenrePredefined";     ID = "gnre"; Parameter = "genre" }
        "GenreUserdefined"    = @{ Name = "GenreUserdefined";    ID = "©gen"; Parameter = "genre" }
        "ItunesGenre"         = @{ Name = "ItunesGenre";         ID = "geID"; Parameter = "geID" }
        "ReleaseDate"         = @{ Name = "ReleaseDate";         ID = "©day"; Parameter = "year" }
        "Rating"              = @{ Name = "Rating";              ID = "EXTC"; Parameter = "contentRating" }
        "EmbeddedData"        = @{ Name = "EmbeddedData";        ID = "MOVI"; Parameter = "" }

        "TVShowName"          = @{ Name = "TVShowName";          ID = "tvsh"; Parameter = "TVShowName" }
        "TVEpisodeID"         = @{ Name = "TVEpisodeID";         ID = "tven"; Parameter = "TVEpisode" }
        "TVSeasonNumber"      = @{ Name = "TVSeasonNumber";      ID = "tvsn"; Parameter = "TVSeasonNum" }
        "TVSeasonDescription" = @{ Name = "TVSeasonDescription"; ID = "sdes"; Parameter = "storedesc" }
        "TVEpisodeNumber"     = @{ Name = "TVEpisodeNumber";     ID = "tves"; Parameter = "TVEpisodeNum" }
        "TVNetwork"           = @{ Name = "TVNetwork";           ID = "tvnn"; Parameter = "TVNetwork" }

        "HDVideo"             = @{ Name = "HDVideo";             ID = "hdvd"; Parameter = "hdvideo" }
        "Flavor"              = @{ Name = "Flavor";              ID = "flvr"; Parameter = "" }
        "MediaType"           = @{ Name = "MediaType";           ID = "stik"; Parameter = "stik" }
        "iTunesCatalogID"     = @{ Name = "iTunesCatalogID";     ID = "cnID"; Parameter = "cnID" }
        "Copyright"           = @{ Name = "Copyright";           ID = "cprt"; Parameter = "copyright" }
        "CoverArt"            = @{ Name = "CoverArt";            ID = "covr"; Parameter = "artwork" }
        "Keywords"            = @{ Name = "Keywords";            ID = "keyw"; Parameter = "keyword" }
        "Category"            = @{ Name = "Category";            ID = "catg"; Parameter = "category" }
        "UserRating"          = @{ Name = "UserRating";          ID = "rate"; Parameter = "Rating" }

        "Comment"             = @{ Name = "Comment";             ID = "©cmt"; Parameter = "comment" }
        "Album"               = @{ Name = "Album";               ID = "©alb"; Parameter = "album" }
        "Grouping"            = @{ Name = "Grouping";            ID = "©grp"; Parameter = "grouping" }
        "EncodingTool"        = @{ Name = "EncodingTool";        ID = "©too"; Parameter = "encodingTool" }
        "EncodedBy"           = @{ Name = "EncodedBy";           ID = "©enc"; Parameter = "encodedBy" }

        "PurchaseDate"        = @{ Name = "PurchaseDate";        ID = "purd"; Parameter = "purchaseDate" }
        "PurchaseAccount"     = @{ Name = "PurchaseAccount";     ID = "apID"; Parameter = "apID" }
        "PurchaseName"        = @{ Name = "PurchaseName";        ID = "ownr"; Parameter = "" }
        "AccountType"         = @{ Name = "AccountType";         ID = "akID"; Parameter = "" }
        "CountryCode"         = @{ Name = "CountryCode";         ID = "sfID"; Parameter = "" }
        "VendorID"            = @{ Name = "VendorID";            ID = "xid "; Parameter = "xID" }

        "Unknown1"            = @{ Name = "Unknown1";            ID = "atID"; Parameter = "" }
        "Unknown2"            = @{ Name = "Unknown2";            ID = "plID"; Parameter = "" }

        "Artist"              = @{ Name = "Artist";              ID = "©ART"; Parameter = "artist" }
        "AlbumArtist"         = @{ Name = "AlbumArtist";         ID = "aART"; Parameter = "albumArtist" }
        "Composer"            = @{ Name = "Composer";            ID = "©wrt"; Parameter = "composer" }

        "Compilation"         = @{ Name = "Compilation";         ID = "cpil"; Parameter = "compilation" }
        "TrackNumber"         = @{ Name = "TrackNumber";         ID = "trkn"; Parameter = "tracknum" }
        "DiscNumber"          = @{ Name = "DiscNumber";          ID = "disk"; Parameter = "disk" }

        "Lyrics"              = @{ Name = "Lyrics";              ID = "©lyr"; Parameter = "lyrics" }
        "Tempo"               = @{ Name = "Tempo";               ID = "tmpo"; Parameter = "bpm" }
        "AdvisoryRating"      = @{ Name = "AdvisoryRating";      ID = "rtng"; Parameter = "advisory" }
        "GaplessPlayback"     = @{ Name = "GaplessPlayback";     ID = "pgap"; Parameter = "gapless" }

        "SortName"            = @{ Name = "SortName";            ID = "sonm"; Parameter = "sortOrder name" }
        "SortShow"            = @{ Name = "SortShow";            ID = "sosn"; Parameter = "sortOrder show" }
        "SortAlbum"           = @{ Name = "SortAlbum";           ID = "soal"; Parameter = "sortOrder album" }
        "SortAlbumArtist"     = @{ Name = "SortAlbumArtist";     ID = "soaa"; Parameter = "sortOrder albumartist" }
        "SortArtist"          = @{ Name = "SortArtist";          ID = "soar"; Parameter = "sortOrder artist" }
        "SortComposer"        = @{ Name = "SortComposer";        ID = "soco"; Parameter = "sortOrder composer" }

        "Podcast"             = @{ Name = "Podcast";             ID = "pcst"; Parameter = "podcastFlag" }
        "PodcastURL"          = @{ Name = "PodcastURL";          ID = "purl"; Parameter = "podcastURL" }
        "PodcastID"           = @{ Name = "PodcastID";           ID = "egid"; Parameter = "podcastGUID" }

        "TMdbID"              = @{ Name = "TMdbID";              ID = "TMdbID";  Parameter = "" }
        "TMdbSeriesID"        = @{ Name = "TMdbSeriesID";        ID = "TMdbSID"; Parameter = "" }

        "TVdbID"              = @{ Name = "TVdbID";              ID = "TVdbID";  Parameter = "" }
        "TVdbSeriesID"        = @{ Name = "TVdbSeriesID";        ID = "TVdbSID"; Parameter = "" }
    }
}
