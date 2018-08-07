---
title: "sublime_setup_install_packages"
date: 2017-10-23T14:35:55+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime"]
notes:
---
We have already installed two packages, 'Package Control' and 'Extract Sublime Packages'. These two packages are essential for a successful package organization, and in this article I will show you why, and how.

Before we start installing more packages we should make a setting for the 'Extract Sublime Packages' package.

Remember we kept the extracted version of the package inside the `user-packages` folder. All packages installed with 'Package Control' comes with a, often very useful, `readme.md` file. Some packages gives you a way to view this file, (look in the menu `Preferences/Package Settings`), but most keep it in the archived version of the package. This is the main reason you should always extract new packages, so you can RTFM!

Open this file:  
`sublime-text-3/Packages/Extract Sublime Package/readme.md`

Inside you are informed that you can add a setting that will let you extract a package when you open the archived version in sublime. We want this, to enable it add this to your `user.sublime-setting` inside your `sublime-settings` folder.  

`"extract_sublime_package_ask_on_open": true`   

Save the settings file to enable the new setting.

If the instructions above was a bit confusing, look at this folder representation:  

``` shell
~ <- Home folder
  .config
    sublime-text-3 <- symbolic link to Dropbox/sublime-text-3
  Dropbox
    sublime-text-3
      Packages
        User
          Preferences.sublime-settings
        Extract Sublime Package
          readme.md <- find the setting in this file

  tmp
    sublime-settings
      user.sublime-settings <- soft link, add the setting to this file.

```

*If the readme.md contains a lot of stuff you want to have easier access to, I recommend making a **copy** of the readme.md to:*  
`sublime-settings/doc/ExtractSublimePackage.md`

-------

clickable URLs
--------------
Now we are prepared to install some more packages, lets start with a basic but very handy package that let us open URLs in files, in a convenient way.

*The readme.md files most often contain links that can be very interesting to visit to be able to understand and use the functionality provided by the package to the fullest.*

Open the `Command palette` and `Package Control: Install Packag`. Install the package: `Clickable URLs`.

Once it is installed you should see the archived version of it inside the `installed-packages` folder. Notice that you don't have it in extracted form in the `user-packages` folder. yet.

Open the archived version of 'Clickable URLs' in Sublime. (an easy way to do this is to just select the file from the project/sidebar). If the setting we added earlier you should get a dialog-window asking you if you want to extract the package. You want that.

[screenshot of dialog]

Now the package is extracted to the `user-packages` folder and we can look at the readme.md. This one has quite a lot of information and it tells you that the default hotkey to open a link in your browser is:  
`ctrl+alt+Enter`, try this to see if it works.

I had to define my browser for it to work by adding this setting:

``` json
{
    "clickable_urls_browser": "/usr/bin/surf %s &"
}
```

But this package, and many others, doesn't read the preferences from your normal user file, but from it's own user file, located at: `/sublime-text-3/Packages/User/ClickableUrls.sublime-settings` ... 

If this file doesn't exist in your folder, you can create it by opening this menu: `Preferences/Package Settings/Clickable URLs/Settings - User`.

Open the file and add the setting, save it and then make a symlink to it inside `sublime-settings/settings`. 

Test it's functionality now when the browser is set (place the cursor on a url and hit `ctrl+alt+Enter`), if the link doesn't open in your browser, you have not made the correct settings, RTFM.  

But we are not done with this simple package. The default Hotkey for 'Clickable URLs' `ctrl+alt+Enter` overwrites one of Sublimes default keybindings, one that I use from now and then. 

This is another reason I have done this crazy settings system, to locate and fix problems like this easily. And more or less all of the 3rd-party packages overwrite keys in this same fashion.

First let's assign a custom hotkey to open URL's, luckily all user defined hotkeys are put in the same file, so open  
`sublime-settings/keys/user.sublime-keymap`  
and add this:

``` json
{ "keys": ["ctrl+enter"], "command": "open_url_under_cursor" }
```

Now we can open URLs with `ctrl+enter`.  

*I know that `ctrl+enter` (open line) is probably an even more used hotkey for most users but we will soon enable VI-bindings and have same functionality with a single `o`*  

But the default hotkey, `ctrl+alt+Enter`, for Clickable URLs is still active. There are two ways to fix this, none of them are perfectly clean. The first and easiest way is to find the `ctrl+alt+Enter` in the **default** sublime.keymap file, copy it and add it to the **user** sublime.keymap file. Doing so will result in this:

Sublime reads the default settings first and applies `ctrl+alt+Enter` to the open line command. Then it reads the package settings, which will overwrite the hotkey with the command to open urls. Lastly it reads the user settings which enables the default command to the hotkey.  
This way is quite simple to do and works really well in this particular case. But sometimes (most of the times) 3rd-party packages comes with a lot of commands that one might want to disable, then this other way to do it is better suited:  

Comment/remove the unwanted hotkeys from the packages default settings file. But remember, this only works if the package is extracted and you can get problems if you mess up default settings. (in this case it is however more or less safe to uncomment the key).

My recommendation is to always use the second method and in the same fashion we did with the built-in setting files.  

After you have copied and linked the files you should have a file structure similar to this:

``` shell
~ <- Home folder
  .config
    sublime-text-3 <- symbolic link to Dropbox/sublime-text-3
  Dropbox
    sublime-text-3
      Packages
        User
          ClickableUrls.sublime-settings
          Preferences.sublime-settings
          Default (Linux).sublime-keymap
        Clickable URLs
          Default (Linux).sublime-keymap
  tmp
    sublime-settings
      settings
        original
          OG_default.sublime-settings <- copy, Read only
        default
          default.sublime-settings <- soft link
        user.sublime-settings <- soft link
        ClickableUrls.sublime-settings <- soft link, this is where we define the browser
      keys
        original
          OG_default.sublime-keymap <- copy, Read Only
          OG_ClickableUrls.sublime-keymap <- copy, Read Only
        default
          default.sublime-keymap <- soft link
          ClickableUrls.sublime-keymap <- soft link to user-packages/Clickable Urls/Default (Linux).sublime-keymap, this is where the hotkey we want to disable is defined.
        user.sublime-keymap <- soft link, this is where we define the custom hotkey
      docs
        ClickableUrls.md <- copy of ser-packages/Clickable Urls/readme.md
```

As you can see all keymap files have the same file names (`Default (Linux).sublime-keymap`), this makes it really hard to distinguish them and search for them if you don't create links with custom names. Notice that I copied the readme.md and renamed the copy for future reference. And made a read only copy of the original keymap file.  

Now we can just open `sublime-settings/keys/default/ClickableUrls.sublime-keymap` and uncomment the hotkey.

I hope you get why we go to this length to manage the settings. I chose this 'Clickable URLs' packages to illustrate this, since it is such a simple package with only one setting and hotkey definition.  

Below is a list of some really good small packages that I use and can recommend:  

- [iOpener](https://github.com/rosshemsley/iOpener)
- [File Rename](https://github.com/brianlow/FileRename)
- [Zen Tabs](https://github.com/travmik/ZenTabs)

In the [next article](link) in this [series](link) I will show you how to define hotkeys for *hidden* commands.
