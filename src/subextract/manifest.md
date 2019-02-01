---
description: >
  Sync and extract packages for Sublime Text
updated:       2019-02-01
version:       2019.02.01.3
author:        budRich
repo:          https://github.com/budlabs
created:       2018-08-05
type:          default
dependencies:  [bash, gawk, unzip, sublime_text]
see-also:      [bash(1), awk(1), unzip(1)]
environ:
    SUBLIME_DIR: $XDG_CONFIG_HOME/sublime-text-3
synopsis: |
    [--clean|-c] [--blank|-d] [--quite|-q] [--extract|-e] [--force|-f] [--sync|-s PACKAGE_DIRECTORY]
    --help|-h
    --version|-v
...

# long_description

`subextract` can be used for one or more of the following things:

- bulk extract (`--extract`) setting and keymap files from installed packages, and move them to the User package, while blanking (`--blank`) (*optional*) the default ones.
- sync (`--sync`) the Package directory with a package directory outside your sublime directory (*fi the packages directory in this repo*)
- move all currently installed packages (`--clean`) to a backup directory.

