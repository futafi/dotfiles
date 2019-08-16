# both alias
alias unittest='python -m unittest'
alias dirs='dirs -l'
alias di='dirs -v'
alias pp='pushd'
## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

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

# os alias
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then

  alias sc="screen -xR"
  alias py="python3"
  alias python="python3"
  alias pip="pip3"
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
