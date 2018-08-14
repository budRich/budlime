https://github.com/rosshemsley/iOpener

Open files from path, with completion, listings and history. Similar to Emacs find file.

This package only have one function. It overrides the default open file functionality. Instead of launching the normal open file dialog (which differs depending on the OS), this package uses sublimes built in panel and command palette. It supports tab completion and if a file doesn't exist it will get created (along with needed subdirectories), making this package perfect for creating new files.

I like to set this setting:  
`"open_folders_in_new_window": false,`  

to false. That will add folders to the current project instead of opening them in a new window.
