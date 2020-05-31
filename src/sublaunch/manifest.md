---
description: >
  Run or raise sublime with a specific profile and file
updated:       2020-05-31
version:       2020.05.31.0
author:        budRich
repo:          https://github.com/budlabs
created:       2018-08-06
dependencies:  [bash, xdotool, sublget, sublime_text]
see-also:      [bash(1), xdotool(1), sublget(1)]
environ:
    SUBLIME_TITS_CRIT:  class
    SUBLIME_TITS_SRCH:  Sublime_text
    SUBLIME_PROJECTS_DIR: $XDG_CONFIG_HOME/sublime-text-3/Packages/User/Projects
synopsis: |
    [--instance|-i INSTANCE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
    [--class|-c    CLASS] [--options|-o  OPTIONS] [--project|-j  PROJECT] [FILE]
    [--profile|-p  PROFILE] [--options|-o  OPTIONS] [--project|-j  PROJECT] [--wait|-w] [FILE]
    --help|-h
    --version|-v
...

# long_description

`sublaunch` takes a number of criterion to identify a sublime window.
If `sublaunch` can' find a open window matching the criteria.
A new sublime window will be opened and it's **instance name** will be renamed to match the criteria.

