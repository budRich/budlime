---
description: >
  Prints the title of the currently open sublime window
updated:       2019-02-01
version:       2019.02.01.0
author:        budRich
repo:          https://github.com/budlabs/budlime
created:       2018-08-06
dependencies:  [bash, gawk, wmctrl, sublime_text]
see-also:      [bash(1), awk(1), wmctrl(1)]
environ:
    SUBLIME_TITS_CRIT:  class
    SUBLIME_TITS_SRCH:  Sublime_text
synopsis: |
    [--follow|-o] [--long|-l] [--print|-r OUTPUT]
    --class|-c CLASS  [--follow|-o] [--long|-l] [--print|-r OUTPUT]
    --instance|-i INSTANCE [--follow|-o] [--long|-l] [--print|-r OUTPUT] 
    --help|-h
    --version|-v
...

# long_description

`sublget` uses `wmctrl` to get the title of the window with the class name **Sublime_text**. The title looks different depending on the status of the file, if Sublime is registered and if a project is open. Below are the different title variations:  

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

If `sublget` is executed without any arguments, the filename is printed.

EXAMPLES
--------

Goto the same directory as the currently open file:  
`$ cd "$(sublget -d)"`  

`$ alias cds='cd "$(sublget -d)"'`  
