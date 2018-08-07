A even better way to have easy access to 'Escape' is to install `xcape` (`sudo apt install xcape`) and add this to your `~/.profile`:

``` shell
setxkbmap -option caps:ctrl_modifier  
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
```

Now your control keys acts as `Escape` if they are pressed 'alone' and as a bonus your stupid CapsLock key is also a control key!