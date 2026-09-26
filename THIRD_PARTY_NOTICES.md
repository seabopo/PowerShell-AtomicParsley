# Third-Party Notices

The po.AtomicParsley PowerShell module (Copyright (c) 2024 seabopo, MIT License, see `LICENSE`) is a
wrapper around the AtomicParsley command-line program.

**This module does not include, bundle, or redistribute AtomicParsley.** You install AtomicParsley
separately (Homebrew, Chocolatey, a Linux package manager, or a release download from GitHub). The
module runs the `AtomicParsley` executable found on your system PATH as a separate process. It does
not link to or include any AtomicParsley code.

The notices below give attribution and tell you which license applies to the software this module
depends on at runtime.

## AtomicParsley

| | |
|-|-|
| Project | [AtomicParsley](https://github.com/wez/atomicparsley) |
| Original author | puck_lock (2005-2007) |
| Current maintainer | Wez Furlong |
| License | GNU General Public License, "either version 2 or its successor" (GPL-2.0-or-later) |
| License text and copyright holders | [`ATOMICPARSLEY_LICENSE`](ATOMICPARSLEY_LICENSE) (AtomicParsley's `CREDITS` and `COPYING` files) |
| Source code | https://github.com/wez/atomicparsley |

This module and its author are not affiliated with the AtomicParsley project.

### Why this MIT module can use a GPL program

The GPL applies to AtomicParsley and to works derived from its code. This module contains none of
AtomicParsley's code; it builds command lines and runs AtomicParsley as a separate program. The
module is therefore a separate work and is licensed under the MIT License. Your use of AtomicParsley
itself is governed by the GPL.

### AtomicParsley material in this repository

`AtomicParsleyHelp.txt`, in the root of this repository, is a verbatim copy of AtomicParsley's help
output, kept for reference. It is part of AtomicParsley, is licensed under the GPL (not the MIT
License), and carries AtomicParsley's copyright notice. It is not included in the published module.

`data/atoms.csv` in the module is this project's own table mapping PowerShell property names to
MPEG-4 atom identifiers and AtomicParsley parameter names. It is not copied from AtomicParsley.

### If you redistribute AtomicParsley with this module

If you package this module together with an AtomicParsley binary (for example, in a container image
or installer), you are distributing AtomicParsley and must comply with the GPL yourself. That
includes providing the license text and copyright notices, and making the corresponding source code
available.
