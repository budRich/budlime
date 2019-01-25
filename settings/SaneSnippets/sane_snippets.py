# -*- encoding: utf-8 -*-

import sublime
import sublime_plugin
import os.path
from .sane_snippets_tools import Snippet
from .functions import *

def plugin_loaded():
    sublime.run_command('generate_snippets')

class SaneSnippetListener(sublime_plugin.EventListener):

    def on_post_save(self, view):
        file_name = view.file_name()
        if not file_name.endswith('.sane-snippet'):
            return
        snippet = Snippet(file_name).convert(force=True)
        sublime.run_command('sane_snippets', {'action': 'clean',
                                              'path': os.path.dirname(file_name)})

class SaneSnippetsCommand(sublime_plugin.ApplicationCommand):

    def generate_action(self):
        """Convert every .sane-snippet to a .sublime-snippet"""
        for dirname, dirs, files in walk_tree(sublime.packages_path()):

            for file in files:
                if not file.endswith('.sane-snippet'):
                    continue

                Snippet(os.path.join(dirname, file)).convert(force=True)

    def clean_action(self, path=''):
        """Removes .sublime-snippet that do not have a .sans-snippet equivalent"""
        for dirname, dirs, files in walk_tree(os.path.join(sublime.packages_path(), path)):
            for file in files:
                if not file.endswith('.sublime-snippet'):
                    continue

                if not os.path.exists(Snippet(os.path.join(dirname, file)).get_dst()):
                    os.remove(os.path.join(dirname, file))

    def migrate_action(self, soft=None):
        """Create .sane-snippet from .sublime-snippet
        if soft is None, then it'll ask each time the destination exists to overwrite it
        if soft is True, then it won't do anything if the destination already exists
        if soft is False, then it'll *silently* write the destination, even if it already exists
        """
        if soft not in (None, False, True):
            raise ValueError("The soft arguments should be None, False or True,"
                             "got {!r}".format(soft))

        for dirname, dirs, files in walk_tree(sublime.packages_path()):
            for file in files:
                if not file.endswith('.sublime-snippet'):
                    continue
                snippet = Snippet(os.path.join(dirname, file))
                if soft is True or soft is None:
                    try:
                        snippet.convert()
                    except FileExistsError:
                        if soft is None:
                            ans = sublime.yes_no_cancel_dialog(
                                "The file '{}' already exists. Overwrite?\n\n "
                                "(press cancel to stop everything)".format(snippet.get_dst()),
                                'Overwrite', 'Skip')
                            if ans == sublime.DIALOG_YES:
                                snippet.convert(force=True)
                            elif ans == sublime.DIALOG_NO:
                                continue
                            elif ans == sublime.DIALOG_CANCEL:
                                return

                elif soft is False:
                    snippet.convert(force=True)


    def run(self, action, *args, **kwargs):
        try:
            function = getattr(self, action + '_action')
        except AttributeError:
            return sublime.error_message("SaneSnippet: "
                                         "Couldn't find the action '{}'".format(action))
        function(*args, **kwargs)
