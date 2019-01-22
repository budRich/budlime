# sublsynkl - Creates a settings project as an alternative to the default sublime settings system. 

USAGE
-----

`sublsynkl` extracts files from installed packages and
creates a project file that is intended to be a better
alternative to sublimes default settings system.

`sublsynkl` will extract all *readme.md* files from all
installed packages, and move the readme to the directory
**$SUBLIME_DIR/Packages/User/dox/packages**,  where the
files will be renamed to: *package-name.md*.  Any
*sublime-settings*,*sublime-keymap* and *sublime-mousemap*
files found in the archived packages will get moved and
renamed  (*if needed*) to
**$SUBLIME_DIR/Packages/User/dox/packages**.  

*sublime-settings* will also get copied to
**$SUBLIME_DIR/Packages/User**  if the file doesn't already
exist there.

`sublsynkl` will also create a directory with the package
name inside **$SUBLIME_DIR/Packages**. `sublsynkl` will add
blank *sublime-settings*, in these directories.  (*files in
this directory will overwrite the same files in the
__packed__ version of the package.*).  

The thought of this is to only have one settings file
(*user*) as opposed to two the default behaviour of sublime
(read-only default and user), One advantage of this is that
it is easier to f.i. disable a default keybinding. And all
default settings are backed up as described above, in case
something breaks.  

`sublsynkl` will also do this with the *Default* **core**
package (**$SUBLIME_SRC/Packages/Default.sublime-package**),
and put the *user* settings inside the directory: 
**$SUBLIME_DIR/Packages/zublime**. The reason for this is
that sublime removes all comments, empty lines and  auto
sort,
**$SUBLIME_DIR/Packages/User/default.sublime-settings**,
when the settings are updated (when f.i. the user changes
the theme from the command palette.).

`sublsynkl` will also create a *sublime.sublime-project* file.


OPTIONS
-------

```text
sublsynkl --packages|-p PACKAGE_DIRECTORY [--clean|-c] [--blank|-d] [--extract|-e] [--force|-f] 
sublsynkl --sync|-s PACKAGE_DIRECTORY  [--force|-f]
sublsynkl --help|-h
sublsynkl --version|-v
```


`--packages`|`-p` PACKAGE_DIRECTORY  
Copy files withing *PACKAGE_DIRECTORY* before any other
operations.  


`--clean`|`-c`  
Clean install. Move the current **$SUBLIME_DIR/Packages**
to *$SUBLIME_DIR/backup* before any other operations.  

`--blank`|`-d`  
Blank extracted default files. (only have effect if
`--extract` is used)

`--extract`|`-e`  
Extract packages default setting files to
**$SUBLIME_DIR/Packages**.

`--force`|`-f`  
Force files from PACKAGE_DIRECTORY to overwrite, no matter
if target file exists (when used with `--packages`)  or is
newer (when used with `--sync`).

`--sync`|`-s` PACKAGE_DIRECTORY  
Sync files in *PACKAGE_DIRECTORY* with files in
**$SUBLIME_DIR/Packages**. Works both ways, the newest file
will overwrite the oldest.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.

EXAMPLES
--------
```text~/tmp/MyPacks
  iOpener
    iOpener.sublime-settings
    Default.sublime-keymap
    random.file
    A-dir/
      picture.jpg
  A File Icon
    A File Icon.sublime-settings
    README.md
```


Executing the following command:  
`$ subextract --packages ~/tmp/MyPacks`  

Will result in this inside *$SUBLIME_DIR*  

``` text
~/.config/sublime-text-3/Packages
  iOpener
    Default.sublime-keymap
    random.file
    A-dir/
      picture.jpg
  User
    iOpener.sublime-settings
    A File Icon.sublime-settings
```


Conclusion: all \*.sublime-settings will get copied to  **$SUBLIME_DIR/Packages/User** and all other files, (*with the exception for files named `README.md`*), will be copied to **$SUBLIME_DIR/Packages**  with retained directory structure. It will not overwrite any existing files.



