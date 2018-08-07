---
title: "sublime_and_git"
banner: "sublime_and_git"
date: 2018-01-03T10:22:44+01:00
author: "budRich"
draft: true
type: "post"
tags: [sublime,blog]
notes:
---

I don't know why I haven't done this earlier, but I just got git and github integration working with sublime on Arch linux.  

I am writing the steps to achieve it here for future reference.  

## 1. Generate and add an ssh key for your github account.  

Before following the guides on github below, i suggest you start the *ssh-agent*, preferably from your startup script (`~/.xinitrc`):  

``` shell
eval "$(ssh-agent -s)"
```

Then follow the guides below:  

https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent  
https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account

## 2. make sure your remote is set to ssh, not https:  

in `*/.git/config` change:  
`https//github.com/username/repository.git` to:  
`git@github.com:username/repository.git`.

To avoid this step in the future also clone projects with the latter URL method.  

## 3. authenticate the ssh-key

execute the following command in a terminal:  
`ssh -T git@github.com` and answer `yes` at the first prompt.

## 4. add dependencies

install **x11-ssh-askpass**, on arch it's available with **pacman** from the official package repositories:  
`sudo pacman -S x11-ssh-askpass`  

## 5. add package to sublime

Currently i am using the `git` that i installed with **package controll** in **sublime text 3**. No further settings where needed after the steps above where completed, and I guess it will make other similar git packages work as well.
