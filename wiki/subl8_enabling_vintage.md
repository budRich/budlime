---
title: "sublime_setup_enabling_vintage"
date: 2017-10-23T18:02:52+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime","vim","vi","vintage"]
notes:
---
Vintage is a package that ships with Sublime, so one doesn't need to download it or use `Package Control` to enable it. Vintage adds the same navigation as found in the, 40 year old (!!!), editor `VI`, often referred to as Vi/Vim-bindings/navigation.  

Vim-bindings is a very powerful, different and advanced way to navigate and edit text. I will not go into any details how to use Vi-bindings, but you can find lots of good articles and reasons to use it on the web.

The best way to get familiar with VI-bindings is to install `vim` (`sudo apt install vim`) and then run `vimtutor` . This will start an interactive tutorial, do this tutorial, it's not long and you will have a very good idea of what the fuzz is about.

---

enable the vintage package
--------------------------
Open `user.sublime-settings` and remove `"Vintage"` from ignored packages. (You can also enable packages with `Package Control` from the `command palette`.)

Press `Escape` to enter 'command mode'.

vintage modes
-------------
There are three different modes available when `Vintage` is enabled, you can see which mode you are in in the bottom-left corner of the statusbar:  

**command mode**: This might be referred to as vintage mode but it is not correct. This is the mode where you navigate or enter commands. To enter **command mode** press `Escape`

**insert mode**: This might be referred to as sublime/normal mode, and it is not too far off. The default behavior of insert mode when `vintage` is enabled is exactly as normal Sublime. There are many ways to enter **insert mode**, one is to press `i` when in **command mode**.  

**visual mode**: Think of this mode as 'selection mode'. **visual mode** is entered when text is selected while in **command mode** or by pressing `v`.  

**replace mode**: this mode is not supported with `Vintage` . **replace mode** is entered by pressing a capital `R` while in **command mode** in Vim.  

**last line mode**: this mode is more or less not supported in `Vintage`. **last line mode** is entered by pressing `:` while in **command mode** in Vim or VI.

---

When using `Vintage` you should consider **command mode** as the normal/default mode. However sublime always starts in **insert mode**. To change this behavior add this to your settings:  
`"vintage_start_in_command_mode": true`  

---

`Vintage` makes, as you can see, a lot of breaking changes to the defaults of Sublime. To make the most of it, we should examine the vintage package. That's what the [next article](link) in this [series](link) will be about.

