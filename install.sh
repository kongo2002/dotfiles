#!/bin/sh

# simple script to initially install the config files

REPO=$(pwd)

FILES="Xdefaults \
conkyrc \
ctags \
gvimrc \
ncmpcpp \
plugins \
screenrc \
vim \
vimperatorrc \
vimrc \
zsh
zshrc"

pushd "$HOME"

for f in $FILES; do
    if [ ! -e "$HOME/.$f" ]; then
        echo "Creating symlink from .$f to $REPO/$f"
	ln -s "$REPO/$f" ".$f"
    else
        echo ".$f already exists"
    fi
done

popd

#vim: set et sw=4 sts=4:
