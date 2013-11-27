#!/bin/sh

# simple script to initially install the config files

REPO=$(pwd)
FILES=$(ls | grep -v "install.sh")

pushd "$HOME"

for f in $FILES; do
    if [ ! -e "$HOME/.$f" ]; then
        echo "Creating symlink from .$f to $REPO/$f"
        ln -s "$REPO/$f" ".$f"
    else
        if [ -h "$HOME/.$f" ]; then
            echo "'.$f' already exists"
        else
            echo "'.$f' is a regular file/folder. Remove it first!"
        fi
    fi
done

popd

#vim: set et sw=4 sts=4:
