#==================================================================================================================
#==================================================================================================================
# Sample Code :: Generate A Complete AtomicParsley Help File
#==================================================================================================================
#==================================================================================================================

#==================================================================================================================
# Initialize Test Environment
#==================================================================================================================

Clear-Host

$ErrorActionPreference = "Stop"

$projectPath = ((Get-Location).Path -Replace 'PowerShell-AtomicParsley.*','PowerShell-AtomicParsley')
$helpPath    = Join-Path -Path $projectPath -ChildPath 'AtomicParsleyHelp.txt'

#==================================================================================================================
# Create Help File
#==================================================================================================================

"=" *100                                                                   | Out-File -FilePath $helpPath
"AtomicParsley Help (--help)"                                              | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
AtomicParsley --help                                                       | Out-File -FilePath $helpPath -Append
"`n"                                                                       | Out-File -FilePath $helpPath -Append

"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley Full Help (--longhelp)"                                     | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --longhelp                                                   | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley Stik List (--stik-list)"                                    | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --stik-list                                                  | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"Content Ratings (for the --contentRating parameter)"                      | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
" --contentRating,(str) Set the US TV/Movie content rating"                | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
" -------------------    -----------------"                                | Out-File -FilePath $helpPath -Append
" contentRating Value    reverseDNS Value"                                 | Out-File -FilePath $helpPath -Append
" -------------------    -----------------"                                | Out-File -FilePath $helpPath -Append
"   TV-MA                us-tv|TV-MA|600|, "                               | Out-File -FilePath $helpPath -Append
"   TV-14                us-tv|TV-14|500|, "                               | Out-File -FilePath $helpPath -Append
"   TV-PG                us-tv|TV-PG|400|, "                               | Out-File -FilePath $helpPath -Append
"   TV-G                 us-tv|TV-G|300|,  "                               | Out-File -FilePath $helpPath -Append
"   TV-Y7                us-tv|TV-Y7|200|, "                               | Out-File -FilePath $helpPath -Append
"   TV-Y                 us-tv|TV-Y|100|,  "                               | Out-File -FilePath $helpPath -Append
"   Unrate               mpaa|UNRATED|600|,"                               | Out-File -FilePath $helpPath -Append
"   NC-17                mpaa|NC-17|500|,  "                               | Out-File -FilePath $helpPath -Append
"   R                    mpaa|R|400|,      "                               | Out-File -FilePath $helpPath -Append
"   PG-13                mpaa|PG-13|300|,  "                               | Out-File -FilePath $helpPath -Append
"   PG                   mpaa|PG|200|,     "                               | Out-File -FilePath $helpPath -Append
"   G                    mpaa|G|100|,      "                               | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley Standard Music Genre List (--genre-list)"                   | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --genre-list                                                 | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley iTunes Movie Genre List (--genre-movie-id-list)"            | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --genre-movie-id-list                                        | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley iTunes TV Genre List (--genre-tv-id-list)"                  | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --genre-tv-id-list                                           | Out-File -FilePath $helpPath -Append

"`n"                                                                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley File Help (--file-help)"                                    | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --file-help                                                  | Out-File -FilePath $helpPath -Append

""                                                                         | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley Reverse DNS Help (--reverseDNS-help)"                       | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --reverseDNS-help                                            | Out-File -FilePath $helpPath -Append

""                                                                         | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley UUID Help (--uuid-help)"                                    | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --uuid-help                                                  | Out-File -FilePath $helpPath -Append

""                                                                         | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley ISO Help (--ISO-help )"                                     | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --ISO-help                                                   | Out-File -FilePath $helpPath -Append

""                                                                         | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley 3gp Help (--3gp-help)"                                      | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --3gp-help                                                   | Out-File -FilePath $helpPath -Append

"=" *100                                                                   | Out-File -FilePath $helpPath -Append
"AtomicParsley ID3 Help (--ID3-help)"                                      | Out-File -FilePath $helpPath -Append
"=" *100                                                                   | Out-File -FilePath $helpPath -Append
""                                                                         | Out-File -FilePath $helpPath -Append
AtomicParsley --ID3-help                                                   | Out-File -FilePath $helpPath -Append
