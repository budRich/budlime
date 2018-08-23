# `tits` - Prints the title of the currently open sublime window.

SYNOPSIS
--------

`tits` [`-v`|`-h`]  
`tits` [ [`-c` CLASS]|[`-i` INSTANCE] ][`-fpsdna`]  

DESCRIPTION
-----------

`tits` uses `wmctrl` to get the title of the window with the
class name **Sublime_text**. The title looks different depending
on the status of the file, if Sublime is registered and if a project
is open. Below are the different title variations:  

``` text
# FILE (PROJECT) - Sublime Text
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
Prints the status (dirty=1|clean=0).  
Dirty means that the file is not saved.  

`-a`  
Prints the `1` if the window is focused.  
Otherwise `0` is printed.    

`-n`  
Prints the window ID of the found window.   

`-p`  
Prints the project name.

`-c` *CLASS*  
Sets `SUBLIME_TITS_CRIT` to c and  
`SUBLIME_TITS_SRCH` to *CLASS*  

`-i` *INSTANCE*  
Sets `SUBLIME_TITS_CRIT` to i and  
`SUBLIME_TITS_SRCH` to *INSTANCE*  

EXAMPLES
--------

Goto the same directory as the currently open file:  
`$ cd "$(tits -d)"`  

`$ alias cds='cd "$(tits -d)"'`  

ENVIRONMENT
-----------
SUBLIME_TITS_CRIT  
Default criteria to use if `-c` or `-i` is not set.
Defaults to "c"  

SUBLIME_TITS_SRCH
Default search string to use if `-c` or `-i` is not set.
Defaults to "Sublime_text"  

DEPENDENCIES
------------

Sublime Text  
wmctrl  
