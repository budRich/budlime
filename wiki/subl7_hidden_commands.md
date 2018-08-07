---
title: "sublime_setup_hidden_commands"
date: 2017-10-23T17:06:10+02:00
author: "budRich"
draft: true
type: "post"
target: "budlime/articles"
tags: ["sublime"]
notes:
---
In this article I will describe how to find and use *hidden* commands.

I think it's obvious for most of you how to create custom hotkeys, you copy one from the default and paste it in the user settings file and change the key combination.

But there are some commands/actions that are not present in the `default.sublime-keymap` file. But there are ways to find them.

One way is to look in the files in the extracted packages. Open the folder `user-packages/Default` inside this folder you can see a file called:  
`Default.sublime-commands`  
Open this file. I think these are the commands available in the `command palette` by default. Some of these commands are not present in the `default.sublime-keymap` file for instance: 

``` json 
{ "caption": "View: Toggle Menu", "command": "toggle_menu" },
```

To add this command to a hotkey you could add this to `sublime-settings/keys/user.sublime-keymap` :

``` json
{ "keys": ["ctrl+alt+m"], "command": "toggle_menu" },
```

There is another really cool way to find these kind of commands by using the `sublime console`. Open the console from the menu: `View/Show Console`.

In the console, enter this command:  
`sublime.log_commands(True)`

Now all commands you do will be printed to the console! Open the `command palette` and choose `View: Toggle Menu` (notice that the newly added hotkey is printed in the command palette next to the command!).

In the prompt you should see this line:
`command: toggle_menu`  

And I think you understand how to translate it into a hotkey.  

Its not a bad idea to create a file in `sublime-settings/docs` name it `hacks.md` or something, and make a small note with this prompt command for future reference.

In the [next article](link) in [this series](link) we will enable `Vintage` and add the power of 'VI' to sublime!
