# .bash_aliases by Max Ilsen

# cd aliases
alias cdb1='cd ~/Dokumente/Studium/B1/'
alias cdb2='cd ~/Dokumente/Studium/B2/'
alias cdb3='cd ~/Dokumente/Studium/B3/'
alias cdb4='cd ~/Dokumente/Studium/B4/'
alias cdp='cd ~/Dokumente/Programmieren/'
alias cdib='cd ~/Dokumente/Studium/B4/Informatik\ B/'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

# ls aliases
alias ll='ls -alF'    # list all files in list format with classifer
alias la='ls -A'      # list all files and dirs  except .- and ..-dir
alias l='ls -CF'      # list entries in columns with classifier

# apt aliases
alias apts=pretty_apt_search
alias aptS="apt-cache show"
alias apti="sudo apt-get install"
alias aptc="sudo apt-get autoclean"
alias aptU="sudo apt-get update && sudo apt-get upgrade"

# backup and restore apt-packages (see .bash_functions)
alias bkp="backup_packages"
alias rst="restore_packages"

# do not remove files by accident
alias cp='cp -i'      # prompt before each use of cp and mv
alias mv='mv -i'
# alias rm='rm -i'
alias tp='trash-put'  # use trash-put instead of rm
alias rm='echo "Use trash-put."; false'

# start eclim with workspaces
alias eclim=$'/opt/eclipse/eclimd'
alias eclipse='/opt/eclipse/eclipse'
alias eclimp='/opt/eclipse/eclimd -Dosgi.instance.area.default=@user.home/Dokumente/Programmieren/'

# remove all temporary files
# alias rm~="find . -type f -name '*~' -exec rm -i {} \;"

# "alert" alias to alert when long running commands are executed; example usage:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# default ipython notebook options
alias ipyno='ipython notebook --pylab=inline --ip=localhost'

