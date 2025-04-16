# AtomicParsley PowerShell Module

## Description
This module is a PowerShell interface to the AtomicParsley command-line tool created by Wez Furlong. 

"AtomicParsley is a lightweight command line program for reading, parsing and setting metadata into 
MPEG-4 files, in particular, iTunes-style metadata." 

AtomicParsley is an open source project available on Github 
(https://github.com/wez/atomicparsley) under the GPL-2.0 License. 

## Functionality
This module allows data to be read from and written to media files using a PowerShell object.

### Reading Data from a File

This command uses AtomicParsley to read the metadata of the specified file:
```
    $atoms = Read-AtomicParsleyAtoms -File './Movie (1080p HD).m4v'
```
The resulting '$atoms' object would look like this:
```
    $atoms = @{
      Title        = "Movie Name"
      Artist       = "Artist Name"
      Genre        = "Kids & Family"
      ReleaseDate  = "1995-11-22T08:00:00Z"
      Copyright    = "Copyright Holder"
      Description  = "Movie Description"
      HDVideo      = 2
      MediaType    = "Movie"
      Rating       = "G"
    }
```

### Writing Data to a File

That same object that was returned by the read operation above 
can be written to a file using the following command:  

```
Write-AtomicParsleyAtoms -File './Movie (1080p HD).m4v' -Atoms $atoms
```

Each property included in the object will be written to the file. To remove a 
property set the value to null ( either '', "" or $null). Properties that
are not included in the object are not updated on the file.

For example, this object:
```
    $atoms = @{
      Title        = "New Movie Name"
      Description  = ""
      Genre        = $null
    }
```
... would update the title atom of the file to "New Movie Name" and would
remove the Description and Genre atoms. All other atoms would remain at their
original values. A subsequent read of the file would result in this object:

```
    $atoms = @{
      Title        = "New Movie Name"
      Artist       = "Artist Name"
      ReleaseDate  = "1995-11-22T08:00:00Z"
      Copyright    = "Copyright Holder"
      HDVideo      = 2
      MediaType    = "Movie"
      Rating       = "G"
    }
```

A list of known atoms / metadata fields is provided in the next section. 

If the object contains a Property value that does not exist in the table
below it will be written to the file as a custom atom. However, custom 
atoms will not be displayed by most media software (Apple TV App, iTunes, 
Plex, etc.). 

See the Custom Atoms section below for more information.


## PowerShell / AtomicParsley / iTunes Atom Cross-Reference List
```

PowerShell           AtomicParsley               Atom ID    Type        Description / Sample Data
-----------------    -----------------------    --------    --------    -------------------------------------------

title                -s, --title                ©nam        string      Movie, TV Episode or Song title.
description          -p, --description          desc        string      Short Description (255 chars or less)
longDescription      -j, --longdesc             ldes        string      Long Description (no char limit)
genre                -g, --genre                ©gen        string      User defined Genre name. 
iTunesGenre              --geID                 geID        number      Ex: 4000. See AtomicParsleyHelp.txt.
releaseDate          -y, --year                 ©day        datetime    UTC Date Format: 1989-04-14T07:00:00Z
contentRating            --contentRating        iTunEXTC    string      G, PG, TV-PG. See AtomicParsleyHelp.txt.
movi                                            iTunMOVI    string      The list of actors, directors, etc. 
                                                                        This is an XML document.
                                                                                                                   
tvShowName           -H, --TVShowName           tvsh        string      The TV Show/Series name.
tvSeasonNumber       -U, --TVSeasonNum          tvsn        number      The Season number. Ex: 1
tvEpisodeNumber      -N, --TVEpisodeNum         tves        number      The Episode number. Ex: 1
tvEpisodeID          -I, --TVEpisode            tven        string      1x01 or s01e01 or 4AJD01 (production code)
tvNetwork            -n, --TVNetwork            tvnn        string      ABC, FOX, Netflix, HBO
storeDescription         --storedesc            sdes        string      The iTunes Store TV Season description.
                                                                                                                   
Artist               -a, --artist               ©ART        string      Music = Performer. Movie = Director.
                                                                        TV Show = Show/Series Name.
AlbumArtist          -A, --albumArtist          aART        string      Music = Performer. TV Show = Show Name.
Composer             -w, --composer             ©wrt        string      Music Composer of Movie/TV Writers.

album                -b, --album                ©alb        string      The music album, TV Series or Movie 
                                                                        collection name. Plex will group Movies
                                                                        by this field if populated. 

grouping             -G, --grouping             ©grp        string      Any text data. Limited to 255 chars.
comment              -c, --comment              ©cmt        string      Any text data. Limited to 255 chars.

trackNumber          -k, --tracknum             trkn        num[/tot]   Used for Music and TV. Ex: 1 or 1/12
discNumber           -d, --disk                 disk        num[/tot]   Used for Music and TV. Ex: 1 or 1/12

CoverArt             -A, --artwork              covr        string      The file path to the image(s) to embed.
                                                                        Multiple images can be embedded.
                                                                                                                   
mediaType            -S, --stik                 stik        string      Movie, TV Show. See AtomicParsleyHelp.txt.
hdVideo              -V, --hdvideo              hdvd        number      Video Type. 0=480p, 1=720p, 2=1080p
flavor                                          flvr        string      Video size and aspect ratio? Ex: 18:1080p
                                                                                                                   
iTunesCatalogID          --cnID                 cnID        number      The iTunes Store Catalog ID.
vendorID                 --xID                  xid         string      The iTunes Extras ID.
                                                                        Both of these items are used to link extra
                                                                        media items / information to the files.
                                                                                                                   
purchaseDate         -D, --purchaseDate         purd        datetime    UTC Date Format: 1989-04-14T07:00:00Z
purchaseAccount      -Y, --apID                 apID        string      The iTunes Account Name (email address)
purchaseName                                    ownr        string      The friendly name of the purchaser.
downloadAccount                                 dwID        string      The family sharing download account (email).
downloadName                                    dwlr        string      The family sharing download user name.
accountType                                     akID 
countryCode                                     sfID        number      The iTunes Store Ex: United States (143441)
copyright            -x, --copyright            cprt        string      Ex: © 2013 Company Inc. All rights reserved.

musicGenre               --genre                gnre        number      Music Genre. See AtomicParsleyHelp.txt.
compilation          -C, --compilation          cpil        bool        Flags the file as mixed artists.
lyrics               -l, --lyrics               ©lyr        string      An unlimited text field for song lyrics.
tempo                -B, --bpm                  tmpo        number                                            
advisoryRating       -y  --advisory             rtng        string      1 of: 'remove', 'clean', 'explicit'
gaplessPlayback          --gapless              pgap        bool        Enable gapless playback flag.
userRating               --Rating               rate        string      The iTunes user star rating of a media item.
                                                                                                                   
SortName             --sortOrder name           sonm        string      Set the sort order string for this field.
SortShow             --sortOrder show           sosn        string      Set the sort order string for this field.
SortAlbum            --sortOrder album          soal        string      Set the sort order string for this field.
SortAlbumArtist      --sortOrder albumartist    soaa        string      Set the sort order string for this field.
SortArtist           --sortOrder artist         soar        string      Set the sort order string for this field.
SortComposer         --sortOrder composer       soco        string      Set the sort order string for this field.
                                                                                                                   
Podcast              -f, --podcastFlag          pcst        bool        Flags a music file as a podcast.
PodcastCategory      -q, --category             catg        string      Sets the category, usually the same as genre.
PodcaseKeywords      -K, --keyword              keyw        string      Sets the keyword for the iTunes Store.
PodcastURL           -L, --podcastURL           purl        URL         Sets the podcast feed URL.
PodcastGUID          -J, --podcastGUID          egid        URL         Sets the podcast episode URL.

EncodingTool             --encodingTool         ©too        string      Encoding software information.
EncodedBy                --encodedBy            ©enc        string      Encoding person or company information.

Unknown1                                        atID        number
Unknown2                                        plID        number

```

## Using the 'movi' Property / iTunMOVI Atom

Most atoms in a media file are simple text or numbers. The "iTunMOVI" 
atom is a complex field that contains several lists of movie credit metadata 
(actors, directors, etc.) combined with XML formatting.

The field's raw data looks like this:

```
Atom "----" [com.apple.iTunes;iTunMOVI] contains: <?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>studio</key><string>Studio Name</string>
  <key>cast</key>
  <array>
    <dict>
      <key>name</key><string>John Hanks</string>
      <key>adamId</key><integer>2672649</integer>
    </dict>
    <dict>
      <key>name</key><string>Tim Allen</string>
      <key>adamId</key><integer>187699022</integer>
    </dict>
    <dict>
      <key>name</key><string>Don Rickles</string>
      <key>adamId</key><integer>3625072</integer>
    </dict>
  </array>
  <key>directors</key>
  <array>
    <dict>
      <key>name</key><string>John Lasseter</string>
      <key>adamId</key><integer>188703870</integer>
    </dict>
  </array>
</dict>
</plist>
```

When retrieving metadata from a file that contains the iTunMOVI atom, 
the raw data (both text and formatting) are stored in the result 
object's 'movi' property. The result object will also contain additional
properties, each prefixed with the 'movi' atom name, for each type of
list included in the 'movi' atom raw data. 

For the example iTunMOVI atom data above, the object that is returned 
would look like this:
```
$atoms = @{
    movi              = "<?xml version="1.0" encoding="UTF-8" standalone="no"?> ..."
    moviStudio        = "Studio Name"
    moviCast          = @('Tom Hanks:2672649','Tim Allen:187699022','Don Rickles:3625072')
    moviDirectors     = @('John Lasseter:188703870')
    moviCoDirectors   = @()
    moviProducers     = @()
    moviScreenWriters = @()
}
```
... where each entry in the list contains a name (Tom Hanks) and the 
ID (2672649) used by the iTunes store to identify that artist.

When writing metadata to a file you can include the individual 'movi' 
properties that represent the credit lists (moviCast, moviDirectors, etc.) 
to automatically generate the correct XML metadata for the iTunMOVI atom 
('movi' property).

```
$atoms = @{
    moviStudio        = "Studio Name"
    moviCast          = @('Tom Hanks','Tim Allen','Don Rickles')
    moviDirectors     = @('John Lasseter')
    moviCoDirectors   = @()
    moviProducers     = @()
    moviScreenWriters = @()
}
```
Note that the iTunes Store artist ID is not required to generate the iTunMOVI atom.

If you include a 'movi' property in your object when writing data to a file, 
that property value will be written EXACTLY as defined in the property, and 
will not be auto-generated even if other 'movi' properties exist in the object.

## Reading and Writing Metadata to Custom Atoms
AtomicParsley supports writing both standard and reverse DNS format atom metadata. 
You can read more about how this works in the AtomicParsley help file under the 
--reverseDNS-help section.

Reverse DNS atoms can be used to create custom metadata in your media files.
Although custom atoms are not necessarily supported by all media apps, some 
apps allow you to add custom properties, and they are still useful from a 
library management perspective.

Reverse DNS atoms are different from normal atoms in that they require an 
additional piece of data data to configure. Instead of the normal 'name' 
and 'value' properties, they require a 'name', a 'value' and a 'domain'. 

For example, the "iTunMOVI" atom references above is actually a reverse
DNS atom. You could choose to ignore the PowerShell module's built-in 
handling of that property and write it as a custom atom instead like this:
```
$atoms = @{
    iTunMOVI = "<?xml version="1.0" encoding="UTF-8" standalone="no"?> ..."
}

Write-AtomicParsleyAtoms -File './Movie (1080p HD).m4v' -Atoms $atoms -Domain 'com.apple.iTunes'
```

... which would update only the iTunMOVI atom on the file and set the domain 
of any custom atoms to 'com.apple.iTunes'.

If you want to add multiple custom atoms and domains to a to a file, you can
do so by specifying a custom domain as part of the property name in the 
format 'domain;PropertyName'. 

For example:
```
$atoms = @{
    iTunMOVI = "<?xml version="1.0" encoding="UTF-8" standalone="no"?> ..."
    'org.themoviedb;TMdbID' = 862
    'com.thetvdb;TVdbID' = 318
}

Write-AtomicParsleyAtoms -File './Movie (1080p HD).m4v' -Atoms $atoms -Domain 'com.apple.iTunes'
```
... would use the domains specified in the 'TMdbID' and 'TVdbID' properties, 
and would use the 'com.apple.iTunes' domain for the 'iTunMOVI' property since
it did not define a domain.

If you specify custom properties but do not specify a domain in either the 
property name or the Write-AtomicParsleyAtoms function:
```
$atoms = @{
    iTunMOVI = "<?xml version="1.0" encoding="UTF-8" standalone="no"?> ..."
    TMdbID = 862
    TVdbID = 318
}

Write-AtomicParsleyAtoms -File './Movie (1080p HD).m4v' -Atoms $atoms
```

... a default domain will be used. The value of the default domain is defined
by the environment variable PS_AtomicParsley_DefaultDomain. If that value
is not defined, the value 'com.AtomicParsley' will be used as the domain.

When reading a file with custom atoms, the domain will appear as part
of the property name UNLESS the domain matches the default domain defined
in the PS_AtomicParsley_DefaultDomain environment variable.

For example:
```
$env:PS_AtomicParsley_DefaultDomain = 'com.me'

$atoms = @{
    'TMdbID:org.themoviedb' = 862
    'TVdbID:com.thetvdb' = 318
    MyProperty = 'Test Me'
}

Write-AtomicParsleyAtoms -File './Movie (1080p HD).m4v' -Atoms $atoms
```
... would result in an object that looks just like the original object, 
even though the 'com.me' domain is set in the file:
```
$atoms = @{
    'TMdbID:org.themoviedb' = 862
    'TVdbID:com.thetvdb' = 318
    MyProperty = 'Test Me'
}
```

To access properties that include a domain use single or double quotes:
```
$value = $atoms.'TMdbID:org.themoviedb'
or
$atoms."TMdbID:org.themoviedb" = 862
```

Custom properties whose domain matches the default custom domain will 
not be defined with the domain, and need to be accessed only by their
property name:
```
$value = $atoms.MyProperty
or
$atoms.MyProperty = 862
```



## Installing the PowerShell Module

### PowerShell Requirements

This module requires **version 7** of [PowerShell](
  https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.5), a free, scripting 
  language that runs on Windows, MacOS and Linux. Instructions for installing PowerShell are available 
[here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.5).

PowerShell is a command-line / terminal utility. It is meant to run commands and scripts. To create or modify 
scripts you will want to use another application. Any text editor will work. Windows includes the "PowerShell ISE" 
application to edit and run scripts. However, that application isn't intended to be used with PowerShell versions 
greater than version 5. Microsoft's [Visual Studio Code](https://code.visualstudio.com) is a free, cross-platform 
Code/Script editor that can be used to create, modify and run PowerShell scripts. 
The [Using Visual Studio Code for PowerShell Development](
  https://learn.microsoft.com/en-us/powershell/scripting/dev-cross-plat/vscode/using-vscode?view=powershell-7.5) 
article contains instructions on how to install Visual Studio Code on Windows, MacOS and Linux, as well as
instructions for creating basic scripts and running them.

## Module Installation




## AtomicParsley Installation

### Mac OS

On MacOS, the AtomicParsley binary can be installed using Homebrew with the following command: 
```
    $ brew install atomicparsley
```
Homebrew installation documentation can be found here: https://docs.brew.sh/Installation
    
### Windows

On Windows, the AtomicParsley binary can be installed using Chocolatey with the following command: 
```
    $ choco install atomicparsley
```
Chocolatey installation documentation can be found here: https://chocolatey.org/install

### All Operating Systems

Windows systems also need the [Visual C++ Redistributable for Visual Studio 2015](
  https://www.microsoft.com/en-us/download/details.aspx?id=48145) installed.

Users of all operating systems can download the latest version from the releases page of the project site: 

    https://github.com/wez/atomicparsley/releases

## AtomicParsley Must Be Available in the System Path

When installing AtomicParsley using Homebrew or Chocolatey, the AtomicParsley path will automatically be added to 
the operating system PATH environment variable so the tool can be run using the terminal or command-prompt from 
any location on the system. If AtomicParsley was installed manually you will need to update your operating system
environment path to include the AtomicParsley path for the module to function.

## File Permissions on MacOS

MacOS has 'Special Folders' like Downloads, Desktop, Photos and Movies in the user's personal folder that require 
additional permissions to be granted for applications to access their content. If your video files are located 
in the 'Movies' folder under your user profile, AtomicParsley and PowerShell must be granted access to the folder
to be able to read and write to the files. 

To grant access to the Movies folder:
1. Navigate to: System Settings > Privacy and Security > Media & Apple Music
2. Click the "+" button at the bottom of the screen to add a new application.
3. Add the AtomicParsley application. If you installed the application using 
   Homebrew the file will be located here: /opt/homebrew/bin/AtomicParsley
4. Add the application that you are using to run this PowerShell module 
   (PowerShell, Visual Studio Code, etc.). 

If you use Apple's "TV" app, it will create a folder under the Movies folder by default at /Users/Username/Movies/TV
and store all of it's media there. The "TV" folder has it's own set of special permissions, and the files in that 
folder won't be accessible by apps even after enabling the additional permissions via the "Media & Apple Music"
setting. 

## AtomicParsley Project Information

**AtomicParsley Source Code and Downloads**  
Current: https://github.com/wez/atomicparsley  
Older:   https://sourceforge.net/projects/atomicparsley/files/  

**AtomicParsley Documentation**  
Current: https://github.com/wez/atomicparsley  
Older:   http://atomicparsley.sourceforge.net/  

**Atom Definitions**  
[Apple Developer Documentation](
  https://developer.apple.com/library/mac/documentation/QuickTime/qtff/QTFFChap2/qtff2.html)
