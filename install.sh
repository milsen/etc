#!/bin/bash --

# get directory of this install-script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# make sure that git, curl and vim are installed
command -v git >/dev/null 2>&1 || \
  { sudo apt-get install git; }
command -v curl >/dev/null 2>&1 || \
  { sudo apt-get install curl; }
command -v vim >/dev/null 2>&1 || \
  { sudo apt-get install vim-gtk; }

# ask user to update dotfiles itself first
echo "Do you want to update the dotfiles first (pull origin master)?"
while true
do
  read -p "y/n? " answer
  case "$answer" in
    Yes|yes|Y|y|"")
      [ -d "$DOTFILES_DIR/.git" ] && \
        git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" \
        pull origin master
      break;;
    No|no|N|n)
      break;;
    *)
      ;;
  esac
done

# create config-directories
mkdir "$HOME"/.config
mkdir "$HOME"/.config/bash

# symlink non-vim-files
ln -sfv "$DOTFILES_DIR/shell/bash/.bash_aliases"     "$HOME"
ln -sfv "$DOTFILES_DIR/shell/bash/bash_functions.sh" "$HOME"/.config/bash
ln -sfv "$DOTFILES_DIR/shell/bash/.bash_logout"      "$HOME"
ln -sfv "$DOTFILES_DIR/shell/bash/.bashrc"           "$HOME"
ln -sfv "$DOTFILES_DIR/shell/.profile"               "$HOME"
ln -sfv "$DOTFILES_DIR/coreutils/"                   "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/git/"                         "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/misc_runcom/.eclimrc"         "$HOME"
ln -sfv "$DOTFILES_DIR/misc_runcom/.latexmkrc"       "$HOME"
ln -sfv "$DOTFILES_DIR/readline/"                    "$HOME"/.config/

# make sure that other bash configuration files do not exist such that .profile
# is actually sourced for login-shells
rm -f "$HOME"/.bash_login
rm -f "$HOME"/.bash_profile

# symlink vim-files
ln -sfv "$DOTFILES_DIR/.vim/"                      "$HOME"

# create vim-directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.cache/vim/{backup,undo,swap}

# install vim-plugins using vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugUpdate|qall"
