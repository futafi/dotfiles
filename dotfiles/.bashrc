export PAGER=less
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm|xterm-color|*-256color) color_prompt=yes;;
xterm | xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  if [[ ${EUID} == 0 ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;

esac

# go path
export GOPATH=$HOME/go
if [ -d "$GOPATH" ]; then
  export PATH=$GOPATH/bin:$PATH
else
  unset GOPATH
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# local bashrc
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -r $HOME/.byobu/prompt ] && . $HOME/.byobu/prompt #byobu-prompt#
[ -r $HOME/.virtualenv-auto-activate.sh ] && source $HOME/.virtualenv-auto-activate.sh

# os settings
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then

  if type "latex" >/dev/null 2>&1; then
    texlive_year=$(latex --version | sed -r "s/\r|\n|.|TeX Live (2[0-9]{3})/\1/g")
    export PATH=/usr/local/texlive/$texlive_year/bin/x86_64-linux:$PATH
    export MANPATH=/usr/local/texlive/$texlive_year/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/$texlive_year/texmf-dist/doc/info:$INFOPATH
  fi

elif [ "$(expr substr $(uname -s) 1 5)" == 'MINGW' ]; then
  # MINGW
  chcp.com 65001
  export CLOUDSDK_PYTHON=$HOME/AppData/Local/Google/Cloud\ SDK/google-cloud-sdk/platform/bundledpython/python.exe
else
  echo "platform ($(uname -a)) isn't Linux or Mingw."
fi

# WSL
if [ -e "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
  WSLHOST=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
  alias gocopy=$HOME/bin/gocopy.exe
  alias gopaste=$HOME/bin/gopaste.exe
  alias exp="explorer.exe ."
  # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
  #dbus_status=$(service dbus status)
  #if [[ $dbus_status = *"is not running"* ]]; then
  #  sudo service dbus --full-restart
  #fi
  #[ -z "$PS1" ] && return
  PS1="\[\e[1;33m\]($WSL_DISTRO_NAME) \[\e[0m\]$PS1"
fi

export HTTP_HOME=https://www.bing.com/
export GID=$(id -g)
# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/bin/google-cloud-sdk/path.bash.inc' ]; then . $HOME'/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/bin/google-cloud-sdk/completion.bash.inc' ]; then . $HOME'/bin/google-cloud-sdk/completion.bash.inc'; fi
