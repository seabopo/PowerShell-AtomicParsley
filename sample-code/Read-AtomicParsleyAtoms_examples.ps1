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
$repoPath    = $((Get-Item $($projectPath)).Parent.FullName)
$toolkitPath = Join-Path -Path $repoPath -ChildPath 'PowerShell-Toolkit/po.Toolkit'

Import-Module $toolkitPath -Force
Import-Module $modulePath  -Force

#==================================================================================================================
# Run Tests
#==================================================================================================================

#---------------------------
# Local File Test for MacOS
#---------------------------
#
# Step 1: Open 'System Settings > Privacy & Security > Media & Apple Music'
#
# Step 2: Add 'AtomicParsley' to the list of apps that can access your media files. If 'AtomicParsley' was
#         installed via Homebrew, the file will be located at '/opt/homebrew/bin/AtomicParsley'.
#
# Step 3: Add 'PowerShell' (or Visual Studio Code, or whatever application you are using to run PowerShell)
#         to the list of apps that can access your media files.
#
#         Steps 2 & 3 will grant access to the Movies and Music folders.
#
#         PLEASE NOTE: The TV app creates a TV folder in the movies folder. Granting access to the Movies
#         folder WILL NOT grant access to the TV folder, which has its own permissions. I couldn't find a way
#         to grant access to the TV folder via the System Settings interface.
#
# Step 4: Run the following PowerShell command ...
#
#            Read-AtomicParsleyAtoms -FilePath '/Users/<UserName>/Movies/Movie (1080p HD).m4v'
#
#         ... which will execute the following AtomicParsley command ...
#
#             AtomicParsley '/Users/<UserName>/Movies/Movie (1080p HD).m4v' --textdata
#
#         ... and will then return the output, which normally looks like this ...
#
#             Atom "©nam" contains: Movie Name
#             Atom "©ART" contains: Artist Name
#             Atom "©gen" contains: Kids & Family
#             Atom "©day" contains: 1995-11-22T08:00:00Z
#             Atom "cprt" contains: Copyright Holder
#             Atom "desc" contains: Movie Description
#             Atom "hdvd" contains: 2 (1080p)
#             Atom "stik" contains: Movie
#             Atom "----" [com.apple.iTunes;iTunEXTC] contains: mpaa|G|100|
#
#         ... but instead, will be reformatted to a hashtable, now looking like this:
#
#             Name               Value
#             ----               -----
#             Title              Movie Name
#             Artist             Artist Name
#             GenreUserdefined   Kids & Family
#             ReleaseDate        1995-11-22T08:00:00Z
#             Copyright          Copyright Holder
#             Description        Movie Description
#             HDVideo            2
#             MediaType          Movie
#             Rating             G
#

    $localFilePath = '/Users/{0}/Movies/Movie (1080p HD).m4v' -f [Environment]::UserName
    Read-AtomicParsleyAtoms -FilePath $localFilePath

#-----------------------------
# Network File Test for MacOS
#-----------------------------


#
# Step 4: Run the following command. This command will execute the following AtomicParsley command:
#
#         AtomicParsley '/Users/<username>/Movies/mymovie.m4v' --textdata
#
#         ... and then return the output in the form of a hashtable.



# AtomicParsley '/Users/<username>/Movies/mymovie.m4v' --textdata
# The command will be run in the background and the output will be returned to the pipeline.



$localFilePath = '/Users/sean/Repos/@psModules/PowerShell-AtomicParsley/sample-code/alltags06.m4v'
$networkFilePath = '/Volumes/Media/Movies/12 Monkeys (1998) [1080p WS iTunes HD DD].m4v'

Read-AtomicParsleyAtoms -FilePath $localFilePath


exit

Invoke-AtomicParsleyCommand -p $filePath

AtomicParsley '/Users/sean/Repos/@psModules/PowerShell-AtomicParsley/sample-code/alltags06.m4v' --textdata

$cmd = 'AtomicParsley "/Users/sean/Repos/@psModules/PowerShell-AtomicParsley/sample-code/alltags06.m4v" --textdata'

Invoke-Expression -Command $cmd

#==================================================================================================================

exit

# View the available shares on the server
  smbutil lookup share.the-powells.org

# Mount the share via the command line
  mount_smbfs //sean@share.the-powells.org/Media /Users/sean/Share/Media
  AtomicParsley '/Users/sean/Share/Media/Movies/12 Monkeys (1998) [1080p WS iTunes HD DD].m4v' --textdata

# Mount the share through the Finder and access it through the '/Volumes' directory
  AtomicParsley '/Volumes/Media/Movies/12 Monkeys (1998) [1080p WS iTunes HD DD].m4v' --textdata



