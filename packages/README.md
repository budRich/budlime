[Sublime Text], have a very strange way to apply settings...  

A package (another word for *extension*, *add-on* or *plugin*), can [exist in different *forms*](https://packagecontrol.io/docs/customizing_packages), sometimes at the same time and many interesting files, have the exact same name, and are sometimes hidden inside packed packages...  

## [subextract]

All the settings in this directory can be applied and synced with my script [subextract]. I created [subextract] to limit the confusion the default settings system causes.

## install packages

By populating the list *"installed_packages"* in: 
[SUBLIME_DIR/Packages/User/Package Control.sublime-preferences](https://github.com/budlabs/budlime/blob/master/packages/Package%20Control/Package%20Control.sublime-settings), **Package Control** will install any missing packages when sublime starts.

## cooked by bud

most of the files here, are settings for 3rd party packages, but a few are brews i have put together myself:  

| package | description |
|:--------|:------------|
[CommandCommander] | by adding this package, command_mode will get enabled in all files when they lose focus.
[DisableArrowkeys] | Makes the arrowkeys useless and the tab key better.
[Mondo] | custom colorschemes, generated with [mondo-generator]
[SidebarToggler] | A more efficient toggling function for the sidebar
[VintageFinder] | Better behaviour of the **find_panel** optimized for [Vintage]
[VintageSanity] | Fixes for some key combinations that breaks when [Vintage] is enabled
[EndWithSemi] | A simple "package" that uses a custom sublime-macro to add the ability to append the line with a semicolon.


[Sublime Text]: https://www.sublimetext.com/
[subextract]: https://github.com/budlabs/budlime/tree/master/src/subextract
[CommandCommander]: https://github.com/budlabs/budlime/tree/master/packages/CommandCommander
[DisableArrowkeys]: https://github.com/budlabs/budlime/tree/master/packages/DisableArrowkeys
[Mondo]: https://github.com/budlabs/budlime/tree/master/packages/mondo
[SidebarToggler]: https://github.com/budlabs/budlime/tree/master/packages/SidebarToggler
[EndWithSemi]: https://github.com/budlabs/budlime/tree/master/packages/EndWithSemi
[VintageFinder]: https://github.com/budlabs/budlime/tree/master/packages/VintageFinder
[VintageSanity]: https://github.com/budlabs/budlime/tree/master/packages/VintageSanity
[mondo-generator]: https://github.com/budlabs/Mondo
[Vintage]: http://www.sublimetext.com/docs/3/vintage.html
