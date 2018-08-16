This [Sublime Text](http://sublimetext.com) package makes it possible to toggle between two different fonts with the same hotkey. It is also possible to set a absolute font. It changes all elements of the fonts defined in the [settings file](https://github.com/budRich/budlime/tree/master/config/TwoFont). 

![twofontgif](https://budrich.github.io/img/org/twofont.gif)

`TwoFont.sublime-settings`  
The keys `font1` and `font2` is mandatory.
``` json
{
    "font1": {
      "font_face": "Hack",
      "font_size": 18,
      "font_options": ["no_bold", "no_italic", "subpixel_antialias"]
    },

    "font2": {
        "font_face": "Fixedsys Excelsior 3.01-L2 Mono",
        "font_size": 12,
        "font_options": ["no_bold", "no_italic", "no_antialias"]
    },

    "monaco": {
      "font_face": "Monaco",
      "font_size": 14,
      "font_options": ["no_bold", "no_italic", "subpixel_antialias"]
    },

    "Inconsolata": {
        "font_face": "Inconsolata",
        "font_size": 20,
        "font_options": ["no_bold", "no_italic", "subpixel_antialias"]
    }
}
```

`user.sublime-keymap`  
If no argument is passed to the command `two_font` it will toggle between the settings of `font1` and `font2` . Otherwise the font matching the argument will be set.
``` json
{
  { "keys": ["ctrl+1"], "command": "two_font" },

  { "keys": ["ctrl+2"], "command": "two_font", 
    "args": {"font": "Inconsolata"}
  },
}
```


