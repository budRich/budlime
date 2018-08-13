This is a custom keymap, that will improve the behavior of the way the find & replace panel is toggled.  

When `VintageFinder` is enabled the panel will always be shown with both find and replace fields visible. If the panel isn't visible when the keybinding is invoked (`/` or `?` in command mode.) a *slurp* of the word under the cursor will get performed and that word will populate the search field. If the panel is visible but not focused, the search field will just get focus.  

When a search is performed, the main window will get focus, but the panel will stay visible. Press `Escape` to hide the panel.
