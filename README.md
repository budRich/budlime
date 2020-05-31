# budlime - [Sublime Text] related settings, scripts and links.
curated by [budRich] since 2018  

In this repo i will collect things that have helped me to achieve a good developing environment in [Sublime Text].  

## [awesome]

Contains a single readme with sublime related finds: recommended packages, tools, links, videos, and such.

## [wiki]

Short articles about sublime that I have written.

## [packages]

Contains of *package overrides*. Settings, keymaps, and some small custom packages.

I use the official [Vintage] package to get some of the goodies from [VIM] in sublime, and many of the other package specific settings I have done reflect this.  

I try to change all keybindings involving the arrowkeys to something more *VIM-like*, and use <kbd>,</kbd> as **leader** in **command_mode** instead of the annoying <kbd>Ctrl</kbd><kbd>k</kbd> key combinations.

These are not all of my preferred packages, I want this collection to be *language agnostic* so there are more or less no language specific packages included here.

This repo can also be seen as a template for how you can create your own *package profile* and sync it with subextract.

## [scripts]  

Some sublime related custom scripts I have created.  

| script       | description
|:-------------|:---------------------------
| [install]    | Use this script to apply and install all the packages and settings in the **packages** directory of this repo.
| [sublget]    | prints information about open sublime windows, by analyzing the window title.
| [subextract] | extract readme files, blank default settings and apply and sync custom settings. (this script is used by the install script)
| [sublaunch]  | Open a sublime window, with a specific project, file and instance name.          |
| [sublsess]  | Removes unwanted windows from the Session.sublime_session file, useful only if one has issues with multiple unwanted windows are created when the sublime session starts.          |

## updates

### 2020.05.31
added sublsess script

### 2019.02.01

**scripts removed**:  
- subdox , external dependencies, might get added back in the future.
- browserpreview, removed since i removed the markdown preview package

**packages removed**:  
- Alignment, good package, but a bit too big and i found myself never using it.
- DA UI, maintainer have removed package. replaced by my own package Mondo (that is much less bloated)
- Extract Sublime Package, replaced by PackageResourceViewer
- FastOpen, this package i made myself, and i think it is too specific to my own workflow to keep it public.
- GitGutter, latest releases of sublime have native git info in gutter
- MarkdownPreview, syntax specific, never used it myself.
- PlainNotes, using both PlainNotes and PlainTasks at the same time felt like overkill
- SublimeLinter, syntax specific, external dependencies
- Table Editor, syntax specific, and i never used it
- TwoFont, my own package, will give this some love and release it as a proper package for Package Control instead.
- Zeal, external dependencies

**packages added**:  
- BetterFindBuffer, very good enhancement to the *Find In Files* function.
- Mondo, now includes UI theme and different color schemes.
- EndWithSemi, small package i made with macros instead of python.
- PackageResourceViewer, much better alternative to `Extract Sublime Package`
- ReadMePlease, this is a better solution to read package documentation, then the one i used prior (extract the readmes and store them in the user directory)

**script changes**  
- renamed tits -> sublget
- all scripts now use the [bashbud] framework
- rewrote the install script and subextract to be faster and better.

[GTFM]: https://github.com/budlabs/GTFM
[install]: https://github.com/budlabs/budlime/tree/master/install
[VIM]: https://www.vim.org/
[Vintage]: http://www.sublimetext.com/docs/3/vintage.html
[Sublime Text]: https://www.sublimetext.com/
[subextract]: https://github.com/budlabs/budlime/tree/master/src/subextract
[sublget]: https://github.com/budlabs/budlime/tree/master/src/sublget
[install]: https://github.com/budlabs/budlime/tree/master/src/install
[sublaunch]: https://github.com/budlabs/budlime/tree/master/src/sublaunch
[sublaunch]: https://github.com/budlabs/budlime/tree/master/src/sublsess
[awesome]: https://github.com/budlabs/budlime/tree/master/awesome
[wiki]: https://github.com/budlabs/budlime/tree/master/wiki
[packages]: https://github.com/budlabs/budlime/tree/master/packages
[scripts]: https://github.com/budlabs/budlime/tree/master/scripts
[budRich]: https://budrich.github.io/

