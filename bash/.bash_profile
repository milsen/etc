# .bash_profile by Max Ilsen
# will prevent reading of ~/.profile
# the default umask is set in /etc/profile; for setting the umask for ssh
# logins, install and configure the libpam-umask package.
#umask 022

# if running bash and .bashrc is readable, source it
# otherwise .bashrc would be only executed for interactive non-login shells
if [ -n "$BASH_VERSION" ]; then
  [[ -r "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
