`subextract` - Creates a settings project as an alternative to the default sublime settings system.

SYNOPSIS
--------

`subextract` [`-v`|`-h`]

DESCRIPTION
-----------

`subextract` extracts files from installed packages and creates a project file
that is intended to be a better alternative to sublimes default settings system.

`subextract` will extract all *readme.md* files from all installed packages, and
move the readme to the directory $USR_DIR/dox/packages, where the files will be renamed
to: *package-name.md*. Any *sublime-settings*,*sublime-keymap* and *sublime-mousemap* files
found in the archived packages will get moved and renamed (*if needed*) to *$USR_DIR/dox/packages*.  

*sublime-settings* will also get copied to $USR_DIR if the file doesn't already exist there.

`subextract` will also create a directory with the package name inside $PKG_DIR .
(*files in this directory will overwrite the same files in the __packed__ version of the package.*).
`subextract` will add blank *sublime-settings*, in these directories. 

The thought of this is to only have one settings file (*user*) as opposed to two (read-only default and user),
as is the default behaviour of sublime. One advantage of this is that it is easier to
f.i. disable a default keybinding. And all default settings are backed up as described above,
in case something breaks.  

`subextract` will also do this with the *Default* **core** package (*/opt/sublime_text/Packages/Default.sublime-package*),
and put the *user* settings inside the directory: *$PKG_DIR/zublime*. The reason for this is
that sublime removes all comments and empty lines and auto sort, *$PKG_DIR/User/default.sublime-settings*, 
when the settings are updated (when f.i. the user changes the theme from the command palette.).

`subextract` will clone two GitHub repositories that contain the unofficial sublime documentation
and `SublimeLinter`s documentation, and copy the documentation to *$USR_DIR/dox/wiki*.

`subextract` will also create a *sublime.sublime-project* file.


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.


FILES
-----

SUB_DIR - sublimes config directory.  
defaults to: *$HOME/.config/sublime-text-3*  

TMP_DIR - temporary directory where package files get extracted to.  
defaults to: */tmp/subextract*  

ZIP_DIR - installed (*packed*) packages directory.  
defaults to: *$SUB_DIR/Installed Packages*  

PKG_DIR - (*unpacked*) packages directory.   
defaults to: *$SUB_DIR/Packages*  

USR_DIR - User package directory.  
defaults to: *$PKG_DIR/User*  

DOC_DIR - directory where readmes and wikis are stored.  
defaults to: *$USR_DIR/dox*  

DEF_DIR - directory where default config files are backed up.  
defaults to: *$DOC_DIR/defaults*  

WIK_DIR - directory where the documentation from the cloned repos will be stored.   
defaults to: *$DOC_DIR/wiki*  

OPT_DIR - core package directory
defaults to: */opt/sublime_text/Packages*  

GIT_DIR - where to store the cloned repos.
defaults to: *$HOME/git/dox*  

$USR_DIR/projects/*sublime.sublime-project*  
project file.  


DEPENDENCIES
------------

unzip  
Sublime Text  
