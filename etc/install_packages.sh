#!/bin/bash
  
pip install -r requirements.txt
go get golang.org/x/tools/cmd/gopls

if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
apt install -y \
  git \
  tig \
  screen \
  tmux \
  byobu \
  ssh  \
  clang \
  gcc \
  go
elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then                                                                                           
   pacman -S \
   mingw-w64-x86_64-clang \
   mingw-w64-x86_64-clang-tools-extra
else
  echo "platform ($(uname -a)) isn't Linux or Mingw."
fi
