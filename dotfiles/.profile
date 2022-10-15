# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
else
    unset PYENV_ROOT
fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export MANPATH=/usr/local/man/ja:/usr/local/share/man/ja:/usr/share/man/ja:/usr/X11R6/man/ja:/usr/share/man

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "usr/local/bin" ] ; then
    PATH="/usr/local/bin:$PATH"
fi

if [ -d "/opt/rocm" ]; then
    export HSA_OVERRIDE_GFX_VERSION=9.0.0
    export LD_LIBRARY_PATH=/opt/rocm/lib
    export PATH="$PATH:/opt/rocm/bin:/opt/rocm/opencl/bin"
fi

if type "wsld" > /dev/null 2>&1; then
  export DISPLAY=:0
  if ! pgrep wsld >> /dev/null 2>&1 ; then
	nohup sudo $HOME/bin/wsld > /dev/null < /dev/null 2>&1 &
	disown

	# sleep until $DISPLAY is up
	while ! xset q > /dev/null 2>&1 ; do
	    sleep 0.3
	done
  fi
fi

