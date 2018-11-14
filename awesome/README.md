# Articles
article | author | date | description
:-------|:-------|:-----|:-----------
[Creating a custom sublime text colour scheme](https://www.chenhuijing.com/blog/creating-a-custom-sublime-text-colour-scheme/) | [Chen Hui Jing](https://www.chenhuijing.com) | 09 Aug 2018 | write up on the process to create a color scheme from scratch.
[My Sublime Text Configuration](https://spifftastic.net/post/2014/05/my-sublime-text-configuration/) | [Noel Cower](https://spifftastic.net) | 14 May 2014 | run down of a users configuration that doesn't use Package Control
https://www.macstories.net/roundups/sublime-text-2-and-markdown-tips-tricks-and-links/
https://scotch.io/bar-talk/the-complete-visual-guide-to-sublime-text-3-themes-color-schemes-and-cool-features
https://fosstack.com/setup-sublime-python/
https://hackernoon.com/super-charge-your-sublime-text-3-to-increase-your-productivity-5d02c2c1b356
[vim and sublime](https://gist.github.com/skube/90234f30cf3c17957040) by skube
https://github.com/gerardroche/sublime-sensible

# Screencasts
| cast | description | episodes/duration | year |
|:-----|:------------|:---------|:-----|
|[What you need to know]|from budlabs, short intro to the strangeness that is sublime. | 27:22 | 2018
|[laracst]| Great series about setting up sublime in particular for devloping PHP with laravel. But lots of useful tips for general usage as well. | 11 | 2017
https://www.youtube.com/watch?v=Sxkrp9iTgZ8&list=PLIM28v8sWGUcz6LKXlxTn0m1OFCKarKM-
https://www.youtube.com/playlist?list=PLLnpHn493BHEYF4EX3sAhVG2rTqCvLnsP | levelUpTuts
[Sublime Package Development] | in depth tutorial series on how to create packages for Sublime | 5 | 2018
[Sublime Text 2](https://www.youtube.com/watch?v=5AV9zJH2n_Y&list=PLmJpVU-TdmVtTLooKvX3jcrOziPjlWrD4) | 33 videos
[What you need to know]: https://youtu.be/uJrQkzAncZ0
[laracst]: https://laracasts.com/series/professional-php-workflow-in-sublime-text/

# External Tools
tool | description
:--- |:-----------
[tmtheme-editor](https://tmtheme-editor.herokuapp.com/#!/editor/theme/Monokai) | A web app that makes it easy to create color schemes.  
[SublimeSyntaxConvertor](https://github.com/aziz/SublimeSyntaxConvertor) | Converts tmLanguage to sublime-syntax
   

# Recommended packages

package             | author         
:------------------ |:-------------- 
[ApplySyntax]       | [facelessuser] |
Sublime applies syntax to files by looking at the file extension. With `ApplySyntax` one can make more fine grained rules for how the settings are applied. It is very useful for files that have no apparent way to determine the syntax. F.i. configuration files, which often have a syntax that only exist for that particular configfile (f.i. `i3wm`). ApplySyntax` can set the syntax based on things like the content (looking for a specific line), or by evaluating the first line that often contains of a *shebang* that tells what syntax to use.
[Color Highlighter] | [Monnoroch]    |
underlays selected hexadecimal colorcodes (like "#FFFFFF", "rgb(255,255,255)", "white", etc.) with their real color.
[SimpleSyntax]      | [budlabs]      |
A Sublime Text 3 package that adds a simple syntax highlighting, perfect for config files.
[A File Icon]       | [ihodev]       |
This package adds file icons to the sidebar. The author, ihodev, has created several cool UI related packages, such as `DA UI` and `DA CS`.
[Chain of Command]  | [jisaacks]     |
Sublime text plugin to run a chain of commands
[DA UI]             | [ihodev]       |
Adaptive, Customizable, Elegant UI Theme and Color Schemes for Sublime Text 3
[iOpener]           | [rosshemsley]  |
Open files from path, with completion, listings and history. Similar to Emacs find file.
[PackageDev]        | [SublimeText]  |
Tools to ease the creation of snippets, syntax definitions, etc. for Sublime Text.
[PlainNotes]        | [aziz]         |
Simple and pleasant note taking for SublimeText
[BetterFindBuffer] | [aziz] | -
[PlainTasks] | [aziz] | -
[ProjectManager]    | [randy3k]      |
Project Manager for Sublime Text 3
[SublimeLinter]     | [SublimeLinter] |
The code linting framework for Sublime Text 3
[Zen Tabs]          | [travmik]      |
he ultimate plugin for Sublime Text 2/3 to keep your tabs in Zen
[MoveTab]           | [SublimeText]  |
Plugin for Sublime Text to move tabs around
[ExpandRegion]      | [aronwoost]    |
Like “Expand Selection to Scope”. But better!
[Extract Sublime Package] | [SublimeText] |
Extract .sublime-package files to the Sublime Text Packages folder.
[GitStatusBar] | [randy3k] | A more compact git status bar
[quick file move] | [wulftone] | -
[DeleteCurrentFile] | [yaworsw] | -
[ReadmePlease] | [roadhump] | -
[swap boolean polarity] | [mattst] | -
[SaneSnippets] | [bobthecow] | -
[BetterSnippetManager] | [math2001] | -
[swap boolean polarity] | [mattst] | -
[PackageResourceViewer] [skuroda] | -
[OverrideAudit] | [odatnurd] | -

## [STealthy-and-haSTy]

[PlainTasks video]: https://www.youtube.com/watch?v=LsfGhjRVJwk

# Documentation
[official documentation](https://www.sublimetext.com/docs/3/)  
[unofficial documentation](http://docs.sublimetext.info/en/latest/)  
[package control documentation](https://packagecontrol.io/docs)  

[GitStatusBar]: https://github.com/randy3k/GitStatusBar
[SimpleSyntax]: https://github.com/budlabs/SimpleSyntax
[budlabs]: https://github.com/budlabs
[A File Icon]: https://github.com/ihodev/a-file-icon
[ihodev]: https://github.com/ihodev
[ApplySyntax]: https://github.com/facelessuser/ApplySyntax
[facelessuser]: https://github.com/facelessuser
[Chain of Command]: https://github.com/jisaacks/ChainOfCommand
[jisaacks]: https://github.com/jisaacks
[Color Highlighter]: https://github.com/Monnoroch/ColorHighlighter
[Monnoroch]: https://github.com/Monnoroch/ColorHighlighter
[DA UI]: https://github.com/ihodev/sublime-da-ui
[Extract Sublime Package]: https://github.com/SublimeText/ExtractSublimePackage
[SublimeText]: https://github.com/SublimeText
[File Rename]: https://github.com/brianlow/FileRename
[brianlow]: https://github.com/brianlow
[iOpener]: https://github.com/rosshemsley/iOpener
[rosshemsley]: https://github.com/rosshemsley
[PackageDev]: https://github.com/SublimeText/PackageDev
[PlainNotes]: https://github.com/aziz/PlainNotes
[aziz]: https://github.com/aziz
[ProjectManager]: https://github.com/randy3k/ProjectManager
[randy3k]: https://github.com/randy3k
[SnippetMaker]: https://github.com/jugyo/SublimeSnippetMaker
[jugyo]: https://github.com/jugyo 
[SublimeLinter]: http://www.sublimelinter.com/en/stable/
[Zen Tabs]: https://github.com/travmik/ZenTabs
[travmik]: https://github.com/travmik 
[MoveTab]: https://github.com/SublimeText/MoveTab
[ExpandRegion]: https://github.com/aronwoost/sublime-expand-region
[aronwoost]: https://github.com/aronwoost

