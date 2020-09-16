#!/bin/sh
#
# "$HOME"/.profile by milsen
#
# Commands for Bourne-compatible login-shells.
# This file is not read by bash, if ~/.bash_profile or ~/.bash_login exist.

# if running bash and .bashrc is readable, source it
if [ -n "$BASH_VERSION" ]; then
  [[ -r "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's ruby-gem bin if it exists
command -v "ruby" >/dev/null 2>&1 && { \
  gemdir="$HOME/.gem/ruby/2.7.0"
  if [ -d "$gemdir" ] ; then
    PATH="$gemdir/bin:$PATH"
  fi
}
