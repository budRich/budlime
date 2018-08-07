---
title: vintage_clipboard_history
banner: vintage_clipboard_history
date: 2018-07-06T13:17:25+02:00
author: budRich
draft: true
type: post
tags: [sublime, vim]
changelog:
  - 2018-07-06 - created
notes:
---

I just made some tweaks to sublime to make it support clipboard history when yanking and cutting with the `Vintage` (*VI-navigation*) package enabled.  

By default you can hit `ctrl+k, ctrl+v` to display a pop-up menu with the clipboard history from the current sublime session. But there is no regular setting to support the *vintage register*. There is a setting that will always add anything yanked or deleted with vintage commands to the normal clipboard (and to the vintage register), and for the rest of this hack to work, that setting needs to set to true:  

`"vintage_use_clipboard": true,`  

I extracted the `Default` package (on my installation, located at: `/opt/sublime_text_3/Packages/Default.sublime-package`), where i found the file: `paste_from_history.py`, and by adding the code below to the `on_post_text_command` function i got my vintage clipboard in to the history:

``` python
if name == 'set_action' and re.search('^vi_(copy|delete).*', args["action"]):
  g_clipboard_history.push_text(sublime.get_clipboard())
```

I figured out which commands and arguments to add by looking in the `vintage` keymap file. But this solution was not perfect. Sometimes it didn't really work, and it added the the previous clipboard instead of the latest (when using `yy`) .

So i found that i needed to populate the clipboard history from the Vintage package instead, i added one line to `set_registers` in `Vintage/Vintage.py` (*around line 850*):  

``` python
if (use_sys_clipboard and register == '"') or (register in ('*', '+')):
    sublime.set_clipboard(text)
    view.run_command('add_to_clipboard')
```

And added the a command to `Default/paste_from_history.py`:  

``` python
class AddToClipboard(sublime_plugin.TextCommand):
    def run(self,arne):
        g_clipboard_history.push_text(sublime.get_clipboard())
```


Lesser autists would probably be more then satisfied here, but there was one more thing that was nagging me. I try to avoid using the arrow keys as much as possible, but i couldn't figure out how to make `tab` a substitute for up-arrow in the pop-up. I have gotten it working in the quick-panel, and the quick panel also looks cooler, so i replaced the popup command with a quickpanel one in the same file as above (`paste_from_history.py`):  

``` python
# provide paste choices
paste_list = g_clipboard_history.get()
keys = [x[0] for x in paste_list]
sublime.active_window().show_quick_panel(keys, lambda choice_index: self.paste_choice(choice_index))
# self.view.show_popup_menu(keys, lambda choice_index: self.paste_choice(choice_index))
```

Below are the relevant keybindings:  

``` json
{ "keys": ["<"], "command": "paste_from_history",
  "context": [{"key": "setting.command_mode"}]
},

{
  "keys": ["tab"],
  "command": "move",
  "args": {"by": "lines", "forward": true},
  "context": [
    { "key": "panel", "operator": false, "operand": "input_panel" },
    { "key": "setting.is_widget" },
  ]
},


{
  "keys": ["shift+tab"],
  "command": "move",
  "args": {"by": "lines", "forward": false},
  "context": [
    { "key": "setting.is_widget" }
  ]
},
```

I replaced the original `ctrl+k, ctrl+v` with `<`. I use a Swedish keyboard but with US layout enabled, so `<` is available both as `shift+,` and next to `z`. I prefer sublimes default indentation (`ctrl+[`), so this will work fine. The `input_panel` context on tab, is a hack to make tab behave as expected with the package `iOpener`...
