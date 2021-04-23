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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[01;34m\]\W\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\W\$ '
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
    (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias la='ls -a'
    alias ll='ls -al'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep -n --color=auto'
    alias fgrep='fgrep -n --color=auto'
    alias egrep='egrep -n --color=auto'
else
    alias ls='ls -FHG'
    alias la='ls -a'
    alias ll='ls -al'

    alias grep='grep -n --color'
    alias fgrep='fgrep -n --color'
    alias egrep='egrep -n --color'
fi

# colored GCC warnings and errors

alias src='cd /mnt/c/Users/emers/src'
alias vdir='ls -hF --color=tty --format=long'
alias reload='source ~/.bash_profile'
alias forgot='vim ~/.never_forget.txt'
alias weather='curl -X GET http://wttr.in/'
alias git3='git add -A && git ci && git push'
alias git2='git add -A && git ci'

# When running gdb or python, run quietly to hide liscensing information
alias gdb='gdb -q'
alias python3='python3 -q'

# python aliases
alias activate='source env/bin/activate'

# Minecraft Server aliases
alias start='java -Xmx4096M -Xms4096M -jar spigot.jar nogui'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# Set file and directory colors
LS_COLORS="ow=01;33" && export LS_COLORS #WSL dir colors

# set defualt editor
export EDITOR='vim'
export VISUAK='vim'

parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' ; }
git_unstaged() { 
    UNSTAGED=$(git ls-files -m 2> /dev/null | wc -l)
    UNTRACKED=$(git ls-files --others --exclude-standard 2> /dev/null | wc -l)
    if [[ $UNSTAGED -ne 0 && $UNTRACKED -ne 0 ]] 
    then
        UNSTAGED=$((UNSTAGED + UNTRACKED))
        echo "$UNSTAGED"
    elif [[ $UNSTAGED -ne 0 ]]
    then
        echo "$UNSTAGED"
    elif [[ $UNTRACKED -ne 0 ]]
    then
        echo "$UNTRACKED"
    fi
} 
    
git_staged() {
    STAGED=$(git diff --name-only --cached 2> /dev/null | wc -l)
    if [[ $STAGED -ne 0 ]] 
    then
        echo "$STAGED"
    fi
}
    
git_ahead() {
    PUSH=$(git status 2> /dev/null | grep 'Your branch is ahead of' | grep -Eo '[0-9]')
    if [[ -z "$PUSH" ]] 
    then
        echo "$PUSH"
    fi
}

export PS1="\[\033[01;34m\]\W\[\033[30m\]\$(parse_git_branch)\[\033[00m\]$ "

# communt the above PS1 and uncomment the following PS1 for some git status 
# updates on the terminal prompt, note: for large repositories, this will
# case massive load times
# export PS1="\[\033[01;34m\]\W\[\033[30m\]\$(parse_git_branch)\[\033[31m\]\$(git_unstaged)\[\033[32m\]\$(git_staged)\[\033[34m\]\$(git_ahead)\[\033[00m\]$ "

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export DISPLAY=:0
