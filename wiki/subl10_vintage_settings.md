---
title: "sublime_setup_vintage_settings"
date: 2017-10-23T20:12:38+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime","vim","vi","vintage"]
notes:
---
Just by enabling vintage, most of the VI-bindings works immediately. You can enter the different modes and use VI-navigation in command mode. But there are many core VI-bindings that aren't enabled by default. This is because they use the `Control` key as a modifier and overwrite lots of classic Sublime hotkeys.

To VI or not to VI?
-------------------
We now have to make a hard decision. We can choose not to enable the VI-bindings that use ctrl keys. By doing so we will loose a lot of the good stuff from VI but retain the classic sublime hotkeys that we have learned and learned to love. 

Or enabling them and have a much more true VI-experience and by embracing them we will be very efficient if we ever have to use VI or Vim or one of the [many other programs](link to vim apps) that uses VI-navigation.

I think you know which option i recommend. But if you are a hardcore long-time user of sublime and have all of it's hotkeys in the muscle memory, I understand if you chose the first option.

I am a hardcore long-time user of sublime, myself, but I think it's a no-brainer that the second option is the way to go. For these two reasons:

1. Sublime will behave like all other programs I use with VI-bindings (this was the reason i enabled Vintage in the first place.)

2. It is not a big thing to create new custom commands for the ones we lose when enabling VI-ctrl-bindings.

What breaks exactly?
--------------------
Here is a more or less complete table of what will happen if we enable VI-ctrl-bindings:

|**Key**|**Vintage Command**|**Sublime Command**|
|:-------|:--------------|:--------------|
|`ctrl+y`|Scroll 1 line down|redo_or_repeat|
|`ctrl+e`|Scroll 1 line up|slurp_find_string|
|`ctrl+f`|Page down|find in file|
|`ctrl+b`|Page up|build|
|`ctrl+u`|Half page up|soft_undo|
|`ctrl+d`|Half page down|find_under_expand|
|`ctrl+r`|redo_or_repeat|Goto symbol|
|`ctrl+w`|window manipulation|close tab|
|`ctrl+[`|escape|unindent|

Some of the overwritten commands are found from the command mode VI-bindings. These doesn't need to change imo. These are:

|**Key**|**Sublime Command**|**Replacement**|
|:-------|:--------------|:--------------|
|`ctrl+y`|redo_or_repeat|`ctrl+r`|
|`ctrl+f`|find in file|`/` in command mode|
|`ctrl+u`|soft_undo|`u` in command mode|

`ctrl+[` is only an alternative to using `escape` key. And this can safely be disabled, and we can retain the default unindent functionality. I will show you an even better alternative escape in a later article.  

`ctrl+w` is a modifier in VIM to modify the window, in vintage it defaults to splitting the window in different ways. I have chosen to use `ctrl+w+ctrl+w` to the close tab command. However this isn't perfect, since the same combination in Vim is used to cycle windows.. This is vintage functionality that i can live without and the easiest thing would be to disable it. I will dedicate a whole article to window manipulation in sublime later.  

This leaves us with four commands that needs re-assignment. And the solution to this is what the [next article](link) in this [series](link) will be about.
