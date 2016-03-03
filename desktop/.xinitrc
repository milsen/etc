#!/bin/sh --
#
# "$HOME"/.xinitrc by milsen
#
# Sourced when startx is called.
# Dependent on dunst, wmutils, wmrc, sxhkd and my own scripts rnd_wall.sh and
# bar.sh.

# start programs "recommended" by system
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# random wallpaper-script
rnd_wall.sh

# keyboard configuration, see /usr/share/X11/xkb/rules/base.lst
setxkbmap -layout de
setxkbmap -variant nodeadkeys
setxkbmap -model thinkpad60
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option caps:none

# lemonbar-script
bar.sh &

# notifications with dunst
dunst &

# controls actions upon window status changes
wew | evhandle &

# keybindings, parent process for X
# if it is killed, X is killed, too
exec sxhkd -m 1
