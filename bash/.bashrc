#!/bin/bash --
# .bashrc by Max Ilsen

# see /usr/share/doc/bash/examples/startup-files
# see /usr/share/doc/bash-doc/examples (in the bash-doc package)
# see /etc/bash.bashrc and /etc/profile sourcing it

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Shell Variables
HISTCONTROL=ignoredups  # don't put duplicate lines in history
HISTSIZE=1000           # set command history in memory to 1000
HISTFILESIZE=2000       # set command history in history-file to 1000

# Shell Options
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s checkwinsize   # check window size after commands, update LINES and COLUMNS
shopt -s globstar       # "**" matches all files and zero or more dirs and subdirs

# Key Remapping
setxkbmap -option caps:escape # remap caps-lock to escape

# use lesspipe if executable to make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Prompt-Settings {{{
# see man bash  ("PROMPTING") and ANSI escape sequences

# identify the chroot you work in (if not set earlier)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# terminal title shows user, host and working directory
export PROMPT_COMMAND='echo -ne "\033]0;$(whoami)@$(hostname): $PWD\007"'

# actual prompt is chroot and $ or # to show whether you are root
PS1='${debian_chroot:+($debian_chroot)}'
PS1='\[\e[01;34m\]\$\[\e[00m\] '
# }}}

# Loading Other Files
# if /usr/bin/dircolors is executable
if [ -x /usr/bin/dircolors ]; then
  # if ~/.dircolors is readable try to set LS_COLORS to it (if that fails, use defaults)
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# load functions
if [ -r ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# load alias definitions
if [ -r ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features
if [ -r /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

