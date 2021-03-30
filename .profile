# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

if [ -d "/opt/rocm" ] ; then
	export ROCM_PATH=/opt/rocm
	export HCC_HOME=/opt/rocm/hcc
	export HIP_PATH=/opt/rocm/hip
	export PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH

	export HCC_AMDGPU_TARGET=gfx803
	export __HIP_PLATFORM_HCC__

	export ROCM_HOME=/opt/rocm
	export CUPY_INSTALL_USE_HIP=1
	export PATH=$ROCM_HOME/bin:$PATH
fi

_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true

