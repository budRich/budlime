<https://github.com/Monnoroch/ColorHighlighter>  

This package adds embeded highlighting of colors anywhere in the source code.  

There are three different methods by which the color can be displayed:  
- inline
- gutter
- block  

gutter will show either a square or a circle (can be defined with settings) icon in the gutter. Block will show a block with the color next to each occurrence of a color in the code. Inline will modify the current colorscheme to have the colordefinition itself change color.  

Even though inline highlighting looks good, the fact that it modifies the current colorscheme can cause some problems, especially when different colorschemes are used.  

SO i recommend, making all settings look something like this:   

``` js
"color_highlighters": {
  "color_scheme": {
      "enabled": false,
  },
},
```

*the settings can also be changed from the menu bar (Tools->color highlighter)*



