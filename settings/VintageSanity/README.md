This keymap aims to fix some of the clashes in 
commands that happens when [Vintage] is enabled.

It also adds some bonus features, such as 
VI-navigation in the sidebar, and VI versions of
the `ctrl+shift+DIRECTION` and `alt+shift+DIRECTION` commands.

all the ctrl+* commands enabled with: 
`setting.vintage_ctrl_keys` 
are set to only work in **command_mode** by default. I found this extremely annoying, so I removed:  
`{"key": "setting.command_mode"}`  
from the context to make the keys global.

[Vintage]: http://www.sublimetext.com/docs/3/vintage.html
