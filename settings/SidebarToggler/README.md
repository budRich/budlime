This is just two custom keybindings that uses [Chain of Command] to combine different commands for a good sidebar toggling effect.

If the sidebar is not visible it will be so (`toggle_side_bar`), and the currently open file will get selected (`reveal_in_side_bar`) and finally the side bar will get focus (`focus_side_bar`).

If the sidebar is active (`"context": [ {"key": "control", "operator": "equal", "operand": "sidebar_tree"} ]`) the side bar is hidden and the main window focused (`["focus_group", { "group": 0 }]`).

I have bound the chains to the combination:  
`["ctrl+alt+s"]` , i have other UI togglers set to similar keybindings in `Packages/zublime/Default (Linux).sublime-keymap`:  

```json
{ "keys": ["ctrl+alt+m"], "command": "toggle_menu" },
{ "keys": ["ctrl+alt+b"], "command": "toggle_tabs" },
{ "keys": ["ctrl+alt+i"], "command": "toggle_minimap" },
```

[Chain of Command]: https://github.com/jisaacks/ChainOfCommand
