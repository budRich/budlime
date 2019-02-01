## [Delete Current File] - Adds a "DeleteCurrentFile: Delete File" command which deletes the current file and closes the current buffer. 
by: [yaworsw]

I added this package because i found myself firing up the context menu in the sidebar often to delete files. I wanted a more vim/Vintage like approach, and added the key combination:
<key>Z</key> <key>Q</key>  

to execute the action when in command mode.
It is set to move the file to "trash" without prompting.
But you can adjust this in the settings file.

---

<key>Z</key> <key>Z</key> will save and close the current file (*default vim binding*)  
<key>Z</key> <key>X</key> will close the current file without saving (useful when the current "file" is not really a file, fi. the find buffer or package control settings.)

[Delete Current File]: https://github.com/yaworsw/Sublime-DeleteCurrentFile
[yaworsw]: https://packagecontrol.io/browse/authors/yaworsw
