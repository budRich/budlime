# options-help-description
Show help and exit.

# options-version-description
Show version and exit.

# options-quite-description
Execute without output and messages.


# options-clean-description
Move the current *$PKG_DIR* to *$SUB_DIR/backup* before any other operations.  

# options-package-description
Copy files withing *PACKAGE_DIRECTORY* before any other operations.  
Example:  

``` Text
~/tmp/MyPacks
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
`$ subextract -p ~/tmp/MyPacks`  

Will result in this inside *$SUB_DIR*  

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

Conclusion: all \*.sublime-settings will get copied to *$USR_DIR* and all other files,
(*with the exception for files named `README.md`*), 
will be copied to *$PKG_DIR*
with retained directory structure. 
Existing files will not get overwritten.

# options-extract-description
Extract packages default settingfiles to *$PKG_DIR*

# options-blank-description
Blank extracted default files. (only in effect when `--extract` is used)

# options-sync-description
Sync files in *PACKAGE_DIRECTORY* with files in *$PKG_DIR*.
Works both ways, the newest file will overwrite the oldest.

# options-force-description
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (`-p`) or is newer (`-s`).
