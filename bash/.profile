# .profile by Max Ilsen
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
