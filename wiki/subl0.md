---
title: "sublime_setup"
date: 2017-10-17T01:30:22+02:00
author: "budRich"
draft: true
type: post
target: budlime/articles
tags: ["sublime","setup","rice"]
notes:
  - "lnk: budtutor, settings, keymap"
  - "https://www.reddit.com/r/SublimeText/"
---
Below is a guide on how I like to set up [Sublime Text](http://www.sublimetext.com/). Keyboard friendly and minimal UI is my aim. For info on using Sublime i recommend my custom mashup of VIMtutor and Sublime tutor, [budtutor](link).

If you are using Atom or VS code, please read this article:  
https://medium.com/@caspervonb/why-i-still-use-vim-67afd76b4db6

Or this...  
https://github.com/Microsoft/vscode/issues/35783

-----------------------------------------

locate files
------------

I have a lot of custom settings and a personal package collection. It is a pain to achieve the same setup on a fresh install of Sublime. 

I have found a really neat way to keep my settings in sync and backed up with [Dropbox](https://db.tt/eFkf49MZ).

After installation, make sure Sublime isn't running and move the folder `sublime-text-3` inside `~/.config` to your Dropbox folder. Then make a symbolic link of the folder in it's original place.

Now your sublime configuration and setup will be backed-up automagicly!

(the easiest way to create symbolic links is to open two file manager windows and just drag and drop the folder while holding `ctrl+shift`)

Whether you do this or not, your sublime setting files will have a very inconvenient path. My recommendation is to create a folder in your home folder, call it 'settings' or 'dots' or similar. Inside that folder create a folder called sublime. And make symbolic links inside that folder from your sublime-text-3 folder on Dropbox to the following files:

- sublime-text-3/Packages/User/Default (Linux).sublime-keymap
- sublime-text-3/Packages/User/Preferences.sublime-settings
- sublime-text-3/Packages/Default/Default (Linux).sublime-keymap
- sublime-text-3/Packages/Default/Preferences.sublime-settings

Name the links keymap, settings, keymap_default, settings_default.

Now you can add the sublime folder to your project for easy access to the setting files.

To add a folder to the project, choose `Add folder to project...` in the `Project` menu (`alt+p`). You can toggle the sidebar that shows your project files and folders with this hotkey: `ctrl+k+b` (hold control press `k` keep holding control and press `b`).

I know that you can open settings from the Preferences menu, but I am not so fond of this technique. It opens a new window with both the default and user version of the settings open and it just feels clunky. By adding the folder to the project you can just hit `ctrl+p` in sublime and search for the files.

Below is a simple tree showing the folder structure in a more graphical way:

``` shell
~ <- Home folder
  .config
    sublime-text-3 <- linked folder
  dot
    sublime
      keymap <- this is a link
      settings_default <- this is a link
  Dropbox
    sublime-text-3 <- original folder
      Packages
        User
          Default (Linux).sublime-keymap
        Default
          Preferences.sublime-settings
```

configuration
-------------

First thing we want to do is enable and optimize Sublime for Vintage mode. Vintage enables basic VIM-like navigation. Open the settings file (if you followed the guide above, you can just hit `ctrl+p` and locate the settings file).

To enable vintage, remove it from the ignored packages setting.

**Before:**

``` shell
"ignored_packages":
[
  "Vintage"
],
```

**After**:

`"ignored_packages":[],`

I also recommend you add this setting:
`"vintage_start_in_command_mode": true`  

In your keymap file I recommend you add the following rules:

``` shell
{ "keys": ["alt+shift+k"], "command": "select_lines", "args": {"forward": false} },
{ "keys": ["alt+shift+j"], "command": "select_lines", "args": {"forward": true} },
{ "keys": ["ctrl+shift+k"], "command": "swap_line_up" },
{ "keys": ["ctrl+shift+j"], "command": "swap_line_down" },

{"keys": ["up"], "command": "pass", "context":
[ { "key": "setting.is_widget", "operand": false } ] },
{"keys": ["down"], "command": "pass", "context":
[ { "key": "setting.is_widget", "operand": false } ] },
{"keys": ["left"], "command": "pass", "context":
[ { "key": "setting.is_widget", "operand": false } ] },
{"keys": ["right"], "command": "pass", "context":
[ { "key": "setting.is_widget", "operand": false } ] },

{ "keys": ["j", "j"], "command": "exit_insert_mode",
"context":
[
  { "key": "setting.command_mode", "operand": false },
  { "key": "setting.is_widget", "operand": false }
]
}
```

With these settings, navigation with the arrow keys are disabled, forcing you to embrace VIM-navigation.

You can create multiple cursors with `alt+shift+j/k` and move lines with `ctrl+shift+j/k` to keep your fingers on the homerow.

The last rule, lets you 'Escape' insert_mode by typing `jj` instead of hitting that Escape key, so far from the homerow.

A even better way to have easy access to 'Escape' is to install `xcape` (`sudo apt install xcape`) and add this to your `~/.profile`:

``` shell
setxkbmap -option caps:ctrl_modifier  
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
```

Now your control keys acts as `Escape` if they are pressed 'alone' and as a bonus your stupid CapsLock key is also a control key!

packages
--------

There is a lot of third-party-packages available to Sublime. The easiest way to manage packages is by using the unofficial package manager, `Package Control` i recommend you [install](https://packagecontrol.io/installation) that first. 

When Package Control is installed you can install more packages inside sublime by choosing 'Package Control: Install Package' from the command palette (`ctrl+shift+p`).

But I recommend you check the packages homepage (most likely a github repo) before installing. Some packages might be abandoned or broken..

These are packages that I use and can recommend:

- [Clickable URLs](https://github.com/leonid-shevtsov/ClickableUrls_SublimeText)
- [iOpener](https://github.com/rosshemsley/iOpener)
- [File Rename](https://github.com/brianlow/FileRename)
- [Zen Tabs](https://github.com/travmik/ZenTabs)
- [AlignTab](https://github.com/randy3k/AlignTab)

files
-----

I have my Sublime [settings](/dots/sublime/settings) and [keymap](/dots/sublime/keymap) files on this site if you are interested, but i wouldn't recommend you just copy pasted them. There are many settings that are dependent on third-party-packages.

And as I mentioned at the beginning of this article, I have made a mashup of VIMtutor and Sublime Tutor, that I call [budtutor](link) which is a good way to learn and remember all commands and hotkeys.
