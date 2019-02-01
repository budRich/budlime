---
description: >
  Sync and extract packages for Sublime Text
updated:       2019-02-01
version:       2019.02.01.2
author:        budRich
repo:          https://github.com/budlabs
created:       2018-08-05
type:          default
dependencies:  [bash, gawk, unzip, sublime_text]
see-also:      [bash(1), awk(1), unzip(1)]
environ:
    SUBLIME_DIR: $XDG_CONFIG_HOME/sublime-text-3
synopsis: |
    [--clean|-c] [--blank|-d] [--quite|-q] [--extract|-e] [--force|-f] [--sync|-s PACKAGE_DIRECTORY]
    --help|-h
    --version|-v
...

# long_description

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

`subextract` will also create a *sublime.sublime-project* file.
