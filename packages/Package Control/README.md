# Package Control
Sublimes, more or less, official package manager.
The special settings I have applied to this package is:  

``` JSON
"ignore_vcs_packages":
[
    "DisableArrowkeys",
    "CommandCommander",
    "VintageFinder",
    "VintageSanity",
    "SidebarToggler",
    "Mondo",
    "EndWithSemi"
],
"submit_usage": false,

"repositories":
[
    "https://github.com/mattst/sublime-swap-boolean-polarity.git",
    "https://github.com/budRich/iOpener.git",
    "https://github.com/math2001/SaneSnippets.git"
],
```


`"ignore_vcs_packages"` is a list of packages that should be completely ignored by Package Control, this is where I add my own packages.

`"repositories"` is a list of repositories to get forks of packages or packages that are not included in the official Package Control repository.
