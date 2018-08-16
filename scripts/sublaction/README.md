# `sublaction` - Do stuff with the currently open file in sublime

SYNOPSIS
--------

`sublaction` [[`-v|--version`]|[`-h|--help`]]
`sublaction` `--menu`|`-m`

DESCRIPTION
-----------

`sublaction` uses `tits` to get information about the
currently open file in sublime. If `sublaction` is
executed without any arguments, it will try to figure
out the action by it self by analyzing the path of the
file. If it can' figure out tha action or if the
`-m|--menu` option is used. A rofi menu with options
will be displayed. 

OPTIONS
-------

`-v`  
Show version and exit.

`-h`  
Show help and exit.

DEPENDENCIES
------------

go-md2man  
tits  
Sublime Text  
oneliner  
rofi  
