These are all my [Sublime Text] dotfiles. [Sublime Text], have a very strange way to apply settings...  

A package (another word for *extension*, *add-on* or *plugin*), can [exist in different *forms*](https://packagecontrol.io/docs/customizing_packages), sometimes at the same time and many interesting files, have the exact same name, and are sometimes hidden inside packed packages...  

## cooked by bud

most of the files here, are settings for 3rd party packages, but a few are brews i have put together myself:  

| package | description |
|:--------|:------------|
[CommandCommander] | by adding this package, command_mode will get enabled in all files when they lose focus.
[DisableArrowkeys] | Makes the arrowkeys useless and the tab key better.
[mondo] | custom colorschemes, generated with [mondo][mondo-generator]
[SidebarToggler] | A more efficient toggling function for the sidebar
[TwoFont] | toggle between different font settings
[VintageFinder] | Better behaviour of the **find_panel** optimized for [Vintage]
[VintageSanity] | Fixes for some key combinations that breaks when [Vintage] is enabled

[CommandCommander]: 

## [subextract]

All the settings in this directory is applied and synced with my script [subextract]. I created [subextract] to limit the confusion the default settings system causes.

## install packages

By populating the list *"installed_packages"* in: 
[SUBLIME_DIR/Packages/User/Package Control.sublime-preferences](https://github.com/budlabs/budlime/blob/master/packages/Package%20Control/Package%20Control.sublime-settings), **Package Control** will install any missing packages when sublime starts.

[Sublime Text]: https://www.sublimetext.com/
[subextract]: https://github.com/budlabs/budlime/tree/master/scripts/subextract
