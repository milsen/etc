#!/bin/bash --

# get directory of this install-script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function check_dependency() {
  command -v "$1" >/dev/null 2>&1 || \
    { echo "Please install $1"; exit 1; }
}

function ask_user() {
  echo "$1"
  while true
  do
    read -p "y/n? " answer
    case "$answer" in
      Yes|yes|Y|y|"") "$2"
        break;;
      No|no|N|n)
        break;;
      *)
        ;;
    esac
  done
}

function symlink_develop_files() {
  DEVELOP_DIR="$DOTFILES_DIR/develop"

  # create config-directories
  mkdir -p "$HOME"/.config
  mkdir -p "$HOME"/.config/bash

  # symlink non-vim-files
  ln -sfv "$DEVELOP_DIR/coreutils/"                   "$HOME"/.config/
  ln -sfv "$DEVELOP_DIR/git/"                         "$HOME"/.config/
  ln -sfv "$DEVELOP_DIR/.latexmkrc"                   "$HOME"
  ln -sfv "$DEVELOP_DIR/readline/"                    "$HOME"/.config/
  ln -sfv "$DEVELOP_DIR/shell/bash/.bash_aliases"     "$HOME"
  ln -sfv "$DEVELOP_DIR/shell/bash/bash_functions.sh" "$HOME"/.config/bash
  ln -sfv "$DEVELOP_DIR/shell/bash/.bash_logout"      "$HOME"
  ln -sfv "$DEVELOP_DIR/shell/bash/.bashrc"           "$HOME"
  ln -sfv "$DEVELOP_DIR/shell/.profile"               "$HOME"
  ln -sfv "$DEVELOP_DIR/.vim/"                        "$HOME"

  # make sure that other bash configuration files do not exist such that .profile
  # is actually sourced for login-shells
  rm -f "$HOME"/.bash_login
  rm -f "$HOME"/.bash_profile

  # symlink neovim-files
  ln -sfv "$HOME"/.vim       "$HOME"/.config/nvim
  ln -sfv "$HOME"/.vim/vimrc "$HOME"/.config/nvim/init.vim

  # create vim-directories
  mkdir -p ~/.vim/bundle
  mkdir -p ~/.cache/vim/{backup,undo,swap}
}

function symlink_desktop_files() {
  DESKTOP_DIR="$DOTFILES_DIR/desktop"

  mkdir -p "$HOME"/.cache/mpd/playlists
  mkdir -p "$HOME"/.cache/qutebrowser

  ln -sfv "$DESKTOP_DIR/abcde/.abcde.conf"            "$HOME"
  ln -sfv "$DESKTOP_DIR/dunst/"                       "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/feh/"                         "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/mpd/"                         "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/ncmpcpp/"                     "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/pulse/daemon.conf"            "$HOME"/.config/pulse/
  ln -sfv "$DESKTOP_DIR/qutebrowser/config.py"        "$HOME"/.config/qutebrowser/
  ln -sfv "$DESKTOP_DIR/rncbc.org/"                   "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/termite/"                     "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/xdg/user-dirs.dirs"           "$HOME"/.config/
  ln -sfv "$DESKTOP_DIR/.xinitrc"                     "$HOME"
  ln -sfv "$DESKTOP_DIR/.xmonad/"                     "$HOME"
  ln -sfv "$DESKTOP_DIR/zathura/"                     "$HOME"/.config/
}

function symlink_scripts() {
  chmod a+x "$DOTFILES_DIR/bin/"*
  ln -sfv "$DOTFILES_DIR/bin/" "$HOME"
}

# make sure that git, curl and vim are installed
for com in git curl vim; do
  check_dependency "$com"
done

# do the actual symlinking
symlink_develop_files
ask_user "Do you want to symlink files for non-development purposes as well?" \
  "symlink_desktop_files"
ask_user "Do you want to symlink scripts as well?" "symlink_scripts"

# install vim-plugins using vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugUpdate|qall"
