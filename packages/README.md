# recommended packages

By populating the list *"installed_packages"* in: 
`SUBLIME_DIR/Packages/User/Package Control.sublime-preferences`  , **Package Control** will install any missing packages when sublime starts.

``` JSON
"installed_packages":
[
	"A File Icon",
	"ApplySyntax",
	"Color Highlighter",
	"DA UI",
	"Extract Sublime Package",
	"File Rename",
	"Gruvbox Dark",
	"iOpener",
	"Package Control",
	"ProjectManager",
	"SimpleSyntax",
	"Zen Tabs"
]
```

https://packagecontrol.io/docs/customizing_packages
The article above describes the difference between *packed* and *unpacked* packages.  

The biggest drawback with *packed* packages is that it some interesting files, (*such as readme.md and default settings*), are hard to find.  

I have created a script `subextract(1)` that will extract move and rename all *interesting* files from the packed packages. `subextract` can be executed multiple times, and it will never overwrite `sublime-settings` files inside the **User** package.