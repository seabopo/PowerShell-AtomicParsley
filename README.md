# AtomicParsley PowerShell Module

## Description
This module is an interface to the AtomicParsley command-line tool created by Wez Furlong. This open source
project is available on Github (https://github.com/wez/atomicparsley) under the GPL-2.0 License. 

AtomicParsley is a lightweight command line program for reading and setting iTunes-style metadata in MPEG-3 and
MPEG-4 files. 

This module uses a customized version of AtomicParsley which merges features of several forks into a single release.

## AtomicParsley Installation

On MacOS, the AtomicParsley binary can be installed using Homebrew with the following command: 
    
    $ brew install atomicparsley'

Homebrew installation documentation can be found here: https://docs.brew.sh/Installation
    
On Windows, the AtomicParsley binary can be installed using Chocolatey with the following command: 

    $ choco install atomicparsley

Chocolatey installation documentation can be found here: https://chocolatey.org/install

Windows systems also need the [Visual C++ Redistributable for Visual Studio 2015](
  https://www.microsoft.com/en-us/download/details.aspx?id=48145) installed.

Users of all operating systems can download the latest version from the releases page of the project site: 

    https://github.com/wez/atomicparsley/releases

When installing AtomicParsley using Homebrew or Chocolatey, the AtomicParsley path will automatically be added to 
the operating system PATH environment variable so the tool can be run using the terminal or command-prompt from 
any location on the system. If AtomicParsley was installed manually you will need to update your operating system
environment path to include the AtomicParsley path for the module to function.

## File Permissions on MacOS

MacOS has 'Special Folders' like Downloads, Desktop, and Movies in the user's personal folder that require 
additional permissions to be granted for applications to access their content. If your video files are located 
in the 'Movies' folder under your user profile, AtomicParsley  and PowerShell must be granted access to the folder. 
You can do this by adding the applications to the list of allowed applications in 
System Settings > Privacy and Security > Media & Apple Music.

If you use Apple's "TV" app, it will create a folder under the Movies folder by default at /Users/Username/Movies/TV
and store all of it's media there. The "TV" folder has it's own set of special permissions, and the files in that 
folder won't be accessible by apps even after enabling the additional permissions via the "Media & Apple Music"
setting. 

## AtomicParsley Project Information

### AtomicParsley SOURCES
https://github.com/wez/atomicparsley
https://sourceforge.net/projects/atomicparsley/files/

### AtomicParsley DOCUMENTATION
Current: https://github.com/wez/atomicparsley  
Older:   http://atomicparsley.sourceforge.net/

### Atom Definitions
[Apple Developer Documentation](
  https://developer.apple.com/library/mac/documentation/QuickTime/qtff/QTFFChap2/qtff2.html)

### AtomicParsley Version Information
```
--------------  ------  ----------  --  ----  --  -----------------------------------
Version         Size    Build Date  HD  rDNS  CR  Notes
--------------  ------  ----------  --  ----  --  -----------------------------------
MetaX           160 KB  2/27/2010   N    Y?
0.9.3 (Wez)     578 KB  7/10/2010   Y?   Y?   Y?  May Remove TV Ratings
0.9.4 (Wez)     412 KB  10/16/2011  Y?   Y?   Y?  Adds --Rating
0.9.4 (HG)      438 KB  6/23/2011   Y?   Y?   Y?  Adds --lyricsFile, --Rating, --geID, --xID
0.9.4 (HG 095)  457 KB  11/7/2011   Y?   Y?   Y?
0.9.4 (HG 103)  462 KB  12/9/2012   Y?   Y?   Y?
0.9.6 (HG 109)  365 KB  6/27/2014   Y?   Y?   Y?  Fixes Movie/Short Type. Does 
                                                  everything but 1080p Atom Value of 2

My Version      469 KB  7/13/2014   +/-  Y   +/-  Forked, Does Everything: 
                                                  Remove All, 1080p HD, rDNS Atoms, 
                                                  uses the --Rating parameter to add 
                                                  the Content Rating instead of
                                                  using the rDNS atom method.
                                                  Must re-add to iTunes to see 
                                                  ATOM removal.

 ?   = partial functionality (may only add or delete)
HD   = Includes the --hdvideo parameter. Only sets SD/HD (boolean value) unless noted.
CR   = Includes the --Rating parameter, to add the Content Rating atom, which adds 
       TV/Movie ratings without having to use the rDNS method.
rDNS = Supports adding custom atoms not specified by command-line parameters.
```

## AtomicParsley Examples

### Command Line Examples
```
AtomicParsley.exe "E:\Star Trek.mp4" --metaEnema --overWrite

    AtomicParsley.exe "E:\Star Trek.mp4" --stik "Short Film" --title "Star Trek" 
                      --sortOrder name "Star Trek" --TVShowName "Star Trek" 
                      --TVSeasonNum "1" --TVEpisodeNum "1" --TVEpisode "1x01" 
                      --TVNetwork ""
                      --description "The fate of the galaxy rests in the hands of bitter rivals."
                      --longdesc "The fate of the galaxy rests in the hands of bitter rivals."
                      --year "2009-12-12T01:00:00Z" 
                      --artist "Chris Pine as Kirk, Zachary Quinto as Spock."
                      --albumArtist "" --composer "J.J. Abrams" 
                      --genre "Action | Adventure | Science Fiction"
                      --category "Action | Adventure | Science Fiction" 
                      --encodingTool "Lavf53.31.100"
                      --comment "720x480 29.970 fps 2 channels 61.4 Kbps 48.0 KHz AAC"
                      --podcastURL "http://www.imdb.com/title/tt0796366/"
                      --cnID 0796366
                      --rDNSatom "mpaa|PG-13|300|No Idea" name=iTunEXTC domain=com.apple.iTunes
                      --rDNSatom "<?xml version='1.0' encoding='UTF-8'?> <!DOCTYPE plist PUBLIC '-//Apple//DTD PLIST 1.0//EN' 'http://www.apple.com/DTDs/PropertyList-1.0.dtd'><plist version='1.0'><dict>  <key>cast</key>  <array>  <dict><key>name</key><string>Chris Pine as Kirk</string></dict>  <dict><key>name</key><string>Zachary Quinto as Spock.</string></dict>  </array>  <key>directors</key>  <array>  <dict><key>name</key><string>J.J. Abrams</string></dict>  </array>  <key>screenwriters</key>  <array>  <dict><key>name</key><string>J.J. Abrams</string></dict>  </array>  <key>studio</key><string>Paramount Pictures | Bad Robot | Spyglass Entertainment | MavroCine Pictures GmbH & Co. KG</string></dict></plist>" name=iTunMOVI domain=com.apple.iTunes
                      --artwork REMOVE_ALL --artwork "C:\Users\Sean\AppData\Local\Temp\PorpoiseHork\Star Trek (2009) Cover Art 1.jpg"
```

### Standard iTunes Metadata
```
Width:1920 | Height:1078 | DisplaySize:1919x1078 | AspectRatio:16:9 | FrameRate:23.976 | FrameCount:150286 |
VideoBitRate:4982050 | VideoFormat:AVC | Duration:104 | FormatProfile:High@L4.0 | EncodedSettings: |
Summary:
    Video: 1920x1078 16:9 23.976 fps 4 982 Kbps AVC High@L4.0, Audio: 2 channels 154 Kbps 48.0 KHz AAC,
    Audio: iTunes 384 Kbps 48.0 KHz DD |
AudioFormat:DD | AudioChannels:6 | AudioBitRate:384 Kbps | AudioSamplingRate:48.0 KHz | Encryption:iTunes |

AtomicParsley Atom List:
Atom "©nam" contains: The Dead Don't Die
Atom "©ART" contains: Jim Jarmusch
Atom "gnre" contains: Comedy
Atom "cpil" contains: false
Atom "pgap" contains: false
Atom "©day" contains: 2019-06-14T07:00:00Z
Atom "apID" contains: john@thedoes.org
Atom "ownr" contains: John Doe
Atom "cprt" contains: © 2019 Focus Features LLC. All Rights Reserved.
Atom "cnID" contains: 1466254470
Atom "rtng" contains: Inoffensive
Atom "geID" contains: 4404
Atom "sfID" contains: United States (143441)
Atom "desc" contains: In the sleepy small town of Centerville, something is not quite right.
Atom "hdvd" contains: 2
Atom "stik" contains: Movie
Atom "purd" contains: 2019-10-27 03:02:11
Atom "sonm" contains: Dead Don't Die
Atom "flvr" contains: 18:1080p
Atom "----" [com.apple.iTunes;iTunEXTC] contains: mpaa|R|400|
Atom "ldes" contains: It's the greatest zombie cast ever disassembled starring Bill Murray, Adam Driver, ...
Atom "----" [com.apple.iTunes;iTunMOVI] contains: <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>cast</key>
	<array>
		<dict>
			<key>adamId</key>
			<integer>187698036</integer>
			<key>name</key>
			<string>Bill Murray</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>585243176</integer>
			<key>name</key>
			<string>Adam Driver</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>189071034</integer>
			<key>name</key>
			<string>Tilda Swinton</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>279628128</integer>
			<key>name</key>
			<string>Chloë Sevigny</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>222476</integer>
			<key>name</key>
			<string>Steve Buscemi</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>17008038</integer>
			<key>name</key>
			<string>Danny Glover</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>393519586</integer>
			<key>name</key>
			<string>Caleb Landry Jones</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>280215834</integer>
			<key>name</key>
			<string>Selena Gomez</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>83964</integer>
			<key>name</key>
			<string>Tom Waits</string>
		</dict>
	</array>
	<key>codirectors</key>
	<array/>
	<key>copy-warning</key>
	<string>FBI ANTI-PIRACY WARNING: UNAUTHORIZED COPYING IS PUNISHABLE UNDER FEDERAL LAW.</string>
	<key>directors</key>
	<array>
		<dict>
			<key>adamId</key>
			<integer>177484014</integer>
			<key>name</key>
			<string>Jim Jarmusch</string>
		</dict>
	</array>
	<key>producers</key>
	<array>
		<dict>
			<key>adamId</key>
			<integer>280586900</integer>
			<key>name</key>
			<string>Joshua Astrachan</string>
		</dict>
		<dict>
			<key>adamId</key>
			<integer>805626393</integer>
			<key>name</key>
			<string>Carter Logan</string>
		</dict>
	</array>
	<key>screenwriters</key>
	<array>
		<dict>
			<key>adamId</key>
			<integer>177484014</integer>
			<key>name</key>
			<string>Jim Jarmusch</string>
		</dict>
	</array>
	<key>studio</key>
	<string>Universal Pictures</string>
</dict>
</plist>

Atom "©cmt" contains: 1080p WS iTunes HD DD
Atom "covr" contains: 1 piece of artwork
```

## AtomicParsley Full Command-Line Help
```
AtomicParsley help page for setting iTunes-style metadata into MPEG-4 files.
              (3gp help available with AtomicParsley --3gp-help)
          (ISO copyright help available with AtomicParsley --ISO-help)
      (reverse DNS form help available with AtomicParsley --reverseDNS-help)
Usage: AtomicParsley [mp4FILE]... [OPTION]... [ARGUMENT]... [ [OPTION2]...[ARGUMENT2]...]

example: AtomicParsley /path/to.mp4 -e ~/Desktop/pix
example: AtomicParsley /path/to.mp4 --podcastURL "http://www.url.net" --tracknum 45/356
example: AtomicParsley /path/to.mp4 --copyright "â„— Â© 2006"
example: AtomicParsley /path/to.mp4 --year "2006-07-27T14:00:43Z" --purchaseDate timestamp
example: AtomicParsley /path/to.mp4 --sortOrder artist "Mighty Dub Cats, The

------------------------------------------------------------------------------------------------

Getting information about the file & tags:
  -T  --test        Test file for mpeg4-ishness & print atom tree
  -t  --textdata    Prints tags embedded within the file

------------------------------------------------------------------------------------------------

  Extract any pictures in user data "covr" atoms to separate files.
  --extractPix       ,  -E                     Extract to same folder (basename derived from file).
  --extractPixToPath ,  -e  (/path/basename)   Extract to specific path (numbers added to basename).
                                                 example: --e ~/Desktop/SomeText
                                                 gives: SomeText_artwork_1.jpg  SomeText_artwork_2.png
                                               Note: extension comes from embedded image file format

------------------------------------------------------------------------------------------------

 Tag setting options:

  --artist           ,  -a   (str)    Set the artist tag: "moov.udta.meta.ilst.Â©ART.data"
  --title            ,  -s   (str)    Set the title tag: "moov.udta.meta.ilst.Â©nam.data"
  --album            ,  -b   (str)    Set the album tag: "moov.udta.meta.ilst.Â©alb.data"
  --genre            ,  -g   (str)    Set the genre tag: "Â©gen" (custom) or "gnre" (standard).
                                          see the standard list with "AtomicParsley --genre-list"
  --tracknum         ,  -k   (num)[/tot]  Set the track number (or track number & total tracks).
  --disk             ,  -d   (num)[/tot]  Set the disk number (or disk number & total disks).
  --comment          ,  -c   (str)    Set the comment tag: "moov.udta.meta.ilst.Â©cmt.data"
  --year             ,  -y   (num|UTC)    Set the year tag: "moov.udta.meta.ilst.Â©day.data"
                                          set with UTC "2006-09-11T09:00:00Z" for Release Date
  --lyrics           ,  -l   (str)    Set the lyrics tag: "moov.udta.meta.ilst.Â©lyr.data"
  --lyricsFile       ,       (/path)  Set the lyrics tag to the content of a file (HG Builds Only)
  --composer         ,  -w   (str)    Set the composer tag: "moov.udta.meta.ilst.Â©wrt.data"
  --copyright        ,  -x   (str)    Set the copyright tag: "moov.udta.meta.ilst.cprt.data"
  --grouping         ,  -G   (str)    Set the grouping tag: "moov.udta.meta.ilst.Â©grp.data"
  --artwork          ,  -A   (/path)  Set a piece of artwork (jpeg or png) on "covr.data"
                                          Note: multiple pieces are allowed with more --artwork args
  --bpm              ,  -B   (num)    Set the tempo/bpm tag: "moov.udta.meta.ilst.tmpo.data"
  --albumArtist      ,  -A   (str)    Set the album artist tag: "moov.udta.meta.ilst.aART.data"
  --compilation      ,  -C   (bool)   Sets the "cpil" atom (true or false to delete the atom)
  --hdvideo          ,  -V   (int)    Sets the "hdvd" atom 0=SD, 1=720p, 2=1080p
  --advisory         ,  -y   (1of3)   Sets the iTunes lyrics advisory ('remove', 'clean', 'explicit')
  --stik             ,  -S   (1of7)   Sets the iTunes "stik" atom (--stik "remove" to delete)
                                           "Movie", "Normal", "TV Show" .... others:
                                           see the full list with "AtomicParsley --stik-list"
                                           or set in an integer value with --stik value=(num)
                                        Stik Settings (iTunes 10 / Pre-096 versions). Case sensitive.
                                         (0)  Movie
                                         (1)  Normal
                                         (2)  Audiobook
                                         (5)  Whacked Bookmark
                                         (6)  Music Video
                                         (9)  Short Film
                                         (10) TV Show
                                         (11) Booklet
                                        Stik Settings (iTunes 11 / 096 versions). Case sensitive.
                                         (0)  Home Video
                                         (1)  Normal
                                         (2)  Audiobook
                                         (5)  Whacked Bookmark
                                         (6)  Music Video
                                         (9)  Movie
                                         (9)  Short Film
                                         (10) TV Show
                                         (11) Booklet
                                      Note: --stik Audiobook will change file extension to '.m4b'
  --description      ,  -p   (str)    Sets the description on the "desc" atom
  --Rating           ,       (str)    Sets the User Rating on the "rate" atom
  --contentRating    ,       (str)    Set the US TV/motion picture media content rating
                                        us-tv|TV-MA|600|, TV-MA
                                        us-tv|TV-14|500|, TV-14
                                        us-tv|TV-PG|400|, TV-PG
                                        us-tv|TV-G|300|,  TV-G
                                        us-tv|TV-Y7|200|, TV-Y7
                                        us-tv|TV-Y|100|,  TV-Y
                                        mpaa|UNRATED|600|,Unrated
                                        mpaa|NC-17|500|,  NC-17
                                        mpaa|R|400|,      R
                                        mpaa|PG-13|300|,  PG-13
                                        mpaa|PG|200|,     PG
                                        mpaa|G|100|,      G
  --longdesc         ,  -j   (str)    Sets the long description on the "ldes" atom
  --storedesc        ,       (str)    Sets the iTunes store description on the "sdes" atom (HG Builds Only)
  --TVNetwork        ,  -n   (str)    Sets the TV Network name on the "tvnn" atom
  --TVShowName       ,  -H   (str)    Sets the TV Show name on the "tvsh" atom
  --TVEpisode        ,  -I   (str)    Sets the TV Episode on "tven":"209", but it is a string: "209 Part 1"
  --TVSeasonNum      ,  -U   (num)    Sets the TV Season number on the "tvsn" atom
  --TVEpisodeNum     ,  -N   (num)    Sets the TV Episode number on the "tves" atom
  --podcastFlag      ,  -f   (bool)   Sets the podcast flag (values are "true" or "false")
  --category         ,  -q   (str)    Sets the podcast category; typically a duplicate of its genre
  --keyword          ,  -K   (str)    Sets the podcast keyword; invisible to MacOSX Spotlight
  --podcastURL       ,  -L   (URL)    Set the podcast feed URL on the "purl" atom
  --podcastGUID      ,  -J   (URL)    Set the episode's URL tag on the "egid" atom
  --purchaseDate     ,  -D   (UTC)    Set Universal Coordinated Time of purchase on a "purd" atom
                                          (use "timestamp" to set UTC to now; can be akin to id3v2 TDTG tag)
  --encodingTool     ,       (str)    Set the name of the encoder on the "Â©too" atom
  --encodedBy        ,       (str)    Set the name of the Person/company who encoded the file on the "Â©enc" atom
  --apID             ,  -Y   (str)    Set the name of the Account Name on the "apID" atom
  --cnID             ,       (num)    Set iTunes Catalog ID, used for combining SD and HD encodes in iTunes on the "cnID" atom

                                      To combine you must set "hdvd" atom on one file and must have same "stik" on both file
                                      Must not use "stik" of value Movie(0), use Short Film(9)

                                      iTunes Catalog numbers can be obtained by finding the item in the iTunes Store.  Once item
                                      is found in the iTunes Store right click on picture of item and select copy link.
                                      Paste this link into a document or web browser to display the catalog number ID.

                                      An example link for the video Street Kings is:
                                      http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewMovie?id=278743714&s=143441
                                      Here you can see the cnID is 278743714

                                      Alternatively you can use iMDB numbers, however these will not match the iTunes catalog.

  --geID             ,       (num)    Set iTunes Genre ID.  This does not necessarily have to match genre.  (HG Builds Only)
                                      See --genre-movie-id-list and --genre-tv-id-list
                                        iTunes Movie Genre IDs:         iTunes TV Genre IDs:
                                        (4401) Action & Adventure       (4000) Comedy
                                        (4402) Anime                    (4001) Drama
                                        (4403) Classics                 (4002) Animation
                                        (4404) Comedy                   (4003) Action & Adventure
                                        (4405) Documentary              (4004) Classic
                                        (4406) Drama                    (4005) Kids
                                        (4407) Foreign                  (4005) Nonfiction
                                        (4408) Horror                   (4007) Reality TV
                                        (4409) Independent              (4008) Sci-Fi & Fantasy
                                        (4410) Kids & Family            (4009) Sports
                                        (4411) Musicals                 (4010) Teens
                                        (4412) Romance                  (4011) Latino TV
                                        (4413) Sci-Fi & Fantasy
                                        (4414) Short Films
                                        (4415) Special Interest
                                        (4416) Thriller
                                        (4417) Sports
                                        (4418) Western
                                        (4419) Urban
                                        (4420) Holiday
                                        (4421) Made for TV
                                        (4422) Concert Films
                                        (4423) Music Documentaries
                                        (4424) Music Feature Films
                                        (4425) Japanese Cinema
                                        (4426) Jidaigeki
                                        (4427) Tokusatsu
                                        (4428) Korean Cinema
  --xID              ,       (str)    Set iTunes vendor-supplied xID, used to allow iTunes LPs and iTunes Extras to interact
                                          with other content in your iTunes Library (HG Builds Only)
  --gapless          ,       (bool)   Sets the gapless playback flag for a track in a gapless album
  --sortOrder    (type)      (str)    Sets the sort order string for that type of tag.
                                       (available types are: "name", "artist", "albumartist",
                                        "album", "composer", "show")

NOTE: Except for artwork, only 1 of each tag is allowed; artwork allows multiple pieces.
NOTE: Tags that carry text(str) have a limit of 255 utf8 characters;
however lyrics and long descriptions have no limit.

------------------------------------------------------------------------------------------------

 To delete a single atom, set the tag to null (except artwork):
  --artist "" --lyrics ""
  --artwork REMOVE_ALL
  --metaEnema        ,  -P            Douches away every atom under "moov.udta.meta.ilst"
  --foobar2000Enema  ,  -2            Eliminates foobar2000's non-compliant so-out-o-spec tagging scheme
  --manualAtomRemove "some.atom.path" where some.atom.path can be:
      keys to using manualAtomRemove:
         ilst.ATOM.data or ilst.ATOM target an iTunes-style metadata tag
         ATOM:lang=foo               target an atom with this language setting; like 3gp assets
         ATOM.----.name:[foo]        target a reverseDNS metadata tag; like iTunNORM
                                     Note: these atoms show up with 'AP -t' as: Atom "----" [foo]
                                         'foo' is actually carried on the 'name' atom
         ATOM[x]                     target an atom with an index other than 1; like trak[2]
         ATOM.uuid=hex-hex-hex-hex   targt a uuid atom with the uuid of hex string representation
    examples:
        moov.udta.meta.ilst.----.name:[iTunNORM]      moov.trak[3].cprt:lang=urd
        moov.trak[2].uuid=55534d54-21d2-4fce-bb88-695cfac9c740

------------------------------------------------------------------------------------------------

AtomicParsley help page for setting reverse domain '----' metadata atoms.

          Please note that the reverse DNS format supported here is not feature complete.

 Another style of metadata that iTunes uses is called the reverse DNS format. For all known tags,
 iTunes offers no user-accessible exposure to these tags or their contents. This reverse DNS form has
 a differnt form than other iTunes tags that have a atom name that describes the content of 'data'
 atom it contains. In the reverseDNS format, the parent to the structure called the '----' atom, with
 children atoms that describe & contain the metadata carried. The 'mean' child contains the reverse
 domain itself ('com.apple.iTunes') & the 'name' child contains the descriptor ('iTunNORM'). A 'data'
 atom follows that actually contains the contents of the tag.

  --contentRating (rating)             Set the US TV/motion picture media content rating
                                         for available ratings use "AtomicParsley --ratings-list
  --rDNSatom      (str)   name=(name_str) domain=(reverse_domain)  Manually set a reverseDNS atom.

 To set the form manually, 3 things are required: a domain, a name, and the desired text.
 Note: multiple 'data' atoms are supported, but not in the com.apple.iTunes domain
 Examples:
  --contentRating "NC-17" --contentRating "TV-Y7"
  --rDNSatom "mpaa|PG-13|300|" name=iTunEXTC domain=com.apple.iTunes
  --contentRating ""
  --rDNSatom "" name=iTunEXTC domain=com.apple.iTunes
  --rDNSatom "try1" name=EVAL domain=org.fsf --rDNSatom "try 2" name=EVAL domain=org.fsf
  --rDNSatom "" name=EVAL domain=org.fsf

------------------------------------------------------------------------------------------------

AtomicParsley help page for general & file level options.

  Note: you can change the input/output behavior to raw 8-bit utf8 if the program name
        is appended with "-utf8". AtomicParsley-utf8.exe will have problems with files/
        folders with unicode characters in given paths.

 Atom reading services:

  --test             ,  -T           Tests file to see if it is a valid MPEG-4 file.
                                     Prints out the hierarchical atom tree.
                        -T 1         Supplemental track level info with "-T 1"
                        -T +dates    Track level with creation/modified dates

  --textdata         ,  -t      print user data text metadata relevant to brand (inc. # of any pics).
                        -t +    show supplemental info like free space, available padding, user data
                                length & media data length
                        -t 1    show all textual metadata (disregards brands, shows track copyright)

  --brands                      show the major & minor brands for the file & available tagging schemes

------------------------------------------------------------------------------------------------

 File services:

  --freefree [num]   ,                Remove "free" atoms which only act as filler in the file
                                      ?(num)? - optional integer argument to delete 'free's to desired level

                                      NOTE 1: levels begin at level 1 aka file level.
                                      NOTE 2: Level 0 (which doesn't exist) deletes level 1 atoms that pre-
                                              cede 'moov' & don't serve as padding. Typically, such atoms
                                              are created by libmp4ff or libmp4v2 as a byproduct of tagging.
                                      NOTE 3: When padding falls below MIN_PAD (typically zero), a default
                                              amount of padding (typically 2048 bytes) will be added. To
                                              achieve absolutely 0 bytes 'free' space with --freefree, set
                                              DEFAULT_PAD to 0 via the AP_PADDING mechanism (see below).

  --preventOptimizing                 Prevents reorganizing the file to have file metadata before media data.
                                      iTunes/Quicktime have so far *always* placed metadata first; many 3rd
                                      party utilities do not (preventing streaming to the web, AirTunes, iTV).
                                      Used in conjunction with --overWrite, files with metadata at the end
                                      (most ffmpeg produced files) can have their tags rapidly updated without
                                      requiring a full rewrite. Note: this does not un-optimize a file.
                                      Note: this option will be canceled out if used with the --freefree option

  --metaDump                          Dumps out 'moov.udta' metadata out to a new file next to original
                                          (for diagnostic purposes, please remove artwork before sending)
  --output           ,  -o   (/path)  Specify the filename of tempfile (voids overWrite)
  --overWrite        ,  -W            Writes to temp file; deletes original, renames temp to original
                                      If possible, padding will be used to update without a full rewrite.

  --preserveTime                      Will overwrite the original file in place (--overWrite forced),
                                      but will also keep the original file's timestamps intact.

  --DeepScan                          Parse areas of the file that are normally skipped (must be the 3rd arg)
  --iPod-uuid                (num)    Place the ipod-required uuid for higher resolution avc video files
                                      Currently, the only number used is 1200 - the maximum number of macro-
                                      blocks allowed by the higher resolution iPod setting.
                                      NOTE: this requires the "--DeepScan" option as the 3rd cli argument
                                      NOTE2: only works on the first avc video track, not all avc tracks

Examples:
  --freefree 0         (deletes all top-level non-padding atoms preceding 'mooov')
  --freefree 1         (deletes all non-padding atoms at the top most level)
  --output ~/Desktop/newfile.mp4
  AP /path/to/file.m4v --DeepScan --iPod-uuid 1200

------------------------------------------------------------------------------------------------

 Padding & 'free' atoms:

  A special type of atom called a 'free' atom is used for padding (all 'free' atoms contain NULL space).
  When changes need to occur, these 'free' atom are used. They grows or shink, but the relative locations
  of certain other atoms (stco/mdat) remain the same. If there is no 'free' space, a full rewrite will occur.
  The locations of 'free' atom(s) that AP can use as padding must be follow 'moov.udta' & come before 'mdat'.
  A 'free' preceding 'moov' or following 'mdat' won't be used as padding for example.

  Set the shell variable AP_PADDING with these values, separated by colons to alter padding behavior:

  DEFAULT_PADDING=  -  the amount of padding added if the minimum padding is non-existant in the file
                       default = 2048
  MIN_PAD=          -  the minimum padding present before more padding will be added
                       default = 0
  MAX_PAD=          -  the maximum allowable padding; excess padding will be eliminated
                       default = 5000

  If you use --freefree to eliminate 'free' atoms from the file, the DEFAULT_PADDING amount will still be
  added to any newly written files. Set DEFAULT_PADDING=0 to prevent any 'free' padding added at rewrite.
  You can set MIN_PAD to be assured that at least that amount of padding will be present - similarly,
  MAX_PAD limits any excessive amount of padding. All 3 options will in all likelyhood produce a full
  rewrite of the original file. Another case where a full rewrite will occur is when the original file
  is not optimized and has 'mdat' preceding 'moov'.

Examples:
   c:> SET AP_PADDING="DEFAULT_PAD=0"      or    c:> SET AP_PADDING="DEFAULT_PAD=3128"
   c:> SET AP_PADDING="DEFAULT_PAD=5128:MIN_PAD=200:MAX_PAD=6049"

Note: while AtomicParsley is still in the beta stage, the original file will always remain untouched -
      unless given the --overWrite flag when if possible, utilizing available padding to update tags
      will be tried (falling back to a full rewrite if changes are greater than the found padding).

----------------------------------------------------------------------------------------------------

 iTunes 7 & Gapless playback:

 iTunes 7 adds NULL space at the ends of files (filled with zeroes). It is possble this is how iTunes
 implements gapless playback - perhaps not. In any event, with AtomicParsley you can choose to preserve
 that NULL space, or you can eliminate its presence (typically around 2,000 bytes). The default behavior
 is to preserve it - if it is present at all. You can choose to eliminate it by setting the environ-
 mental preference for AP_PADDING to have DEFAULT_PAD=0

Example:
   c:> SET AP_PADDING="DEFAULT_PAD=0"

----------------------------------------------------------------------------------------------------

  3GPP text tags can be encoded in either UTF-8 (default input encoding) or UTF-16 (converted from UTF-8)
  Many 3GPP text tags can be set for a desired language by a 3-letter-lowercase code (default is "eng").
  For tags that support the language attribute (all except year), more than one tag of the same name
  (3 titles for example) differing in the language code is supported.

  iTunes-style metadata is not supported by the 3GPP TS 26.244 version 6.4.0 Release 6 specification.
  3GPP asset tags can be set at movie level or track level & are set in a different hierarchy: moov.udta
  if at movie level (versus iTunes moov.udta.meta.ilst). Other 3rd party utilities may allow setting
  iTunes-style metadata in 3gp files. When a 3gp file is detected (file extension doesn't matter), only
  3gp spec-compliant metadata will be read & written.

  Note1: there are a number of different 'brands' that 3GPP files come marked as. Some will not be
         supported by AtomicParsley due simply to them being unknown and untested. You can compile your
         own AtomicParsley to evaluate it by adding the hex code into the source of APar_IdentifyBrand.

  Note2: There are slight accuracy discrepancies in location's fixed point decimals set and retrieved.

  Note3: QuickTime Player can see a limited subset of these tags, but only in 1 language & there seems to
         be an issue with not all unicode text displaying properly. This is an issue withing QuickTime -
         the exact same text (in utf8) displays properly in an MPEG-4 file. Some languages can also display
         more glyphs than others.

----------------------------------------------------------------------------------------------------
 Tag setting options (default user data area is movie level; default lang is 'eng'; default encoding is UTF8):
     required arguments are in (parentheses); optional arguments are in [brackets]

  --3gp-title           (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp media title tag
  --3gp-author          (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp author of the media tag
  --3gp-performer       (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp performer or artist tag
  --3gp-genre           (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp genre asset tag
  --3gp-description     (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp description or caption tag
  --3gp-copyright       (str)  [lang=3str]  [UTF16]  [area]  .........  Set a 3gp copyright notice tag*

  --3gp-album           (str)  [lang=3str]  [UTF16]  [trknum=int] [area]  Set a 3gp album tag (& opt. tracknum)
  --3gp-year            (int)  [area]  ...........................  Set a 3gp recording year tag (4 digit only)

  --3gp-rating          (str)  [entity=4str]  [criteria=4str]  [lang=3str]  [UTF16]  [area]   Rating tag
  --3gp-classification  (str)  [entity=4str]  [index=int]      [lang=3str]  [UTF16]  [area]   Classification

  --3gp-keyword         (str)   [lang=3str]  [UTF16]  [area]   Format of str: 'keywords=word1,word2,word3,word4'

  --3gp-location        (str)   [lang=3str]  [UTF16]  [area]   Set a 3gp location tag (default: Central Park)
                                 [longitude=fxd.pt]  [latitude=fxd.pt]  [altitude=fxd.pt]
                                 [role=str]  [body=str]  [notes=str]
                                 fxd.pt values are decimal coordinates (55.01209, 179.25W, 63)
                                 'role=' values: 'shooting location', 'real location', 'fictional location'
                                         a negative value in coordinates will be seen as a cli flag
                                         append 'S', 'W' or 'B': lat=55S, long=90.23W, alt=90.25B

 [area] can be "movie", "track" or "track=num" where 'num' is the number of the track. If not specificied,
 assets will be placed at movie level. The "track" option sets the asset across all available tracks

Note1: '4str' = a 4 letter string like "PG13"; 3str is a 3 letter string like "eng"; int is an integer
Note2: List all languages for '3str' with "AtomicParsley --language-list (unknown languages become "und")
*Note3: The 3gp copyright asset can potentially be altered by using the --ISO-copyright setting.
----------------------------------------------------------------------------------------------------
Usage: AtomicParsley [3gpFILE] --option [argument] [optional_arguments]  [ --option2 [argument2]...]

example: AtomicParsley /path/to.3gp -t
example: AtomicParsley /path/to.3gp -T 1
example: Atomicparsley /path/to.3gp --3gp-performer "Enjoy Yourself" lang=pol UTF16
example: Atomicparsley /path/to.3gp --3gp-year 2006 --3gp-album "White Label" track=8 lang=fra
example: Atomicparsley /path/to.3gp --3gp-album "Cow Cod Soup For Everyone" track=10 lang=car

example: Atomicparsley /path/to.3gp --3gp-classification "Poor Sport" entity="PTA " index=12 UTF16
example: Atomicparsley /path/to.3gp --3gp-keyword keywords="foo1,foo2,foo 3" UTF16 --3gp-keyword ""
example: Atomicparsley /path/to.3gp --3gp-location 'Bethesda Terrace' latitude=40.77 longitude=73.98W
                                                    altitude=4.3B role='real' body=Earth notes='Underground'

example: Atomicparsley /path/to.3gp --3gp-title "I see London." --3gp-title "Veo Madrid." lang=spa
                                    --3gp-title "Widze Warsawa." lang=pol

----------------------------------------------------------------------------------------------------

AtomicParsley help page for setting ISO copyright notices at movie & track level.

  The ISO specification allows for setting copyright in a number of places. This copyright atom is
  independant of the iTunes-style --copyright tag that can be set. This ISO tag is identical to the
  3GP-style copyright. In fact, using --ISO-copyright can potentially overwrite the 3gp copyright
  asset if set at movie level & given the same language to set the copyright on. This copyright
  notice is the only metadata tag defined by the reference ISO 14496-12 specification.

  ISO copyright notices can be set at movie level, track level for a single track, or for all tracks.
  Multiple copyright notices are allowed, but they must differ in the language setting. To see avail-
  able languages use "AtomicParsley --language-list". Notices can be set in utf8 or utf16.

  --ISO-copyright  (str)  [movie|track|track=#]  [lang=3str]  [UTF16]   Set a copyright notice
                                                           # in 'track=#' denotes the target track
                                                           3str is the 3 letter ISO-639-2 language.
                                                           Brackets [] show optional parameters.
                                                           Defaults are: movie level, 'eng' in utf8.

example: AtomicParsley /path/file.mp4 -t 1      Note: the only way to see all contents is with -t 1
example: AtomicParsley /path/file.mp4 --ISO-copyright "Sample"
example: AtomicParsley /path/file.mp4 --ISO-copyright "Sample" movie
example: AtomicParsley /path/file.mp4 --ISO-copyright "Sample" track=2 lang=urd
example: AtomicParsley /path/file.mp4 --ISO-copyright "Sample" track UTF16
example: AP --ISO-copyright "Example" track --ISO-copyright "Por Exemplo" track=2 lang=spa UTF16

Note: to remove the copyright, set the string to "" - the track and language must match the target.
example: --ISO-copyright "" track --ISO-copyright "" track=2 lang=spa

Note: (foo) denotes required arguments; [foo] denotes optional parameters & may have defaults.

------------------------------------------------------------------------------------------------

AtomicParsley help page for setting uuid user extension metadata tags.

 Setting a user-defined 'uuid' private extention tags will appear in "moov.udta.meta"). These will
 only be read by AtomicParsley & can be set irrespective of file branding. The form of uuid that AP
 is a v5 uuid generated from a sha1 hash of an atom name in an 'AtomicParsley.sf.net' namespace.

 The uuid form is in some Sony & Compressor files, but of version 4 (random/pseudo-random). An example
 uuid of 'cprt' in the 'AtomicParsley.sf.net' namespace is: "4bd39a57-e2c8-5655-a4fb-7a19620ef151".
 'cprt' in the same namespace will always create that uuid; uuid atoms will only print out if the
 uuid generated is the same as discovered. Sony uuids don't for example show up with AP -t.

  --information      ,  -i   (str)    Set an information tag on uuid atom name"©inf"
  --url              ,  -u   (URL)    Set a URL tag on uuid atom name "Â©url"
  --tagtime          ,      timestamp Set the Coordinated Univeral Time of tagging on "tdtg"

  Define & set an arbitrary atom with a text data or embed a file:
  --meta-uuid        There are two forms: 1 for text & 1 for file operations
         setting text form:
         --meta-uuid   (atom) "text" (str)         "atom" = 4 character atom name of your choice
                                                     str is whatever text you want to set
         file embedding form:
         --meta-uuid   (atom) "file" (/path) [description="foo"] [mime-type="foo/moof"]
                                                     "atom" = 4 character atom name of your choice
                                                     /path = path to the file that will be embedded*
                                                     description = optional description of the file
                                                               default is "[none]"
                                                     mime-type = optional mime type for the file
                                                               default is "none"
                                                               Note: no auto-disocevery of mime type
                                                                     if you know/want it: supply it.
                                               *Note: a file extension (/path/file.ext) is required

Note: (foo) denotes required arguments; [foo] denotes optional arguments & may have defaults.

Examples:
  --tagtime timestamp --information "[psst]I see metadata" --url http://www.bumperdumper.com
  --meta-uuid tagr text "Johnny Appleseed" --meta-uuid Â©sft text "OpenShiiva encoded."
  --meta-uuid scan file /usr/pix/scans.zip
  --meta-uuid 1040 file ../../2006_taxes.pdf description="Fooled 'The Man' yet again."
can be removed with:
  --tagtime "" --information ""  --url " "  --meta-uuid scan file
  --manualAtomRemove "moov.udta.meta.uuid=672c98cd-f11f-51fd-adec-b0ee7b4d215f" \
  --manualAtomRemove "moov.udta.meta.uuid=1fed6656-d911-5385-9cb2-cb2c100f06e7"
Remove the Sony uuid atoms with:
  --manualAtomRemove moov.trak[1].uuid=55534d54-21d2-4fce-bb88-695cfac9c740 \
  --manualAtomRemove moov.trak[2].uuid=55534d54-21d2-4fce-bb88-695cfac9c740 \
  --manualAtomRemove uuid=50524f46-21d2-4fce-bb88-695cfac9c740

Viewing the contents of uuid atoms:
  -t or --textdata           Shows the uuid atoms (both text & file) that AP sets:
  Example output:
    Atom uuid=ec0f...d7 (AP uuid for "scan") contains: FILE.zip; description=[none]
    Atom uuid=672c...5f (AP uuid for "tagr") contains: Johnny Appleseed

Extracting an embedded file in a uuid atom:
  --extract1uuid      (atom)           Extract file embedded within uuid=atom into same folder
                                        (file will be named with suffix shown in --textdata)
  --extract-uuids     [/path]          Extract all files in uuid atoms under the moov.udta.meta
                                         hierarchy. If no /path is given, files will be extracted
                                         to the same folder as the originating file.

 Examples:
 --extract1uuid scan
  ...  Extracted uuid=scan attachment to file: /some/path/FILE_scan_uuid.zip
 --extract-uuids ~/Desktop/plops
  ...  Extracted uuid=pass attachment to file: /Users/me/Desktop/plops_pass_uuid.pdf
  ...  Extracted uuid=site attachment to file: /Users/me/Desktop/plops_site_uuid.html

------------------------------------------------------------------------------------------------

AtomicParsley help page for ID32 atoms with ID3 tags.
----------------------------------------------------------------------------------------------------
      **  Please note: ID3 tag support is not feature complete & is in an alpha state.  **
----------------------------------------------------------------------------------------------------
 ID3 tags are the tagging scheme used by mp3 files (where they are found typically at the start of the
 file). In mpeg-4 files, ID3 version 2 tags are located in specific hierarchies at certain levels, at
 file/movie/track level. The way that ID3 tags are carried on mpeg-4 files (carried by 'ID32' atoms)
 was added in early 2006, but the ID3 tagging 'informal standard' was last updated (to v2.4) in 2000.
 With few exceptions, ID3 tags in mpeg-4 files exist identically to their mp3 counterparts.

 The ID3 parlance, a frame contains an piece of metadata. A frame (like COMM for comment, or TIT1 for
 title) contains the information, while the tag contains all the frames collectively. The 'informal
 standard' for ID3 allows multiple langauges for frames like COMM (comment) & USLT (lyrics). In mpeg-4
 this language setting is removed from the ID3 domain and exists in the mpeg-4 domain. That means that
 when an english and a spanish comment are set, 2 separate ID32 atoms are created, each with a tag & 1
 frame as in this example:
       --ID3Tag COMM "Primary" --desc=AAA --ID3Tag COMM "El Segundo" UTF16LE lang=spa --desc=AAA
 See available frames with "AtomicParsley --ID3frames-list"
 See avilable imagetypes with "AtomicParsley --imagetype-list"

 AtomicParsley writes ID3 version 2.4.0 tags *only*. There is no up-converting from older versions.
 Defaults are:
   default to movie level (moov.meta.ID32); other options are [ "root", "track=(num)" ] (see WARNING)
   UTF-8 text encoding when optional; other options are [ "LATIN1", "UTF16BE", "UTF16LE" ]
   frames that require descriptions have a default of ""
   for frames requiring a language setting, the ID32 language is used (currently defaulting to 'eng')
   frames that require descriptions have a default of ""
   image type defaults to 0x00 or Other; for image type 0x01, 32x32 png is enforced (switching to 0x02)
   setting the image mimetype is generally not required as the file is tested, but can be overridden
   zlib compression off

  WARNING:
     Quicktime Player (up to v7.1.3 at least) will freeze opeing a file with ID32 tags at movie level.
     Specifically, the parent atom, 'meta' is the source of the issue. You can set the tags at file or
     track level which avoids the problem, but the default is movie level. iTunes is unaffected.
----------------------------------------------------------------------------------------------------
   Current limitations:
   - syncsafe integers are used as indicated by the id3 "informal standard". usage/reading of
     nonstandard ordinary unsigned integers (uint32_t) is not/will not be implemented.
   - externally referenced images (using mimetype '-->') are prohibited by the ID32 specification.
   - the ID32 atom is only supported in a non-referenced context
   - probably a raft of other limitations that my brain lost along the way...
----------------------------------------------------------------------------------------------------
 Usage:
  --ID3Tag (frameID or alias) (str) [desc=(str)] [mimetype=(str)] [imagetype=(str or hex)] [...]

  ... represents other arguments:
   [compressed] zlib compress the frame
   [UTF16BE, UTF16LE, LATIN1] alternative text encodings for frames that support different encodings

Note: (foo) denotes required arguments; [foo] denotes optional parameters

 Examples:
 --ID3Tag APIC /path/to/img.ext
 --ID3Tag APIC /path/to/img.ext desc="something to say" imagetype=0x08 UTF16LE compressed
 --ID3Tag composer "I, Claudius" --ID3Tag TPUB "Seneca the Roman" --ID3Tag TMOO Imperial
 --ID3Tag UFID look@me.org uniqueID=randomUUIDstamp

 Extracting embedded images in APIC frames:
 --ID3Tag APIC extract
       images are extracted into the same directory as the source mpeg-4 file

 Setting MCDI (Music CD Identifier):
 --ID3Tag MCDI D
       Information to create this frame is taken directly off an Audio CD's TOC. The letter after
       "MCDI" is the letter of the drive where the CD is present.
```