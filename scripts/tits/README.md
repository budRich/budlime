# `tits` - Prints the title of the currently open sublime window.

SYNOPSIS
--------

`tits` [`-v`|`-h`]
`tits` [`-f`][`-p`][`-s`]

DESCRIPTION
-----------

`tits` uses `xdotool` to get the title of the window with the
class name **Sublime_text**. The title looks different depending
on the status of the file, if Sublime is registered and if a project
is open. Below are the different title variations:  

``` text
# FILR (PROJECT) - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh (budlime) - Sublime Text

# FILE DIRTY (PROJECT) - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh • (budlime) - Sublime Text

# FILE - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh - Sublime Text

# FILE DIRTY - Sublime Text
~/git/lab/budlime/scripts/tits/tits.sh • - Sublime Text
```

If `tits` is executed without any arguments, the filename is printed.  


OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

`-f`
Prints the filename.

`-s`  
Prints the status (dirty|clean). dirty means that the file is not saved.

`-p`  
Prints the project name.


DEPENDENCIES
------------

Sublime Text
xdotool
