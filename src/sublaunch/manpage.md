`sublaunch` - Run or raise sublime with a specific profile and file

SYNOPSIS
--------
```text
sublaunch [--instance|-i INSTANCE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
sublaunch [--class|-c    CLASS] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
sublaunch [--profile|-p  PROFILE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [--wait|-w] [FILE]
sublaunch --help|-h
sublaunch --version|-v
```

DESCRIPTION
-----------
`sublaunch` takes a number of criterion to
identify a sublime window. If `sublaunch` can'
find a open window matching the criteria. A new
sublime window will be opened and it's **instance
name** will be renamed to match the criteria.


OPTIONS
-------

`--instance`|`-i` INSTANCE  
Set the criterion to be a window with the
instance name INSTANCE. Defaults to the value of
SUBLIME_TITS_SRCH.

`--options`|`-o` OPTIONS  
Additional commandline otions that will get
passed to sublime sublime (`subl`) when a new
window is created.



`--project`|`-j` PROJECT  
If a project in $PROJECT_DIR with the name
PROJECT.sublime-project exist. That project will
get opened if the window doesn't exist. If both
this and `--profile` is set, `--profile` will have
priority.

`--class`|`-c` CLASS  
Set the criterion to be a window with the class
name CLASS. Defaults to the value of
SUBLIME_TITS_SRCH.

`--profile`|`-p` PROFILE  
Set the criterion to be a window with the
instance name: `sublime_PROFILE`. And if a project
in $PROJECT_DIR with the name
PROFILE.sublime-project exist. That project will
get opened if the window doesn't exist.

`--wait`|`-w` [FILE]  

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


ENVIRONMENT
-----------

`SUBLIME_TITS_CRIT`  
Default criteria to use if `--class` or
`--instance` is not set.
defaults to: class

`SUBLIME_TITS_SRCH`  
Default search string to use if `--class` or
`--instance` is not set.
defaults to: Sublime_text

`SUBLIME_PROJECTS_DIR`  
Directory where sublime project files are
located.
defaults to: $XDG_CONFIG_HOME/sublime-text-3/Packages/User/Projects

DEPENDENCIES
------------
`bash`
`xdotool`
`sublget`
`sublime_text`



