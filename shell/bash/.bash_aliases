#!/bin/bash --
# .bash_aliases by Max Ilsen

# cd aliases
alias cdb='cd ~/bin'
alias cdd='cd ~/doc'
alias cde='cd ~/etc'
alias cdm='cd ~/media'
alias cdo='cd ~/other'
alias cdp='cd ~/pkg'
alias cds='cd ~/src'
alias cdt='cd ~/tmp'
alias cdw='cd ~/wall'

alias cdB1='cd ~/doc/Studium/B1/'
alias cdB2='cd ~/doc/Studium/B2/'
alias cdB3='cd ~/doc/Studium/B3/'
alias cdB4='cd ~/doc/Studium/B4/'
alias cdB5='cd ~/doc/Studium/B5/'
alias cdB6='cd ~/doc/Studium/B6/'

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
if [ ! -z $(command -v apt-get) ]; then
  alias apts="pretty_apt_search"
  alias aptS="apt-cache show"
  alias apti="sudo apt-get install"
  alias aptc="sudo apt-get autoclean"
  alias aptU="sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoclean"
fi

# set color usage of ls, dir and grep
if [ -x /usr/bin/dircolors ]; then
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

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

# other aliases
alias music='ncmpcpp'
