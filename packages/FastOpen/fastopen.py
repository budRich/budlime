import sublime
import sublime_plugin
import re

from os.path import isdir, isfile, expanduser, split, commonprefix, normpath
from os import sep, makedirs


class FastOpenCommand(sublime_plugin.WindowCommand):
    def run(self, file):

        # get current project name
        pname = sublime.active_window().project_file_name()
        pname = re.sub('^.*/', '', pname)
        pname = re.sub('\.sublime-project$', '', pname)

        # add project name to file
        file = (re.sub('\${project_base_name}', pname, file))

        path = expanduser(file)

        # Ignore empty paths.
        if not path:
            sublime.status_message("Warning: Ignoring empty path.")
            return

        directory = ""
        filename = ""

        # If the user enters a path without a filename.
        if path[-1] == sep:
            directory = path
        else:
            directory, filename = split(path)

        # Path doesn't exist, ask the user if they want to create it.
        if not isdir(directory):
            try:
                makedirs(directory)
            except OSError as e:
                sublime.error_message(
                    "Failed to create path with error: " + str(e)
                    )
                return

        if not isfile(path):
            sublime.status_message("Created new buffer '"+filename+"'")
        sublime.active_window().open_file(path)
