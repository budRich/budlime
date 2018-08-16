import sublime
import sublime_plugin

USRPREF = 'Preferences.sublime-settings'
FNTPREF = 'TwoFont.sublime-settings'

def get_setting(setting):
  return sublime.load_settings(USRPREF).get(setting, '')

def set_setting(setting, value):
  return sublime.load_settings(USRPREF).set(setting, value)

def get_font(font):
  return sublime.load_settings(FNTPREF).get(font, '')

def set_font(font):
  newfnt = get_font(font)
  for setting in newfnt:
    set_setting(setting, newfnt[setting])

def commit():
  return sublime.save_settings(USRPREF)

class TwoFontCommand(sublime_plugin.WindowCommand):
  def run(self, font='toggle'):
    if font == 'toggle':
      self.fnt1 = get_font('font1')
      self.curfnt = get_setting('font_options')
      self.newfnt = 'font2'

      for setting in self.fnt1:
        if get_setting(setting) != self.fnt1[setting]:
          self.newfnt = 'font1'
    else:
      self.newfnt = font

    set_font(self.newfnt)
    commit()
