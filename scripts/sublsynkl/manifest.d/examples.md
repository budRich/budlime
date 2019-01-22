# examples

```text
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

Conclusion: all \*.sublime-settings will get copied to 
**$SUBLIME_DIR/Packages/User** and all other files,
(*with the exception for files named `README.md`*),
will be copied to **$SUBLIME_DIR/Packages** 
with retained directory structure. It will not overwrite any existing files.
