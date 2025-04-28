#==================================================================================================================
#==================================================================================================================
# Sample Code :: Initialize-PipelineObject
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$env:PS_STATUSMESSAGE_VERBOSE_MESSAGE_TYPES = '["Header","Process","Information","Debug"]'
$env:PS_STATUSMESSAGE_SHOW_VERBOSE_MESSAGES = $true

Set-Location  -Path $PSScriptRoot
Push-Location -Path $PSScriptRoot

$projectPath = ((Get-Location).Path -Replace 'PowerShell-AtomicParsley.*','PowerShell-AtomicParsley')
$modulePath  = Join-Path -Path $projectPath -ChildPath 'po.AtomicParsley'
$mediaPath   = Join-Path -Path $projectPath -ChildPath 'test-media'
$repoPath    = $((Get-Item $($projectPath)).Parent.FullName)
$toolkitPath = Join-Path -Path $repoPath -ChildPath 'PowerShell-Toolkit/po.Toolkit'

Import-Module $toolkitPath -Force
Import-Module $modulePath  -Force

#==================================================================================================================
# Run Tests
#==================================================================================================================

###
# Add a 'Function' Ignore list to Write-Msg.
###

# $localFilePath = '/Users/{0}/Movies/Movie (1080p HD).m4v' -f [Environment]::UserName
# $localFilePath  = '/Users/{0}/Movies/Toy Story (1080p HD).m4v'     -f [Environment]::UserName
# $localFilePathX = '/Users/{0}/Movies/Toy Story (1080p HD) [X].m4v' -f [Environment]::UserName

$localFilePath  = '{0}/Movies/Toy Story (1080p HD).m4v'     -f $mediaPath
$localFilePathX = '{0}/Movies/Toy Story (1080p HD) [X].m4v' -f $mediaPath

# $localFilePath  = '/Users/{0}/Movies/Groundhog Day (1080p).m4v'   -f [Environment]::UserName
# $localFilePathX = '/Users/{0}/Movies/Groundhog Day (1080p) X.m4v' -f [Environment]::UserName

$atoms = Read-AtomicParsleyAtoms -File $localFilePath -SaveToFile

Write-Msg -a -ps -m $( 'Read Atoms:' ) -o $atoms
$atoms.Remove('RawAtomData') | Out-Null
# $atoms.album = "Toy Story"
# $atoms.sortAlbum = "Toy Story"
# $atoms.artist = "Disney / Pixar"
# $atoms.sortArtist = "Disney / Pixar"
# $atoms.title = "Toy Story (Updated)"
# $atoms.description = 'Test "Quotes" in text.'
# $atoms.longDescription = "Test 'Quotes' in text."

Write-AtomicParsleyAtoms -File $localFilePathX -Atoms $atoms -RemoveAll | Out-Null

Read-AtomicParsleyAtoms -File $localFilePathX -SaveToFile | Out-Null

AtomicParsley $localFilePath  --textdata
AtomicParsley $localFilePathX --textdata

exit

AtomicParsley $localFilePath --DeepScan --test 

#AtomicParsley $localFilePath --rDNSatom "" name=TMdbID domain=org.themoviedb  --rDNSatom "tmbdid3" name=TMdbID domain=org.themoviedb --overWrite

# AtomicParsley $localFilePath --tracknum 2/12  --overWrite

#AtomicParsley $localFilePath --metaEnema --overWrite


exit

# command = "AtomicParsley \"#{f_path}\" --DeepScan --manualAtomRemove \"moov.trak.mdia.minf.stbl.stsd.mp4a.pinf\""
# 	["apID","ownr", "atID","cnID","geID","plID","sfID","cprt","flvr","purd","rtng","soal","stik","xid ","----.name:[iTunMOVI]"].each {|atom|
# 		command += " --manualAtomRemove \"moov.udta.meta.ilst.#{atom}\""
# 	}

$test = @{

  "Test:Name" = "Test:Value"
  "Test:Name2" = "Test:Value2"
  "Test:Name3" = "Test:Value3"

}

$test."Test:Name" = "Test:Value000"

AtomicParsley '/Users/sean/Movies/Toy Story (1080p HD) 2.m4v' --metaEnema --overWrite
AtomicParsley '/Users/sean/Movies/Toy Story (1080p HD) 2.m4v' --textdata

AtomicParsley '/Users/sean/Movies/Toy Story (1080p HD) 2.m4v' --contentRating 'G' --overWrite

AtomicParsley -rDNS-help



AtomicParsley '/Users/sean/Movies/Disorganized Crime (1080p HD).m4v' --textdata

AtomicParsley '/Users/sean/Movies/Mission - Impossible (1080p HD).m4v' --textdata

AtomicParsley '/Users/sean/Movies/Movie (1080p HD).m4v' --textdata


AtomicParsley '/Users/sean/Movies/Movie (1080p HD).m4v' --textdata

AtomicParsley '/Users/sean/Movies/Toy Story (1080p HD).m4v' --textdata

exit

# View the available shares on the server
  smbutil lookup share.the-powells.org

# Mount the share via the command line
  mount_smbfs //sean@share.the-powells.org/Media /Users/sean/Share/Media
  AtomicParsley '/Users/sean/Share/Media/Movies/12 Monkeys (1998) [1080p WS iTunes HD DD].m4v' --textdata

# Mount the share through the Finder and access it through the '/Volumes' directory
  AtomicParsley '/Volumes/Media/Movies/12 Monkeys (1998) [1080p WS iTunes HD DD].m4v' --textdata

<#
  Atom "©nam" contains: American Psycho (Uncut Version)
  Atom "©ART" contains: Mary Harron
  Atom "©gen" contains: Horror
  Atom "cpil" contains: false
  Atom "pgap" contains: false
  Atom "©day" contains: 2000-04-14T07:00:00Z
  Atom "apID" contains:
  Atom "ownr" contains:
  Atom "dwID" contains: kid.powell@icloud.com
  Atom "dwlr" contains: Kid Powell
  Atom "cprt" contains: © MM Lions Gate Films, Inc. All Rights Reserved.
  Atom "cnID" contains: 300759524
  Atom "rtng" contains: Inoffensive
  Atom "geID" contains: 4408
  Atom "sfID" contains: United States (143441)
  Atom "desc" contains: Patrick Bateman (Christian Bale) is a Wall Street yuppie, obsessed with success, status and style,
  Atom "hdvd" contains: 2
  Atom "stik" contains: Movie
  Atom "purd" contains: 2020-08-05 01:06:29
  Atom "xid " contains: lionsgate:vendor_id:9380020100557
  Atom "flvr" contains: 18:1080p


  Atom "©nam" contains: Flight of the Phoenix
  Atom "©ART" contains: Arrested Development
  Atom "aART" contains: Arrested Development
  Atom "©alb" contains: Arrested Development, The Complete Series
  Atom "gnre" contains: Comedy
  Atom "trkn" contains: 54 of 68
  Atom "disk" contains: 1 of 1
  Atom "cpil" contains: false
  Atom "pgap" contains: false
  Atom "©day" contains: 2013-09-03T07:00:00Z
  Atom "apID" contains: sean@the-powells.org
  Atom "ownr" contains: Sean Powell
  Atom "cprt" contains: © 2013 Netflix Inc. All rights reserved.
  Atom "cnID" contains: 1315104762
  Atom "rtng" contains: Inoffensive
  Atom "atID" contains: 213365509
  Atom "plID" contains: 1313950547
  Atom "geID" contains: 4000
  Atom "sfID" contains: United States (143441)
  Atom "desc" contains: Michael says goodbye to the family business and starts his own. And the life of the family is turned upside down when their mailman Pete dies.
  Atom "hdvd" contains: 2
  Atom "tvsh" contains: Arrested Development
  Atom "tven" contains: 4AJD01
  Atom "tves" contains: 1
  Atom "stik" contains: TV Show
  Atom "purd" contains: 2024-08-19 05:52:36
  Atom "xid " contains: FoxTV:vendor_id:FOX_ARRESTEDDEVELOPMENT_4AJD01_CLEAN_BOX_1_4
  Atom "flvr" contains: 18:1080p
  Atom "----" [com.apple.iTunes;iTunEXTC] contains: us-tv|TV-14|500|
  Atom "ldes" contains: Michael says goodbye to the family business and starts his own. And the life of the family is turned upside down when their mailman Pete dies.
  Atom "tvsn" contains: 4
  Atom "©cmt" contains: 1080p WS iTunes+ HD DD
  Atom "covr" contains: 1 piece of artwork

  #>