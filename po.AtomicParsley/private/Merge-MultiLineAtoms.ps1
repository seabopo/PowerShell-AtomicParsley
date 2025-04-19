function Merge-MultiLineAtoms {
    <#
    .DESCRIPTION
        Combines atoms whose values span multiple array elements into a single element.

    .OUTPUTS
        A single atom from a collection of atoms.

    .PARAMETER AtomData
        REQUIRED. String. Alias: -d. A string containing a single line item of atom data returned by the
        AtomicParsley --metadata command.

    .EXAMPLE
        'Atom "©nam" contains: The Dead Don't Die' | Merge-MultiLineAtoms

    .NOTES
        THIS FUNCTION IS NOT INTENDED TO BE CALLED DIRECTLY. IT IS INTENDED TO BE PIPELINED
        from a string array containing the output of the AtomicParsley --metadata command.

    #>
    [OutputType([String])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)] [Alias('d')] [String] $AtomData
    )

    begin {
        $currentAtomID = ''
        $multiElementAtom = @{
            iTunMOVI = ''
        }
    }

    process {

        Write-Msg -FunctionCall -IncludeParameters

        if ( -not [string]::IsNullOrEmpty($AtomData) ) {

            if ( $AtomData.StartsWith('Atom ') -and $AtomData -like "* contains: *" ) {

                if ( $AtomData -like "*com.apple.iTunes;iTunMOVI*" ) {
                    if ( $AtomData -like "*</plist>*" ) {
                        Write-Msg -d -il 1 -m $('Single line atom found.')
                        Write-Output $AtomData
                    }
                    else {
                        $currentAtomID = 'iTunMOVI'
                        $multiElementAtom[$currentAtomID] += $($AtomData + [System.Environment]::NewLine)
                        Write-Msg -d -il 1 -m $('Multi-line atom started.')
                    }
                }
                else {
                    Write-Msg -d -il 1 -m $('Single line atom found.')
                    Write-Output $AtomData
                }

            }
            elseif ( $AtomData -like "*</plist>*" ) {

                Write-Msg -d -il 1 -m $('Multi-line atom completed.')
                $multiElementAtom[$currentAtomID] += $AtomData
                Write-Output $multiElementAtom[$currentAtomID]

            }
            elseif ( $AtomData.Trim().StartsWith('<') -and $AtomData.Trim().EndsWith('>') ) {

                Write-Msg -d -il 1 -m $('Multi-line atom updated.')
                $multiElementAtom[$currentAtomID] += $($AtomData + [System.Environment]::NewLine)

            }

        }

    }

}