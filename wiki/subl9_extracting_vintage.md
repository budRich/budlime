---
title: "sublime_setup_extracting_vintage"
date: 2017-10-23T18:59:37+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime","vim","vi","vintage"]
notes:
---
The `Vintage` package is adds a lot of functionality and extra commands. To fully understand `Vintage` and make the most of it we need to extract the package.

locating the vintage package
----------------------------
since `Vintage` is a package that ships with Sublime it resides in the same location as the `Default` package. `/opt/sublime_text/Packages/Vintage.sublime-package`.  

Open this file in sublime and accept the generous offer to extract the package. First thing to do is, as always, to look at the `README.TXT` file. I think I covered most of what the readme have to say in my [last article](link). 

Next up you can open `Preferences.sublime-settings` . There are only three available settings and they can all be applied to `user.sublime-settings`. So it's not really necessary to link this file to `sublime-settings`, instead copy the settings to your `user.sublime-settings` file, even if you don't plan to change them. The comments in the file describe the purpose of the settings good enough. But one of the settings will break a lot of things if we don't make some extensive customization to the keymap files.

Lets start by making links and copies to the keymap file in our `sublime-settings` folder.

``` shell
/ <- root folder
  opt
    sublime_text
      Packages
        Vintage.sublime-package <- archived package
  ~ <- Home folder
    .config
      sublime-text-3 <- symbolic link of Dropbox/sublime-text-3
    Dropbox
      sublime-text-3
        Packages
          User
          Vintage <- extracted package
            README.TXT
            Preferences.sublime-settings
            Default.sublime-keymap
    tmp
      sublime-settings
        settings
          user.sublime-settings <- soft link, append the contents from Vintage/Default.sublime-settings here.
        keys
          original
            OG_vintage.sublime-keymap <- copy of Vintage/Default.sublime-keymap
          default
            vintage.sublime-keymap <- soft link of Vintage/Default.sublime-keymap
          user.sublime-keymap <- soft link
```

In the [next article](link) in this [series](link) we take a closer look on the Vintage settings and how they affect Sublime.
