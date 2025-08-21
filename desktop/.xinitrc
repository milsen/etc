#!/bin/sh --
#
# "$HOME"/.xinitrc by milsen
#
# Sourced when startx is called.
#

# start programs "recommended" by system
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# source XDG-user-directories, use "$HOME"/images as default image-directory
. ~/.config/user-dirs.dirs
IMAGE_DIR="${XDG_PICTURES_DIR:-$HOME/images}"

# random wallpaper
feh --no-fehbg --bg-fill --randomize "$IMAGE_DIR"/wallpapers/ &

# keyboard configuration, see /usr/share/X11/xkb/rules/base.lst
setxkbmap -layout de
setxkbmap -variant nodeadkeys
setxkbmap -model thinkpad60
setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option caps:none

# start automounter
udiskie --smart-tray &

# adjust screen colors according to daytime
redshift -l 50.0:7.0 -t 5200:2700 -g 0.8 -m randr &

# let Java AWT menus work with light-weight window managers
export _JAVA_AWT_WM_NONREPARENTING=1

# execute i3 as parent process for X
# if it is killed, X is killed, too
exec i3
