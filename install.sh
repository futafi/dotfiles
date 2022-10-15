#!/bin/bash

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
DOT_DIR="$SCRIPT_DIR/dotfiles"
DOTFILES="$(find $DOT_DIR -maxdepth 1 -mindepth 1 -printf "%f\n")"
for f in $DOTFILES;
do
  ln -snf $DOT_DIR/"$f" $HOME/"$f"
  echo "installed $f"
done
