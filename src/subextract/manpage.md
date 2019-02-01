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
`subextract` can be used for one or more of the
following things:

- bulk extract (`--extract`) setting and keymap files from installed packages, and move them to the User package, while blanking (`--blank`) (*optional*) the default ones.

- sync (`--sync`) the Package directory with a package directory outside your sublime directory (*fi the packages directory in this repo*)

- move all currently installed packages (`--clean`) to a backup directory.



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



