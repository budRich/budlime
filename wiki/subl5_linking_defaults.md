---
title: "sublime_setup_linking_defaults"
date: 2017-10-23T12:26:53+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime"]
notes:
---
We finally have access to the default setting files, but to make sure we don't break stuff I recommend you follow these steps:

Remember that folder we created and stored soft links to our user settings in? Open that. (in the [article](link) I created it in `~/tmp/sublime-settings`).  

Remember that the files in an extracted package is not read-only as their original archived versions. There are pro's and con's to this.. The advantage is obviously that we can edit them, and this is very good. Because otherwise it is really annoying to manually disable features we don't want from a package. The disadvantage is ofc that we might mess something up with the default functionality when we are editing the files. That is why I like to make copies of the original files before anything else. I found this way to be the best:

Inside both the `conf` and the `keys` folder create two folders called `default` and `original`. And now *copy* the file:  
`sublime-text-3/Packages/Default/Default (Linux).sublime-keymap`
to
`sublime-settings/keys/original/OG_default.sublime-keymap`

Then make a *soft link* of the same file to:  
`sublime-settings/keys/default/default.sublime-keymap`

Do the same with the file:  
`sublime-text-3/Packages/Default/Preferences.sublime-settings`  

*It is a good idea to change permissions of the OG_files to make sure they are ReadOnly. One way to achieve this is to run the following command on the files:* `chmod -w OG_FILE_NAME`

When you are done you should have a folder structure similar to this:  

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
        Default
          Default (Linux).sublime-keymap
          Preferences.sublime-settings
  tmp
    sublime-settings
      settings
        original
          OG_default.sublime-settings <- copy, Read only
        default
          default.sublime-settings <- soft link
        user.sublime-settings <- soft link
      keys
        original
          OG_default.sublime-keymap <- copy, Read Only
        default
          default.sublime-keymap <- soft link
        user.sublime-keymap <- soft link

```

Now you can open sublime and add the `sublime-settings` folder to your project. Then use the excellent built-in command `goto files`(`ctrl+p`). This will open a list of all files in your folder and you now have a very neat way to access your settings. The 'drawback' being that this folder needs to be in your project.

This might look like overdoing something simple as organizing the setting files for a program. But you will see later in this series that it is more or less necessary to do something like this when you install more and more advanced packages.

In the [next article](link) in this [series](link) I will install a simple but useful 3rd-party-package and make some changes to it's settings. And show you how to extract single packages instead of the whole bunch.
