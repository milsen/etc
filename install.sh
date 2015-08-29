#!/bin/bash --

# get directory of this install-script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && \
  git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# create vim-directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/{backupfiles,undofiles,swapfiles}

# symlink all files
ln -sfv "$DOTFILES_DIR/bash/.bash_aliases" ~
ln -sfv "$DOTFILES_DIR/bash/.bash_functions" ~
ln -sfv "$DOTFILES_DIR/bash/.bash_logout" ~
ln -sfv "$DOTFILES_DIR/bash/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/bash/.bashrc" ~
ln -sfv "$DOTFILES_DIR/bash/.dircolors" ~
ln -sfv "$DOTFILES_DIR/bash/.inputrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore" ~
ln -sfv "$DOTFILES_DIR/misc_runcom/.eclimrc" ~
ln -sfv "$DOTFILES_DIR/misc_runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/vim/.vimrc" ~
ln -sfv "$DOTFILES_DIR/vim/dictionaries/" ~/.vim/
ln -sfv "$DOTFILES_DIR/vim/snippets/" ~/.vim/

# install vim-plugins using vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +"PlugUpdate|qall"

