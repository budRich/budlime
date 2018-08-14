# Recommended packages
package | author | description
:------ |:------ |:-----------
[SimpleSyntax](https://github.com/budlabs/SimpleSyntax) | [budlabs](https://github.com/budlabs) | A Sublime Text 3 package that adds a simple syntax highlighting, perfect for config files.
[A File Icon](https://github.com/ihodev/a-file-icon) | [ihodev](https://github.com/ihodev) | This package adds file icons to the sidebar. The author, ihodev, has created several cool UI related packages, such as `DA UI` and `DA CS`. 
[ApplySyntax](https://github.com/facelessuser/ApplySyntax) | [facelessuser](https://github.com/facelessuser) | Sublime applies syntax to files by looking at the file extension. With `ApplySyntax` one can make more fine grained rules for how the settings are applied. It is very useful for files that have no apparent way to determine the syntax. F.i. configuration files, which often have a syntax that only exist for that particular configfile (f.i. `i3wm`). `ApplySyntax` can set the syntax based on things like the content (looking for a specific line), or by evaluating the first line that often contains of a *shebang* that tells what syntax to use.
[Chain of Command](https://github.com/jisaacks/ChainOfCommand) | [jisaacks](https://github.com/jisaacks) | Sublime text plugin to run a chain of commands
[Color Highlighter](https://github.com/Monnoroch/ColorHighlighter) | [Monnoroch](https://github.com/Monnoroch/ColorHighlighter) | underlays selected hexadecimal colorcodes (like "#FFFFFF", "rgb(255,255,255)", "white", etc.) with their real color.
[DA UI](https://github.com/ihodev/sublime-da-ui) | [ihodev](https://github.com/ihodev) | Adaptive, Customizable, Elegant UI Theme and Color Schemes for Sublime Text 3
[Extract Sublime Package](https://github.com/SublimeText/ExtractSublimePackage) | [SublimeText](https://github.com/SublimeText) | Extract .sublime-package files to the Sublime Text Packages folder.
[File Rename](https://github.com/brianlow/FileRename) | [brianlow](https://github.com/brianlow) | Rename files from the SublimeText3 command palette. No mouse required.
[iOpener](https://github.com/rosshemsley/iOpener) | [rosshemsley](https://github.com/rosshemsley) | Open files from path, with completion, listings and history. Similar to Emacs find file.
[PackageDev](https://github.com/SublimeText/PackageDev) | [SublimeText](https://github.com/SublimeText) | Tools to ease the creation of snippets, syntax definitions, etc. for Sublime Text.
[PlainNotes](https://github.com/aziz/PlainNotes) | [aziz](https://github.com/aziz) | Simple and pleasant note taking for SublimeText
[ProjectManager](https://github.com/randy3k/ProjectManager) | [randy3k](https://github.com/randy3k) | Project Manager for Sublime Text 3
[SnippetMaker](https://github.com/jugyo/SublimeSnippetMaker) | [jugyo](https://github.com/jugyo) | Makes managing snippets easy in Sublime Text
[SublimeLinter](http://www.sublimelinter.com/en/stable/) | [SublimeLinter](https://github.com/SublimeLinter) | The code linting framework for Sublime Text 3
[Zen Tabs](https://github.com/travmik/ZenTabs) | [travmik](https://github.com/travmik) | he ultimate plugin for Sublime Text 2/3 to keep your tabs in Zen
[MoveTab](https://github.com/SublimeText/MoveTab) | [SublimeText](https://github.com/SublimeText) | Plugin for Sublime Text to move tabs around
[ExpandRegion](https://github.com/aronwoost/sublime-expand-region)|[aronwoost](https://github.com/aronwoost)|Like “Expand Selection to Scope”. But better!

# install packages

By populating the list *"installed_packages"* in: 
`SUBLIME_DIR/Packages/User/Package Control.sublime-preferences`  , **Package Control** will install any missing packages when sublime starts.


``` JSON
"ignore_vcs_packages": ["SimpleSyntax"],
"installed_packages":
[
  "A File Icon",
  "ApplySyntax",
  "Chain of Command",
  "ChannelRepositoryTools",
  "Color Highlighter",
  "DA UI",
  "Dockerfile Syntax Highlighting",
  "ExpandRegion",
  "Extract Sublime Package",
  "File Rename",
  "Golang Build",
  "Golang Tools Integration",
  "HTML-CSS-JS Prettify",
  "iOpener",
  "Man Page Support",
  "MoveTab",
  "Package Control",
  "PackageDev",
  "PlainNotes",
  "ProjectManager",
  "Snippet Destroyer",
  "SnippetMaker",
  "SublimeLinter",
  "SublimeLinter-contrib-write-good",
  "SublimeLinter-pycodestyle",
  "SublimeLinter-shellcheck",
  "SyntaxManager",
  "Zen Tabs"
],
```

https://packagecontrol.io/docs/customizing_packages
The article above describes the difference between *packed* and *unpacked* packages.  

The biggest drawback with *packed* packages is that it some interesting files, (*such as readme.md and default settings*), are hard to find.  

I have created a script `subextract(1)` that will extract move and rename all *interesting* files from the packed packages. `subextract` can be executed multiple times, and it will never overwrite existing `sublime-settings` files inside the **User** package.  
