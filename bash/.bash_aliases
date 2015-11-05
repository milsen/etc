#!/bin/bash --
# .bash_aliases by Max Ilsen

# cd aliases
alias cdb1='cd ~/Dokumente/Studium/B1/'
alias cdb2='cd ~/Dokumente/Studium/B2/'
alias cdb3='cd ~/Dokumente/Studium/B3/'
alias cdb4='cd ~/Dokumente/Studium/B4/'
alias cdb5='cd ~/Dokumente/Studium/B5/'
alias cdp='cd ~/Dokumente/Programmieren/'
alias cdd='cd ~/Dokumente/Programmieren/dotfiles/'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# ls aliases
alias ll='ls -alF'    # list all files in list format with classifer
alias la='ls -A'      # list all files and dirs  except .- and ..-dir
alias l='ls -CF'      # list entries in columns with classifier

# tree aliases
alias treea="tree -a -I '.git' --dirsfirst" # tree of all files except .git-dirs

# apt aliases
alias apts="pretty_apt_search"
alias aptS="apt-cache show"
alias apti="sudo apt-get install"
alias aptc="sudo apt-get autoclean"
alias aptU="sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoclean"

# set color usage of ls, dir and grep
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# backup and restore apt-packages (see .bash_functions)
alias bkp="backup_packages"
alias rst="restore_packages"

# do not remove files by accident
alias cp='cp -i'      # prompt before each use of cp, mv and rm
alias mv='mv -i'
alias rm='rm -i'
alias tp='trash-put'  # use trash-put instead of rm if possible

# start eclim with workspaces
alias eclim='/opt/eclipse/eclimd'
alias eclipse='/opt/eclipse/eclipse'

# remove all temporary files
alias rm~="find . -type f -name '*~' -not -iwholename '*Trash*' -exec rm -i {} \;"

# default options for programming langaguages/environments
alias ipyno='ipython notebook --pylab=inline --ip=localhost'
alias octavep='octave --persist'

