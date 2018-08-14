## [ProjectManager] - Project Manager for Sublime Text 3
by: [randy3k]

Projects is one of the best features of **Sublime Text**, but as with most of the built in functionality it is very clunky to manage.  

[randy3k] have created [ProjectManager], which is a excellent package that makes managing projects a lot easier and convenient.  

I have disabled the command:  
``` JSON
{
    "caption": "Project Manager: Edit Project",
    "command": "project_manager", "args": {"action": "edit"}
},
```

In favor for the default edit project command, which I also have bound to a key combination:  

``` JSON
{ 
  "keys": ["alt+p"],
  "command": "open_file", "args": {"file": "${project}"} 
},
```

The reason for this is that [ProjectManager]s edit command, opens the command palette to let you chose which project file to edit. But I have found that i always wants to edit the currently open projects project file, which the default command does.  

[randy3k]: https://github.com/randy3k
[ProjectManager]: https://github.com/randy3k/ProjectManager
