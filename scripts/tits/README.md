# `tits` - Prints the title of the currently open sublime window.

SYNOPSIS
--------

`tits` [`-v`|`-h`]  
`tits` [`-f`][`-p`][`-s`][`-d`]  

DESCRIPTION
-----------

`tits` uses `wmctrl` to get the title of the window with the
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
Prints the full path of the currently open file.

`-l`  
Same as `-f` but with `~` instead of `$HOME`.

`-d`  
Prints the directory of the currently open file.

`-s`  
Prints the status (dirty|clean). dirty means that the file is not saved.

`-p`  
Prints the project name.

EXAMPLES
--------

Goto the same directory as the currently open file:  
`$ cd "$(tits -d)"`  

`$ alias cds='cd "$(tits -d)"'`  

DEPENDENCIES
------------

Sublime Text  
wmctrl  
