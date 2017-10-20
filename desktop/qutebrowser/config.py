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
del c.bindings.key_mappings["<Ctrl-J>"]
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

# c.aliases
# c.auto_save.interval
# c.auto_save.session
# c.backend
# c.bindings.commands
# c.bindings.default
# c.bindings.key_mappings

# Colors
# c.colors.completion.category.bg
# c.colors.completion.category.border.bottom
# c.colors.completion.category.border.top
# c.colors.completion.category.fg
# c.colors.completion.even.bg
# c.colors.completion.fg = "white"
# c.colors.completion.item.selected.bg
# c.colors.completion.item.selected.border.bottom
# c.colors.completion.item.selected.border.top
# c.colors.completion.item.selected.fg
# c.colors.completion.match.fg
# c.colors.completion.odd.bg
# c.colors.completion.scrollbar.fg = c.colors.completion.fg
# c.colors.completion.scrollbar.bg = c.colors.completion.bg
# c.colors.downloads.bar.bg
# c.colors.downloads.error.bg
# c.colors.downloads.error.fg
# c.colors.downloads.start.bg
# c.colors.downloads.start.fg
# c.colors.downloads.stop.bg
# c.colors.downloads.stop.fg
# c.colors.downloads.system.bg
# c.colors.downloads.system.fg
# c.colors.hints.bg
# c.colors.hints.fg
# c.colors.hints.match.fg
# c.colors.keyhint.bg
# c.colors.keyhint.fg
# c.colors.keyhint.suffix.fg
# c.colors.messages.error.bg
# c.colors.messages.error.border
# c.colors.messages.error.fg
# c.colors.messages.info.bg
# c.colors.messages.info.border
# c.colors.messages.info.fg
# c.colors.messages.warning.bg
# c.colors.messages.warning.border
# c.colors.messages.warning.fg
# c.colors.prompts.bg
# c.colors.prompts.border
# c.colors.prompts.fg
# c.colors.prompts.selected.bg

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
# c.colors.tabs.indicator.error
# c.colors.tabs.indicator.start
# c.colors.tabs.indicator.stop
# c.colors.tabs.indicator.system
c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.odd.fg = c.colors.tabs.even.fg
c.colors.tabs.selected.even.bg = c.colors.tabs.even.fg
c.colors.tabs.selected.even.fg = c.colors.tabs.even.bg
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg
# c.colors.webpage.bg

# c.completion.cmd_history_max_items
# c.completion.height
# c.completion.quick
# c.completion.scrollbar.padding
# c.completion.scrollbar.width
# c.completion.show
# c.completion.shrink
# c.completion.timestamp_format
# c.completion.web_history_max_items
# c.confirm_quit
# c.content.cache.appcache
# c.content.cache.maximum_pages
# c.content.cache.size
# c.content.cookies.accept
# c.content.cookies.store
# c.content.default_encoding
# c.content.developer_extras
# c.content.dns_prefetch
# c.content.frame_flattening
# c.content.geolocation
# c.content.headers.accept_language
# c.content.headers.custom
# c.content.headers.do_not_track
# c.content.headers.referer
# c.content.headers.user_agent
# c.content.host_blocking.enabled
# c.content.host_blocking.lists
# c.content.host_blocking.whitelist
# c.content.hyperlink_auditing
# c.content.images
# c.content.javascript.alert
# c.content.javascript.can_access_clipboard
# c.content.javascript.can_close_tabs
# c.content.javascript.can_open_tabs_automatically
# c.content.javascript.enabled
# c.content.javascript.log
# c.content.javascript.modal_dialog
# c.content.javascript.prompt
# c.content.local_content_can_access_file_urls
# c.content.local_content_can_access_remote_urls
# c.content.local_storage
# c.content.media_capture
# c.content.netrc_file
# c.content.notifications
c.content.pdfjs = True
# c.content.plugins
# c.content.print_element_backgrounds
c.content.private_browsing = True
# c.content.proxy
# c.content.proxy_dns_requests
# c.content.ssl_strict
# c.content.user_stylesheets
# c.content.webgl
c.content.xss_auditing = True
# c.downloads.location.directory
c.downloads.location.prompt = False
c.downloads.location.remember = False
# c.downloads.location.suggestion
# c.downloads.open_dispatcher
# c.downloads.position
# c.downloads.remove_finished
c.editor.command = ["termite", "-e", "nvim", "{}"]
# c.editor.encoding

c.fonts.completion.category = "bold 12pt monospace"
c.fonts.completion.entry = "12pt monospace"
c.fonts.debug_console = "12pt monospace"
c.fonts.downloads = "10pt monospace"
c.fonts.hints = "bold 17px monospace"
c.fonts.keyhint = "12pt monospace"
c.fonts.messages.error = "12pt monospace"
c.fonts.messages.info = "12pt monospace"
c.fonts.messages.warning = "12pt monospace"
c.fonts.monospace = "Terminus"
c.fonts.prompts = "12pt sans-serif"
c.fonts.statusbar = "16pt monospace"
c.fonts.tabs = "16pt monospace"

# c.fonts.web.family.cursive
# c.fonts.web.family.fantasy
# c.fonts.web.family.fixed
# c.fonts.web.family.sans_serif
# c.fonts.web.family.serif
# c.fonts.web.family.standard
# c.fonts.web.size.default
# c.fonts.web.size.default_fixed
# c.fonts.web.size.minimum
# c.fonts.web.size.minimum_logical

# c.hints.auto_follow = "unique-match"
c.hints.auto_follow_timeout = 400
# c.hints.border
# c.hints.chars
c.hints.dictionary = "/usr/share/dict/cracklib-small"
# c.hints.find_implementation
# c.hints.hide_unmatched_rapid_hints
# c.hints.min_chars
c.hints.mode = "word"
# c.hints.next_regexes
# c.hints.prev_regexes
# c.hints.scatter
# c.hints.uppercase = False

# c.history_gap_interval
# c.ignore_case
# c.input.forward_unbound_keys
# c.input.insert_mode.auto_leave
# c.input.insert_mode.auto_load
# c.input.insert_mode.plugins
# c.input.links_included_in_focus_chain
c.input.partial_timeout = 1000
# c.input.rocker_gestures
# c.input.spatial_navigation
# c.keyhint.blacklist
c.keyhint.delay = 200

# c.messages.timeout
# c.messages.unfocused
# c.new_instance_open_target
# c.new_instance_open_target_window
# c.prompt.filebrowser
# c.prompt.radius
# c.qt.args
# c.qt.force_platform
# c.qt.force_software_rendering
c.scrolling.bar = True
c.scrolling.smooth = True
# c.session_default_name
# c.spellcheck.languages
# c.statusbar.hide
# c.statusbar.padding
# c.statusbar.position
#
# c.tabs.background
# c.tabs.close_mouse_button
# c.tabs.favicons.scale
# c.tabs.favicons.show
# c.tabs.indicator_padding
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
# c.tabs.new_position.related
# c.tabs.new_position.unrelated
# c.tabs.padding
# c.tabs.position
# c.tabs.select_on_remove
# c.tabs.show
# c.tabs.show_switching_delay
# c.tabs.tabs_are_windows
# c.tabs.title.alignment
# c.tabs.title.format
# c.tabs.title.format_pinned
# c.tabs.width.bar
# c.tabs.width.indicator
# c.tabs.wrap

# c.url.auto_search
c.url.default_page = "about:blank"
# c.url.incdec_segments
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
# c.url.start_pages
# c.url.yank_ignored_parameters

# c.window.hide_wayland_decoration
c.window.title_format = "{perc}{title}{title_sep}qutebrowser{private}"
c.zoom.default = "150%"
# c.zoom.levels
# c.zoom.mouse_divider
# c.zoom.text_only
