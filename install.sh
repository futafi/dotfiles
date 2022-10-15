#!/bin/bash

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
DOT_DIR="$SCRIPT_DIR/dotfiles"
DOTFILES="$(find $DOT_DIR -maxdepth 1 -mindepth 1 -printf "%f\n")"

for f in $DOTFILES;
do
  ln -snf $DOT_DIR/"$f" $HOME/"$f"
  echo "installed $f"
done

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if type "apt" > /dev/null 2>&1; then
    INSTALLCMD="sudo apt install -y "
    sudo apt update
  elif type "pacman" >/dev/null 2>&1; then
    if !(type "paru" >/dev/null 2>&1); then
	sudo pacman -S --needed --noconfirm base-devel git
	git clone https://aur.archlinux.org/paru.git
	sh -c "cd paru && makepkg -rsi"
    fi
    INSTALLCMD="sudo paru -S --noconfirm "
  fi
  $INSTALLCMD vim htop tig git curl wget screen bash-completion man tree ncdu ranger
  # TODO install code, github-cli
  # ttf-cica
fi

vim +PlugInstall +qall

source $HOME/.bashrc
