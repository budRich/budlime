## [iOpener] - Open files from path, with completion, listings and history. Similar to Emacs find file.
by: [rosshemsley]

### budlabs mod
I changed a small part of `i_opener.py` around line **210**:  

``` py
folder = dict(path=path, follow_symlinks=True)
if project_data == {}:
    project_data = dict(folders=[dict(follow_symlinks=True, path=path)])
elif all(folder['path'] != path for folder in project_folders):
    project_data['folders'].append(folder)
sublime.active_window().set_project_data(project_data)
```

this mod will create a new project if the workspace is clean, and a directory is chosen.

**edit**
I just saw that someone already had made a pullrequest with a more elegant solution.  
https://github.com/rosshemsley/iOpener/pull/33/commits/e368274df38c3df1798a5e559eca29b211606603

I have also applied this patch:  
https://github.com/rosshemsley/iOpener/pull/31/commits/7555c4daa8e62d4a40f672134d121f3850de116c

That will autocomplete better when there are multiple options.

I made a fork of [mattst's fork][mattstfrk], to which i applied the two patches linked above.  

If you choose to use [my fork], clone the repo and copy the directory to `~/sublime-text-3/Packages` . And add `iOpener` to 
`~/sublime-text-3/Packages/User/Package Control.sublime-settings` `ignore_vcs_packages` list:   

``` js
"ignore_vcs_packages":
[
    "SimpleSyntax",
    "iOpener"
],
```

[mattstfrk]: https://github.com/mattst/iOpener
[my for]: https://github.com/budRich/iOpener

- - - - - -

Open files from path, with completion, listings and history. Similar to Emacs find file.

This package only have one function. It overrides the default open file functionality. Instead of launching the normal open file dialog (which differs depending on the OS), this package uses sublimes built in panel and command palette. It supports tab completion and if a file doesn't exist it will get created (along with needed subdirectories), making this package perfect for creating new files.

I like to set this setting:  
`"open_folders_in_new_window": false,`  

to false. That will add folders to the current project instead of opening them in a new window.

[iOpener]: https://github.com/rosshemsley/iOpener
[rosshemsley]: https://github.com/rosshemsley
