#!/bin/bash --
#
# "XDG_CONFIG_HOME"/bash/bash_functions.sh by milsen
#

# alert after command execution with terminal or error icon and command name
# example usage: sleep 10; alert
alert() {
  notify-send --urgency=low \
    -i "$([ $? = 0 ] && echo terminal || echo error)" \
    "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"
}


# backup data on external hard drive using rsync
backup_rsync() {
  if [ ! -d /media/sdb1-usb-Intenso_External/ ]; then
    echo "No dir /media/sdb1-usb-Intenso_External/ found."
    return
  fi

  sudo rsync -aAX \
    --info=progress2,symsafe,stats3 \
    --delete \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
    --temp-dir="$HOME"/.cache/rsync/tmp/ \
    / /media/sdb1-usb-Intenso_External
}


# print out list of albums in $XDG_MUSIC_DIR
albums() {
  source "$XDG_CONFIG_HOME"/user-dirs.dirs
  MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/music}
  find "$MUSIC_DIR" -maxdepth 2 -mindepth 2 -type d -printf "- %h / %f\n" | \
    sed 's#'"$MUSIC_DIR"'/##' | \
    sort
}


# fuzzy directory-change
cdf() {
  cd *"$1"*/
}


# universal archive extraction
extract() {
 if [ -z "$1" ]; then
   # display usage if no parameters given
   usage="Usage: extract <path/file_name>."
   usage+="<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
   echo "$usage"
 else
    if [ -f "$1" ] ; then
      case "$1" in
        *.tar.bz2)   tar xvjf ./"$1"    ;;
        *.tar.gz)    tar xvzf ./"$1"    ;;
        *.tar.xz)    tar xvJf ./"$1"    ;;
        *.lzma)      unlzma ./"$1"      ;;
        *.bz2)       bunzip2 ./"$1"     ;;
        *.rar)       unrar x -ad ./"$1" ;;
        *.gz)        gunzip ./"$1"      ;;
        *.tar)       tar xvf ./"$1"     ;;
        *.tbz2)      tar xvjf ./"$1"    ;;
        *.tgz)       tar xvzf ./"$1"    ;;
        *.zip)       unzip ./"$1"       ;;
        *.Z)         uncompress ./"$1"  ;;
        *.7z)        7z x ./"$1"        ;;
        *.xz)        unxz ./"$1"        ;;
        *.exe)       cabextract ./"$1"  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "'$1' - file does not exist"
    fi
  fi
}


# most frequently used commands
mfu() {
  history | \
    awk '{CMD[$2]++;count++;}END {for (a in CMD)print CMD[a] " "  CMD[a]/count*100 "% " a;}' | \
    grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head "-n${1:-10}"
}

# general function for system commands
q() {
  case "$1" in
    killx)    killall xmonad ;;
    lock)     slock systemctl suspend -i
              exit ;;
    poweroff) systemctl poweroff ;;
    reboot)   systemctl reboot ;;
    suspend)  systemctl suspend ;;
    *)        return ;;
  esac
}
