---
description: >
  Creates a settings project as an alternative to the default sublime settings system.
updated:       2019-01-18
version:       2019.01.18.10
author:        budRich
repo:          https://github.com/budlabs
created:       2018-08-05
dependencies:  [bash, unzip, sublime_text]
see-also:      [bash(1), unzip(1)]
environ:
    SUBLIME_DIR: $XDG_CONFIG_HOME/sublime-text-3
    SUBLIME_SRC: /opt/sublime_text
synopsis: |
    --packages|-p PACKAGE_DIRECTORY [--clean|-c] [--blank|-d] [--extract|-e] [--force|-f] 
    --sync|-s PACKAGE_DIRECTORY  [--force|-f]
    --help|-h
    --version|-v
...

# long_description

`sublsynkl` extracts files from installed packages and creates a project file
that is intended to be a better alternative to sublimes default settings system.

`sublsynkl` will extract all *readme.md* files from all installed packages, and
move the readme to the directory **$SUBLIME_DIR/Packages/User/dox/packages**, 
where the files will be renamed to: *package-name.md*. 
Any *sublime-settings*,*sublime-keymap* and *sublime-mousemap* files
found in the archived packages will get moved and renamed 
(*if needed*) to **$SUBLIME_DIR/Packages/User/dox/packages**.  

*sublime-settings* will also get copied to **$SUBLIME_DIR/Packages/User** 
if the file doesn't already exist there.

`sublsynkl` will also create a directory with the package name inside **$SUBLIME_DIR/Packages**.
`sublsynkl` will add blank *sublime-settings*, in these directories. 
(*files in this directory will overwrite the same files in the __packed__ version of the package.*).  

The thought of this is to only have one settings file (*user*)
as opposed to two the default behaviour of sublime (read-only default and user),
One advantage of this is that it is easier to f.i. disable a default keybinding.
And all default settings are backed up as described above,
in case something breaks.  

`sublsynkl` will also do this with the *Default* **core** package
(**$SUBLIME_SRC/Packages/Default.sublime-package**),
and put the *user* settings inside the directory: 
**$SUBLIME_DIR/Packages/zublime**.
The reason for this is that sublime removes all comments, empty lines and 
auto sort, **$SUBLIME_DIR/Packages/User/default.sublime-settings**,
when the settings are updated (when f.i. the user changes the theme from the command palette.).

`sublsynkl` will also create a *sublime.sublime-project* file.
