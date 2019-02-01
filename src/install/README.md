# install - Installs the budlime setup  

USAGE
-----

This script will make a clean install of the **budlime**
setup.

Below is a summary of the actions taken when the script is
executed:

1. Any existing packages will get moved to a backup directory (*$SUBLIME_DIR/backup*) prior to install.
2. Sublime will get launched with a *special* `Package Control.sublime-settings` file and install all *external* budlime packages.
3. `sublime-settings` files inside install packages will get extracted to `$SUBLIME_DIR/Packages/User` and a blank version of the settings file and any `sublime-keymap` and `sublime-commands` files will get placed in a directory with the same name as the package in `$SUBLIME_DIR/Packages` the extracted files will also get copied to `$SUBLIME_DIR/Pavkages/User/dox`. (these files are never interpreted by sublime, and is just stored here for reference).
4. All the files (except README.md files) in the `budlime/packages` files will get copied to `$SUBLIME_DIR`.




