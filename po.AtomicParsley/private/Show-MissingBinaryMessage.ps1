function Show-MissingBinaryMessage {
    <#
    .DESCRIPTION
        Displays a message to the user to explaining the module's binary requirements.
    #>
    [OutputType([void])]
    [CmdletBinding()]
    param ( )

    process {

        try {

            Write-Msg -p -ps -m 'Alerting the user about the module binary requirements ...'

            $msg = @(

                'This PowerShell module requires AtomicParsley to be installed.','',

                'AtomicParsley is a command-line tool for reading, writing and manipulating',
                'metadata in audio and video files. This tool is an open-source project',
                'and is available for free on GitHub ( https://github.com/wez/atomicparsley )',
                'under the GPL-2.0 license (GNU GENERAL PUBLIC LICENSE Version 2).','',

                'On MacOS, the AtomicParsley binary can be installed using Homebrew with the',
                'following command: $ brew install atomicparsley','',

                'On Windows, the AtomicParsley binary can be installed using Chocolatey with the',
                'following command: $ choco install atomicparsley','',

                'Windows uses also need to have the Visual C++ Redistributable for Visual Studio 2015',
                'installed. https://www.microsoft.com/en-us/download/details.aspx?id=48145','',

                'Users of all operating systems can download the latest version from the releases',
                'page of the project site: https://github.com/wez/atomicparsley/releases','',

                'When installing AtomicParsley using Homebrew or Chocolatey the AtomicParsley path',
                'will automatically be added to the operating system PATH environment variable.',
                'If AtomicParsley was installed manually you can either:',
                ' - Add the AtomicParsley path to your your system PATH environment variable.',
                ' - Specify the AtomicParsley path in your PowerShell script using the',
                '   PS_ATOMIC_PARSLEY_PATH environment variable. For example:',
                '     - $env:PS_ATOMIC_PARSLEY_PATH = "C:\Program Files\AtomicParsley\atomicparsley.exe"',
                '     - $env:PS_ATOMIC_PARSLEY_PATH = "/usr/local/bin/atomicparsley"','',

                'Please note that this module is only tested against AtomicParsley release version',
                $('"{0}"' -f $PS_ATOMIC_PARSLEY_VERSION),'',

                'For additional information see https://github.com/seabopo/PowerShell-AtomicParsley',''

            ) -join [System.Environment]::NewLine

            Write-Msg -a -m $msg

        }
        catch {
            $errMsg = "An error occurred while attempting to inform the user of the module's installation requirements."
            Write-Msg -x -m $( "{0} `r`n" -f $errMsg ) -o $_
        }

    }

}
