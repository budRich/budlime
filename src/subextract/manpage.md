`subextract` - Sync and extract packages for Sublime Text

SYNOPSIS
--------
```text
subextract [--clean|-c] [--blank|-d] [--quite|-q] [--extract|-e] [--force|-f] [--sync|-s PACKAGE_DIRECTORY]
subextract --help|-h
subextract --version|-v
```

DESCRIPTION
-----------
`subextract` extracts files from installed
packages and creates a project file that is
intended to be a better alternative to sublimes
default settings system.

`subextract` will extract all *readme.md* files
from all installed packages, and move the readme
to the directory $USR_DIR/dox/packages, where the
files will be renamed to: *package-name.md*. Any
*sublime-settings*,*sublime-keymap* and
*sublime-mousemap* files found in the archived
packages will get moved and renamed (*if needed*)
to *$USR_DIR/dox/packages*.  

*sublime-settings* will also get copied to
$USR_DIR if the file doesn't already exist there.

`subextract` will also create a directory with
the package name inside $PKG_DIR . (*files in this
directory will overwrite the same files in the
__packed__ version of the package.*). `subextract`
will add blank *sublime-settings*, in these
directories.

The thought of this is to only have one settings
file (*user*) as opposed to two (read-only default
and user), as is the default behaviour of sublime.
One advantage of this is that it is easier to f.i.
disable a default keybinding. And all default
settings are backed up as described above, in case
something breaks.  

`subextract` will also do this with the *Default*
**core** package
(*/opt/sublime_text/Packages/Default.sublime-package*),
and put the *user* settings inside the directory:
*$PKG_DIR/zublime*. The reason for this is that
sublime removes all comments and empty lines and
auto sort,
*$PKG_DIR/User/default.sublime-settings*,  when
the settings are updated (when f.i. the user
changes the theme from the command palette.).

`subextract` will also create a *sublime.sublime-project* file.


OPTIONS
-------

`--clean`|`-c`  
Move the current *$PKG_DIR* to *$SUB_DIR/backup*
before any other operations.  

`--blank`|`-d`  
Blank extracted default files. (only in effect
when `--extract` is used)

`--quite`|`-q`  
Execute without output and messages.


`--extract`|`-e`  
Extract packages default settingfiles to
*$PKG_DIR*

`--force`|`-f`  
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (`-p`) or is newer
(`-s`).

`--sync`|`-s` PACKAGE_DIRECTORY  
Sync files in *PACKAGE_DIRECTORY* with files in
*$PKG_DIR*. Works both ways, the newest file will
overwrite the oldest.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


ENVIRONMENT
-----------

`SUBLIME_DIR`  
sublimes config dir location. usually located at:
 `~/.config/sublime-text-3`
defaults to: $XDG_CONFIG_HOME/sublime-text-3

FILES
-----
$SUB_DIR - sublimes config directory.  
defaults to: *$HOME/.config/sublime-text-3*  

$OPT_DIR - core package directory defaults to:
*/opt/sublime_text/Packages*  

$TMP_DIR - temporary directory where package
files get extracted to.  
defaults to: */tmp/subextract*  

$ZIP_DIR - installed (*packed*) packages
directory.  
defaults to: *$SUB_DIR/Installed Packages*  

$PKG_DIR - (*unpacked*) packages directory.  
defaults to: *$SUB_DIR/Packages*  

$USR_DIR - User package directory.  
defaults to: *$PKG_DIR/User*  

$DOC_DIR - directory where readmes and wikis are
stored.  
defaults to: *$USR_DIR/dox*  

$DEF_DIR - directory where default config files
are backed up.  
defaults to: *$DOC_DIR/defaults*  

$USR_DIR/projects/*sublime.sublime-project*  
project file.  

DEPENDENCIES
------------
`bash`
`gawk`
`unzip`
`sublime_text`


