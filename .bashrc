# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GC
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='exa'
alias chrome='google-chrome'
alias short="PROMPT_DIRTRIM=1"
#alias vi='$HOME/nvim.appimage'
alias vi='nvim'
# github
alias gi='git init'
alias gic='git commit -m "Initial Commit"'
alias glg='git log --oneline '
alias gb='git branch'
alias gst='git status'
alias gsw='git switch '
alias gc='git commit '
alias gcm='git commit -m '
alias ga='git add ' # git add
alias gaa='git add .' # git add all
alias gd='git restore *' #Discard local changes
alias ghtoken='cat $HDD/github-token.txt | xclip -selection clipboard'



# system aliases
# Install new package
alias i='sudo apt update && sudo apt upgrade && sudo apt install '
# Remove package only
alias r='function remove() { sudo apt remove "$1" && sudo apt clean && sudo apt autoremove; }; remove'
# Remove package + configs  
alias rp='function remove_purge() { sudo apt purge "$1" && sudo apt clean && sudo apt autoremove; }; remove_purge'
# Search for a file in system
alias qs='apt-file search '
# Search for a file or package in global repo
alias q='apt search '
# Extract file in current working direcotry
alias x='tar -xvzf'
# Extract to some working directory
alias xt='function extract_to() { tar -xvzf "$1" -C "$2"; }; extract_to'
# Make files gcc c/c++
alias m='sudo make clean install'
# Apply new changes to config.def.h in Suckless.org softwares { sa => suckless apply }
alias sa='sudo rm config.h && m'
# Init system
alias systemInit='function init() {
  PROMPT_DIRTRIM=1; 
  pgrep xcompmgr || xcompmgr -cf &
};
init'

# My global envvariable "env variables"

export XDG_CONFIG_HOME=$HOME'/.config'
export HDD='/media/hdd'
export WEB_DEV=$HDD'/Development/webDev'
export WEB_GIT=$WEB_DEV'/a-projects/1.public-github'
export MOB_DEV=$HDD'/Development/mobileDev'
export ODC=$WEB_DEV'/ODC'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

#Global invocation
#short
systemInit

alias luamake=/home/shelf/lua-language-server/3rd/luamake/luamake
