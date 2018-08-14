<https://github.com/SublimeText/MoveTab>  

This package add a command to move tabs. I want to have the same keybinding as i have in [cVim] for this function, so i have changed the defaults to this:  

``` JSON
{
  "keys": ["Q"],
  "command": "move_tab",
  "args": { "position": "-1" },
  "context": [{"key": "setting.command_mode"}]
},
{
  "keys": ["W"],
  "command": "move_tab",
  "args": { "position": "+1" },
  "context": [{"key": "setting.command_mode"}]
}
```

This will move tabs with `Shift+q/w` while in vintage command_mode.  


