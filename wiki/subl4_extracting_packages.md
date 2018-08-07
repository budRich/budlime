---
title: "sublime_setup_extracting_packages"
date: 2017-10-23T11:38:03+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime"]
notes:
---
Before extracting packages I strongly recommend you do the following preparations:

1. Add package folders to project
---------------------------------
Open sublime and choose `Add Folder To Project...` from the Project menu (or the `command palette`(`ctr+shift+p`)). Add these two folders to your project:  
`sublime-text-3/Packages`  
`sublime-text-3/Installed Packages`

They should now be visible in the sublime sidebar. *you can toggle the sidebar with:* `ctrl+k+ctrl+b`

2. Install Extract Sublime Package
----------------------------------
Open the `command palette`(`ctr+shift+p`) and choose `Package Control: Install Package`. This will open a list of all available 3rd-party packages you can install. Search for `Extract Sublime Package` and select it to install it.

It will install in no time, you can see the progress in the statusbar at the bottom-left corner of the screen.

3. Extract all packages
-----------------------
When it is installed open the `command palette` again search for `Extract Sublime Package: Extract all packages` and select it. You will now be asked if you want to extract all packages, you want that. It will take a while (probably 10 seconds) and then you will get a warning from Package Control.

If you view the package folder in the sidebar, you can see that all installed and built-in packages are extracted to this folder.

No you should exit sublime (`ctrl+q`).

Package Hierarchy
=================
Packages has different priority depending on where they are located.

Extracted `user-packages` has the highest priority. And archived `built-in-packages` have the lowest priority.

This means that if a package is extracted to `sublime-text-3/Packages` the archived version(s) will be ignored.

The most important difference between an archived and extracted package is that the files inside an archive is read-only, the only ways to make changes to a file inside an archived package is to have a file with same name inside `sublime-text-3/Packages/User`. That file will be read instead of the one in the package. Or we could do as we just did, and extract the whole package to `sublime-text-3/Packages`.

Most of the `built-in` packages are best kept in their archived form and it is safe to remove the extracted packages we don't 'need'. And the warning we got from Package Control told us that we have to remove the extracted version of Package Control otherwise it will not work properly. 

So delete all folders inside `sublime-text-3/Packages` except these:  

`sublime-text-3/Packages/User`  
`sublime-text-3/Packages/Default`  
`sublime-text-3/Packages/Extract Sublime Packages`  

*It's a good idea to make a backup of the `sublime-text-3` folder before you delete the extracted packages folders.*  

*There might be folders that you don't want to delete if you are not following this guide with a fresh install, but all extracted packages that exist as a built in or installed archive, should be safe to remove.*

In the [next article](link) in this [series](link) i will describe the final step to get a better alternative to the default way of viewing and editing the settings.
