import sublime
import sublime_plugin
import os.path


class StopInsertOnFocusLost(sublime_plugin.EventListener):
    def on_deactivated(self, view):
        view.run_command('exit_insert_mode')

    def on_activated(self, view):
        if view.settings().get('is_widget'):
            view.run_command('enter_insert_mode')
