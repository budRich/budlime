# `sublaunch` - Run or raise sublime with a specific profile and file

SYNOPSIS
--------

`sublaunch` [`-v`|`-h`]   

DESCRIPTION
-----------

`sublaunch` takes a number of criterion to identify
a sublime window. If `sublaunch` can' find a open window
matching the criteria. A new sublime window will be opened
and it's **instance name** will be renamed to match the criteria.

OPTIONS
-------

`-v|--version`
Show version and exit.

`-h|--help`
Show help and exit.

`-c|--class` CLASS
Set the criterion to be a window with the class CLASS.  

`-i|--instance` INSTANCE  
Set the criterion to be a window with the instance name 
INSTANCE. Defaults to the value of SUBLIME_TITS_SRCH.  

`-p|--profile` PROFILE   
Set the criterion to be a window with the instance name: 
`sublime_PROFILE`. And if a project in $PROJECT_DIR with
the name PROFILE.sublime-project exist. That project will
get opened if the window doesn't exist.  

`-j|--project` PROJECT
If a project in $PROJECT_DIR with
the name PROJECT.sublime-project exist. That project will
get opened if the window doesn't exist. If both this
and `--profile` is set, `--profile` will have priority.  

`-o|--otions` OTIONS  
Additional commandline otions that will get passed to sublime
sublime \(`subl`\) when a new window is created.

ENVIRONMENT
-----------

`FOOCONF`
If non-null the full pathname for an alternate system wide */etc/foo.conf*.
Overridden by the `-c` option.

DEPENDENCIES
------------

go-md2man
i3get
Sublime Text  
