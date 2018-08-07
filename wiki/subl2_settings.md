---
title: "sublime_setup_settings"
date: 2017-10-23T10:01:40+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime","setup"]
notes:
---
Sublime is a very advanced, extendable and hackable text editor. This comes with a price (well in this case, two prices, since it cost dollars): The settings of the program can be a bit confusing and difficult to organize and maintain. 

It doesn't help that the default UI for editing the settings in Sublime is completely messed up IMO.

[screenshot of settings UI]

I have found a good way to manage the settings, but it will require some more or less advanced moving of files.

step 1: create user setting files:
----------------------------------
Open the preferences menu and select `Settings`.
[screen shot of menu]
The stupid split settings window will appear, with the, read-only, default settings to the left. And your user settings to the right. The syntax is JSON for most setting files in sublime. Add a some kind of change to your user setting file and save it. (if you don't know what to change you just make a comment by prefixing a line with two slashes `// `). Close the settings window by hitting `ctrl+w`.

Now choose `Key Bindings` from the Preferences menu and do the same thing for these files. Also close this window with `ctrl+w` and then quit sublime with `ctrl+q`.

*It is important you close the setting windows before quitting sublime, otherwise you will have a empty split extra window the next time you launch sublime. Which is even more reason to follow this technique for settings management.*

step 2: locating the user setting files:
----------------------------------------
Sublime store it's settings like most programs inside the `.config` folder in your home folder. Your setting files are created at this location: `$HOME/.config/sublime-text-3/Packages/User`  

It can be worth mentioning that if you delete the folder `sublime-text-3` from your `.config` folder, and launch sublime, it will create a new one with the default settings. You can also create *restore points* of a setup by making a copy of the current `sublime-text-3` , i recommend that you do that while following this guide, because it is not impossible things get messed up along the way.

I use [Dropbox](https://db.tt/eFkf49MZ) to be sure i have my files and settings backed up. And a very convenient way to sync sublime settings is to move the `sublime-text-3` folder to your Dropbox folder and then symlink it back to `.config`. I do this and if you do too, all further references to the `sublime-text-3` folder in this guide are referring to the folder on Dropbox, and not the link folder. This is important!

step 3: linking the user setting files:
---------------------------------------
As you might have guessed an alternative way to edit the settings are to open them from directly from `sublime-text-3/Packages/User` . However, there are some drawbacks in doing so:

1. The path to the files is too long for easy access.

2. The filenames are strange, and as we soon will see exactly the same as the default setting files.

3. If you made a symlink to Dropbox or similar, it will be hard to tell if you have opened the file from Dropbox or the .config folder. 

All these might sound trivial, but trust me, the Sublime tab bar will clutter up and become totally messed up if we don't take care of this right away.

Create a new folder somewhere in your home folder. For example: `~/tmp/sublime-settings` . I will refer to this folder as `sublime-settings` throughout the guide.

Inside `sublime-settings` create two more folders called `settings` and `keys`. 

Now make symbolic links of your user settings to these folders. And rename the links to:  
`user.sublime-settings`
`user.sublime-keymap`

It is important that the links are symbolic soft links and not hard links or copies!

When you are done you should have something resembling this:

``` shell
~ <- Home folder
  .config
    sublime-text-3 <- symbolic link to Dropbox/sublime-text-3
  Dropbox
    sublime-text-3
      Packages
        User
          Default (Linux).sublime-keymap
          Preferences.sublime-settings
  tmp
    sublime-settings
      settings
        user.sublime-settings <- soft link
      keys
        user.sublime-keymap <- soft link

```

Now we just have to find the *Default* settings files. But to do so we need to install some third-party-packages. That deserves a guide on it's own.
