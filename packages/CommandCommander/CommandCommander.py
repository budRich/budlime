import sublime
import sublime_plugin
import os.path


class StopInsertOnFocusLost(sublime_plugin.EventListener):
    def on_deactivated(self, view):
        view.run_command('exit_insert_mode')
