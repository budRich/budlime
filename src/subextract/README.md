# subextract - Sync and extract packages for Sublime Text 

USAGE
-----

`subextract` can be used for one or more of the following
things:

- bulk extract (`--extract`) setting and keymap files from installed packages, and move them to the User package, while blanking (`--blank`) (*optional*) the default ones.

- sync (`--sync`) the Package directory with a package directory outside your sublime directory (*fi the packages directory in this repo*)

- move all currently installed packages (`--clean`) to a backup directory.



OPTIONS
-------

```text
subextract [--clean|-c] [--blank|-d] [--quite|-q] [--extract|-e] [--force|-f] [--sync|-s PACKAGE_DIRECTORY]
subextract --help|-h
subextract --version|-v
```


`--clean`|`-c`  
Move the current *$PKG_DIR* to *$SUB_DIR/backup* before any
other operations.  

`--blank`|`-d`  
Blank extracted default files. (only in effect when
`--extract` is used)

`--quite`|`-q`  
Execute without output and messages.


`--extract`|`-e`  
Extract packages default settingfiles to *$PKG_DIR*

`--force`|`-f`  
Force files from PACKAGE_DIRECTORY to overwrite, no matter
if target file exists (`-p`) or is newer (`-s`).

`--sync`|`-s` PACKAGE_DIRECTORY  
Sync files in *PACKAGE_DIRECTORY* with files in *$PKG_DIR*.
Works both ways, the newest file will overwrite the oldest.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.



