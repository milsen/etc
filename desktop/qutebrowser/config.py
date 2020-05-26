#
# "$HOME"/.config/qutebrowser/config.py by milsen
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Unbindings
# These default bindings will be useless since their functions is overtaken by
# different keys.
unwanted_bindings = ['d', 'D', 'gC', 'co', 'g0', 'g^', 'g$', 'gf', 'ad', 'cd']
for binding in unwanted_bindings:
    config.unbind(binding)

# Key Remappings
c.bindings.key_mappings[","] = ";"

# Tab commands
config.bind('t',  'open -t ;; set-cmd-text -s :open')
config.bind('T',  'tab-clone')

config.bind('ö', 'tab-prev')
config.bind('ä', 'tab-next')
config.bind('gö', 'tab-move -')
config.bind('gä', 'tab-move +')
config.bind('x', 'tab-close')
config.bind('gx', 'tab-only')
config.bind('gX', 'tab-only -f')
config.bind('Ö', 'tab-focus 1')
config.bind('Ä', 'tab-focus -1')

# Forward / Backward
config.bind('<', 'back')
config.bind('<backspace>', 'back')
config.bind('g<', 'back -t')
config.bind('w<', 'back -w')

config.bind('>', 'forward')
config.bind('g>', 'forward -t')
config.bind('w>', 'forward -w')

# Scrolling
config.bind('J', 'run-with-count 8 scroll down')
config.bind('K', 'run-with-count 8 scroll up')
config.bind('H', 'run-with-count 8 scroll left')
config.bind('L', 'run-with-count 8 scroll right')

# Navigation
config.bind('[','navigate prev')
config.bind(']','navigate next')
config.bind('{','navigate prev -t')
config.bind('}','navigate next -t')

# Downloads
config.bind('D', 'download')
config.bind('gD', 'download-cancel')
config.bind('gd', 'download-clear')

# "Leader" Commands (starting with <space>)
config.bind(' b', 'config-cycle statusbar.hide')
config.bind(' t', 'config-cycle tabs.show always switching')
config.bind(' x', 'config-cycle statusbar.hide ;; config-cycle tabs.show always switching')
# config.bind('Sb', 'open qute://bookmarks#bookmarks')
# config.bind('Sh', 'open qute://history')
# config.bind('Sq', 'open qute://bookmarks')
# config.bind('Ss', 'open qute://settings')

# General
config.bind('<ctrl-z>', 'undo')
config.bind('V', 'view-source')
# config.bind('S', 'stop')
config.bind('z', 'set general private-browsing!')
config.bind('<Ctrl-n>', 'completion-item-focus next', 'command')
config.bind('<Ctrl-p>', 'completion-item-focus prev', 'command')

# Colors
color0  = "#282a2e"
color1  = "#b84747"
color2  = "#518234"
color3  = "#e0925c"
color4  = "#4f7798"
color5  = "#a582b0"
color6  = "#52b6a9"
color7  = "#686f77"
color8  = "#50565e"
color9  = "#d25d5d"
color10 = "#bdc75e"
color11 = "#ebc273"
color12 = "#83a7c5"
color13 = "#c8afce"
color14 = "#82b8b1"
color15 = "#adb0ae"

# Settings
c.colors.statusbar.normal.bg = color0
c.colors.statusbar.normal.fg = "white"
c.colors.statusbar.private.bg = color0 # TODO
c.colors.statusbar.private.fg = "white"
c.colors.statusbar.caret.bg = color5
c.colors.statusbar.caret.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.caret.selection.bg = color4
c.colors.statusbar.caret.selection.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.command.bg = c.colors.statusbar.normal.fg
c.colors.statusbar.command.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.command.private.bg = c.colors.statusbar.private.bg
c.colors.statusbar.command.private.fg = c.colors.statusbar.private.fg
c.colors.statusbar.insert.bg = color2
c.colors.statusbar.insert.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.progress.bg = c.colors.statusbar.normal.fg
c.colors.statusbar.url.error.fg = color9
c.colors.statusbar.url.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.url.hover.fg = color13
c.colors.statusbar.url.success.http.fg = "white"
c.colors.statusbar.url.success.https.fg = color11
c.colors.statusbar.url.warn.fg = color3

c.colors.tabs.bar.bg = "#555555"
c.colors.tabs.even.bg = color0
c.colors.tabs.even.fg = "white"
c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.odd.fg = c.colors.tabs.even.fg
c.colors.tabs.selected.even.bg = c.colors.tabs.even.fg
c.colors.tabs.selected.even.fg = c.colors.tabs.even.bg
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg

c.content.pdfjs = True
c.content.private_browsing = True
c.content.xss_auditing = True
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.editor.command = ["termite", "-e", "nvim {}"]

c.fonts.default_family = 'xos4 Terminus'
c.fonts.completion.category = "bold 12pt default_family"
c.fonts.completion.entry = "12pt default_family"
c.fonts.debug_console = "12pt default_family"
c.fonts.downloads = "10pt default_family"
c.fonts.hints = "bold 17px default_family"
c.fonts.keyhint = "12pt default_family"
c.fonts.messages.error = "12pt default_family"
c.fonts.messages.info = "12pt default_family"
c.fonts.messages.warning = "12pt default_family"
c.fonts.prompts = "12pt sans-serif"
c.fonts.statusbar = "16pt default_family"
c.fonts.tabs = "bold 16pt default_family"

c.hints.auto_follow_timeout = 400
c.hints.dictionary = "/usr/share/dict/cracklib-small"
c.hints.mode = "word"

c.input.partial_timeout = 1000
c.keyhint.delay = 200

c.scrolling.bar = "always"
c.scrolling.smooth = True

c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False

c.url.default_page = "about:blank"
c.url.searchengines = {
  'DEFAULT' : 'https://duckduckgo.com/?q={}',
  'd' : 'https://dict.cc/?s={}',
  'e' : 'https://www.ecosia.org/search?q={}',
  'g' : 'https://www.google.org/search?q={}',
  'm' : 'https://rateyourmusic.com/search?searchterm={}&searchtype=a',
  'M' : 'http://www.sputnikmusic.com/search_results.php?search_in=Bands&search_text={}',
  'r' : 'https://reddit.com/r/{}',
  's' : 'https://www.startpage.com/do/search?lui=english&cat=web&query={}',
  'y' : 'https://www.youtube.com/results?search_query={}',
  }

c.window.title_format = "{perc}{current_title}{title_sep}qutebrowser{private}"
c.zoom.default = "150%"
