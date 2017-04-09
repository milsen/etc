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

function symlink_non_develop_files() {
  mkdir -p "$HOME"/.cache/mpd/playlists

  ln -sfv "$DOTFILES_DIR/desktop/abcde/.abcde.conf"    "$HOME"
  ln -sfv "$DOTFILES_DIR/desktop/dunst/"               "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/desktop/feh/"                 "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/desktop/xdg/user-dirs.dirs"   "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/desktop/.xmonad/"             "$HOME"
  ln -sfv "$DOTFILES_DIR/desktop/zathura/"             "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/desktop/.xinitrc"             "$HOME"
  ln -sfv "$DOTFILES_DIR/music/ncmpcpp/"               "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/music/mpd/"                   "$HOME"/.config/
  ln -sfv "$DOTFILES_DIR/term/termite/"                "$HOME"/.config/
}

function symlink_scripts() {
  chmod a+x "$DOTFILES_DIR/scripts/"*
  mkdir -p "$HOME"/bin
  ln -sfv "$DOTFILES_DIR/scripts/"*                    "$HOME"/bin
}

# make sure that git, curl and vim are installed
for com in git curl vim; do
  check_dependency "$com"
done

ask_user "Do you want to symlink files for non-development purposes as well?" \
  "symlink_non_develop_files"
ask_user "Do you want to symlink scripts as well?" "symlink_scripts"

# create config-directories
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.config/bash

# symlink non-vim-files
ln -sfv "$DOTFILES_DIR/shell/bash/.bash_aliases"     "$HOME"
ln -sfv "$DOTFILES_DIR/shell/bash/bash_functions.sh" "$HOME"/.config/bash
ln -sfv "$DOTFILES_DIR/shell/bash/.bash_logout"      "$HOME"
ln -sfv "$DOTFILES_DIR/shell/bash/.bashrc"           "$HOME"
ln -sfv "$DOTFILES_DIR/shell/.profile"               "$HOME"
ln -sfv "$DOTFILES_DIR/coreutils/"                   "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/git/"                         "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/misc_runcom/.latexmkrc"       "$HOME"
ln -sfv "$DOTFILES_DIR/readline/"                    "$HOME"/.config/

# make sure that other bash configuration files do not exist such that .profile
# is actually sourced for login-shells
rm -f "$HOME"/.bash_login
rm -f "$HOME"/.bash_profile

# symlink (neo)vim-files
ln -sfv "$DOTFILES_DIR/.vim/"                      "$HOME"
ln -sfv "$HOME"/.vim                               "$HOME"/.config/nvim
ln -sfv "$HOME"/.vim/vimrc                         "$HOME"/.config/nvim/init.vim

# create vim-directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.cache/vim/{backup,undo,swap}

# install vim-plugins using vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugUpdate|qall"
