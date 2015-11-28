#!/bin/bash --

# get directory of this install-script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# check that git and vim are installed
command -v git >/dev/null 2>&1 || \
  { echo >&2 "I require git but it's not installed. Aborting."; exit 1; }
command -v vim >/dev/null 2>&1 || \
  { echo >&2 "I require vim but it's not installed. Aborting."; exit 1; }

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

# symlink non-vim-files
ln -sfv "$DOTFILES_DIR/bash/.bash_aliases"     "$HOME"
ln -sfv "$DOTFILES_DIR/bash/.bash_functions"   "$HOME"
ln -sfv "$DOTFILES_DIR/bash/.bash_logout"      "$HOME"
ln -sfv "$DOTFILES_DIR/bash/.bashrc"           "$HOME"
ln -sfv "$DOTFILES_DIR/bash/.profile"          "$HOME"
ln -sfv "$DOTFILES_DIR/coreutils/"             "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/git/"                   "$HOME"/.config/
ln -sfv "$DOTFILES_DIR/misc_runcom/.eclimrc" ~
ln -sfv "$DOTFILES_DIR/misc_runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/readline/"              "$HOME"/.config/

# make sure that other bash configuration files do not exist such that .profile
# is actually sourced for login-shells
rm -f "$HOME"/.bash_login
rm -f "$HOME"/.bash_profile

# install vim-plugins using vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugUpdate|qall"

# create vim-directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/{backupfiles,undofiles,swapfiles}

# symlink vim-files
ln -sfv "$DOTFILES_DIR/vim/.vimrc" ~
ln -sfv "$DOTFILES_DIR/vim/dictionaries/" ~/.vim/
ln -sfv "$DOTFILES_DIR/vim/snippets/" ~/.vim/

