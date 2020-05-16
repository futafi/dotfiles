# both alias
alias ctags="ctags --tag-relative --recurse --sort=yes  --append=no"
alias v="vim"
alias vi="vim"
alias please='sudo $(fc -ln -1)'
alias diary="vim $HOME/Dropbox/memo/diary.md"
function md ()
{
    mkdir -p -- "$1"
    cd -P -- "$1"
}
function wget_gdrive ()
{
  local FILE_ID="$1"
  curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
  local CONFIRM="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"  
  curl -LOJb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}"
}
alias unittest='python -m unittest'
alias dirs='dirs -v'
alias open='xdg-open'
## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
## colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
if [ -f /usr/share/fzf/completion.bash ]; then
  source /usr/share/fzf/completion.bash
  source /usr/share/fzf/key-bindings.bash
fi

# pushd popd and cd aliases
alias pd="pushd"
alias pu="pushd"
alias po="popd"
alias di="dirs"
alias ..="cd ../."
alias ...="cd ../../."
alias ....="cd ../../../."

# os alias
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then

  alias sc="screen -xR"
  alias py="python3"
  alias python="python3"
  alias apt="sudo apt"
  alias swapclear="sudo swapoff -a && sudo swapon -a"
  alias exp="caja ."
  alias docker="sudo docker"
  alias docker-compose="sudo docker-compose"
  alias systemctl="sudo systemctl"
  eval "$(hub alias -s)"

  fbr() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  }
  fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
                    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
  }
  fp(){
    local dir;
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && pushd "$dir"
  }
  alias fdf='cd $(dirname $(fzf))'
  alias f='fzf'
elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then
  # alias python='winpty python.exe'
  alias py='winpty py'
  alias so='source .venv/Scripts/activate'
  alias exp='explorer .'
  alias dlatexmk="docker run --rm -v /$PWD:/workdir latex latexmk"
  alias dlatexmkit="docker run --rm -it -v /$PWD:/workdir latex latexmk"
else
  echo "platform ($(uname -a)) isn't Linux or Mingw."
fi
