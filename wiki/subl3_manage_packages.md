---
title: "sublime_setup_manage_packages"
date: 2017-10-23T10:57:08+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime"]
notes:
---
Sublime have a package-system to extend the functionality of the editor. It ships with a whole bunch of packages pre-installed, these packages are maintained by the Sublime developers.

But you can also install 3rd-party packages. The sourcecode for the packages is open and if you know how you can edit them, even the built-in ones.

The package manager for Sublime is called `Package Control`, it is not installed by default, let's do that first.

In sublime, hit the hotkey combination:  
`ctrl+shift+p`  
This opens the `Command Palette`, which is a list of almost all available commands in sublime. Search for the command `Install Package Control` and select it by hitting `Enter`. It will install in a couple of seconds and you will a window with information on how to use it will pop up.

Locating packages
-----------------

Packages can exist in three places, and it is good to know the differences between them. We have actually already viewed and used one package: 
`sublime-text-3/Packages/User` 
This folder, User, is a package. During your time with Sublime the folder `sublime-text-3/Packages` will be populated with more folders. Lets call these folders `user-packages` from now on.

Open the folder `sublime-text-3/Installed Packages` . If you installed Package Control, you should see a file called `Package Control.sublime-package` in this folder, maybe more files with the same extension. Package Control is a package in itself, and most installed packages goes to this folder as archives. They are actually normal `zip` files and one could extract them to view the source. I will refer to archived packages in this folder as: `installed-packages`.

The last location for packages is where the built-in packages are stored. You can find them in:  
`/opt/sublime_text/Packages`
These are archived and named just as the `installed-packages`. I will refer to these packages as `built-in-packages`. The `built-in-package` containing the default setting files is called:  
`Default.sublime-package`

package locations:

``` shell
/ <- root folder
  opt
    sublime_text
      Packages <- built-in packages
  home
    USER <- your home folder
      .config
        sublime-text-3 <- link to Dropbox
      Dropbox
        sublime-text-3
          Packages <- user packages
          Installed Packages <- installed packages
```

--------

As I mentioned above, `.sublime-package` files are normal `zip` files and can be extracted with your default archiving application. But I strongly recommend you don't do that, there is a much safer and convenient way that I will describe in the [next article](link) in this [series](link).

