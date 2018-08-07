---
title: "sublime_setup_fixing_vintage"
date: 2017-10-23T22:11:02+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime","vi","vim","vintage"]
notes:
---
This is a continuation of the [last article](link) about what breaks with Vi-ctrl-bindings enabled and how to fix it.  

To keep full sublime functionality and have Vi-ctrl-bindings enabled, we need to re-assign these commands:

|**Key**|**Sublime Command**|
|:-------|:--------------|
|`ctrl+b`|build|
|`ctrl+r`|Goto symbol|
|`ctrl+e`|slurp_find_string|
|`ctrl+d`|find_under_expand|

All four are very powerful, and popular sublime commands.  

*I might change these re-assignments. Much of the functionality we get in command mode duplicates default sublime commands, and those keys are now up for grabs.*  

build
-----
To be honest I never use sublimes build function, when I have to build something i use the terminal. But i guess many people use this. When I look in the default `sublime.sublime-keymap` file, I see that the same command is also mapped to `F7`, an alternative could be `ctrl+shift+b`. I leave it to the builders.

Goto symbol
-----------
This is a command I use myself a lot. It opens a list of 'symbols'. A symbol is different things in different files. In bash scripts, function definitions are symbols. In markdown headers are symbol. This makes file navigation super smooth, and this is one of Sublimes flagship commands, and is even displayed on their [homepage](http://sublimetext.com).

My solution might sound stranger and more complicated then it really is, but here goes:

Remember the different modes in Vintage/Vi/Vim. One of these are called 'last line mode' and is enabled by hitting `:` in command mode. This mode is extremely powerful in Vim. In Vintage the only unique commands in 'last line mode' are `revert` and `save`. These commands are also available through hotkeys, and the mode is completely useless imo.  

But 'last line mode' also gives us access many sublime commands, but not as many as the `command palette`. So I'm changing `:` to launch the `command palette` and give `ctrl+shift+p` to the 'Goto symbol' command.  

slurp find string
-----------------
I didn't know about this command till I started researching for this article. But it is very useful. It puts the word under the cursor in the find field of the find panel, but without opening the panel or do any searching. Good bye, copy pasting stuff into that field!  

The replacement for this will however be quite complicated. But I'm going to use the `F3` where find related commands (find next/prev/..) are found by default for slurping.

Find-next/prev can be achieved with `n`/`N` in command mode. But I feel i need to modify the behavior of the find command a bit for this to be smooth. I will dedicate a article just for this later in this series.

find under expand
-----------------
Last but **not** least we have this command. Some people might have this command and it's hotkey synonymous with Sublime Text. If you don't know what it does, try it!(hit it multiple times, when you have some selections, edit the text). This is also showcased on Sublime Texts [front page](http://sublimetext.com).  

I don't have a good answer for the best hotkey replacement here. I have it on `ctrl+.` for the moment..  

It will become to much text and code to show all the necessary changes needed on this homepage. Instead I suggest you look at my personal config files that are located in `dots/sublime` in the sidebar.  

Ahh, I almost forgot ;), to enable Vi-ctrl-bindings, set this setting to true:  
`"vintage_ctrl_keys": true,`.  

I also just realized that one important change i have made from default Vintage is to enable the vi-ctrl-keys globally. Otherwise they only work in *command mode* and that drove me crazy.  

To enable them globally one have to change,  

**This:**  

``` JSON
{ "keys": ["ctrl+y"], "command": "scroll_lines", "args": {"amount": 1.0 },
	"context": [{"key": "setting.command_mode"}, {"key": "setting.vintage_ctrl_keys"}]
},
```

**To this:**

``` JSON
{ "keys": ["ctrl+y"], "command": "scroll_lines", "args": {"amount": 1.0 },
	"context": [{ "key": "setting.vintage_ctrl_keys"}] },
```
For all hotkeys that have `setting.vintage_ctrl_keys`
