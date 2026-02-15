# both alias
alias gshell="gcloud alpha interactive"
alias manja="LANG=ja man"
alias manen="LANG=C man"
alias ctagsr="ctags --tag-relative --recurse --sort=yes  --append=no"
alias v="vim"
alias vi="vim"
alias please='sudo $(fc -ln -1)'
alias diary="vim $HOME/Dropbox/memo/diary.md"
alias dev="~/.claude/scripts/tmux-dev-session.sh"
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
function pdfcropm ()
{
  local tempfile=$(mktemp)
  pdfcrop "$1" "$tempfile"
  mv "$tempfile" "$1"
  echo cropped $1
}
continue-claude-at() {
    local time_arg="$1"
    local pane_number="$2"
    
    if [[ -z "$time_arg" ]]; then
        echo "Usage: continue-claude-at <time> [pane_number]"
        return 1
    fi
    
    # pane番号が指定されていない場合
    if [[ -z "$pane_number" ]]; then
        echo "Select pane number:"
        tmux display-panes -d 1500
        echo -n "Enter pane number: "
        read pane_number
    fi
    
    # atコマンドで指定時刻にtmuxコマンドを実行
    echo "tmux send-keys -t $pane_number 'continue'&&tmux send-keys -t $pane_number Enter" | at "$time_arg"
    
    echo "Scheduled 'continue' for pane $pane_number at $time_arg"
}

alias unittest='python -m unittest'
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
alias po="popd"
alias di="dirs -v"
alias dirs='dirs'
alias ..="cd ../."
alias ...="cd ../../."
alias ....="cd ../../../."

# fzf
alias f='fzf'

# os alias
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then

  alias sc="screen -xR"
  alias py="python3"
  alias apt="sudo apt"
  alias swapclear="sudo swapoff -a && sudo swapon -a"
  alias exp="caja ."
  # alias docker="sudo docker"
  alias docker-compose="sudo docker-compose"
  alias systemctl="sudo systemctl"
  
  # fzf
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
  ff(){
    local dir;
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && pushd "$dir"
  }
  alias fdf='cd $(dirname $(fzf))'
  # tm function with select functionality
  tm() {
	case "$1" in
	    "ls" | "list")
		  tmux list-sessions
		  ;;
	    "sel" | "select")
		  local sessions=($(tmux list-sessions -F "#{session_name}" 2>/dev/null))
		  if [ ${#sessions[@]} -eq 0 ]; then
			echo "No active sessions"
			return 1
		  fi
		  
		  echo "Select a session:"
		  for i in "${!sessions[@]}"; do
			echo "$((i+1))) ${sessions[i]}"
		  done
		  
		  read -p "Enter number (1-${#sessions[@]}): " choice
		  if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#sessions[@]} ]; then
			local selected_session="${sessions[$((choice-1))]}"
			echo "Attaching to: $selected_session"
			tmux attach -t "$selected_session"
		  else
			echo "Invalid choice"
			return 1
		  fi
		  ;;
	    "kill")
		  if [ -n "$2" ]; then
			tmux kill-session -t "$2"
			echo "Killed session: $2"
		  else
			echo "Usage: tm kill SESSION_NAME"
		  fi
		  ;;
	    "help")
		  echo "Usage:"
		  echo "  tm               - attach to existing or create new session"
		  echo "  tm NAME          - attach to or create named session"
		  echo "  tm ls            - list sessions"
		  echo "  tm sel/select    - select session interactively"
		  echo "  tm kill NAME     - kill named session"
		  echo "  tm help          - show this help"
		  ;;
	    "")
		  tmux attach 2>/dev/null || tmux new
		  ;;
	    *)
		  tmux attach -t "$1" 2>/dev/null || tmux new -s "$1"
		  ;;
	esac
  }

  # bash completion for tm
  _tm_completion() {
	local cur="${COMP_WORDS[COMP_CWORD]}"
	local prev="${COMP_WORDS[COMP_CWORD-1]}"
	
	if [ $COMP_CWORD -eq 1 ]; then
	    # 第一引数の補完：コマンド + セッション名
	    local commands="ls list sel select kill help"
	    local sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
	    COMPREPLY=($(compgen -W "$commands $sessions" -- "$cur"))
	elif [ $COMP_CWORD -eq 2 ] && [ "$prev" = "kill" ]; then
	    # tm kill の後はセッション名のみ
	    local sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
	    COMPREPLY=($(compgen -W "$sessions" -- "$cur"))
	fi
  }

  complete -F _tm_completion tm
  eval "$(gh completion -s bash)"
elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then
  # alias python='winpty python.exe'
  alias py='winpty py'
  alias so='source .venv/Scripts/activate'
  alias exp='explorer .'
  alias dlatexmk="docker run --rm -v /$PWD:/workdir latex latexmk"
  alias dlatexmkit="docker run --rm -it -v /$PWD:/workdir latex latexmk"
  alias fzf="winpty fzf"
  alias gnuplot="winpty gnuplot"
  alias clang="clang --target=x86_64--target=x86_64-w64-mingw"
else
  echo "platform ($(uname -a)) isn't Linux or Mingw."
fi
