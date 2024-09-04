#!/bin/sh

# Minimal /system/etc/mkshrc for Android using busybox sh or shell X
set +o nohup
cat /system/etc/logo
echo '
         Welcome, Enjoy this Recovery.
                     ;D
'

# HOME
export HOME=/sdcard/Fox
[ ! -d "$HOME" ] && mkdir -p "$HOME"
[ ! -d "$HOME" ] && export HOME=/sdcard

# shell
export HISTFILE=$HOME/.sh_history
export PS1='\s-\v \w > '

# Default TMPDIR
: ${TMPDIR:=/tmp}
export TMPDIR

InitRecovery() {
    alias dir="ls -all --color=auto"
    alias la='ls -a'
    alias ll='ls -a -l'
    alias lo='ls -a -l'
    alias l='find "$@" -maxdepth 1 -exec ls --color=auto -lh {} +'
    alias grep='grep -n --color=auto'
    alias fgrep='fgrep -n --color=auto'
    alias egrep='egrep -n --color=auto'
    alias python=python3
    alias python3=python_cli
    alias nano='nano --term xterm-256color "$@"'
    alias cls="clear"
    alias seek='find . -type d -path ./proc -prune -o -name "$@"'
    alias dirp="ls -all --color=auto -t | more"
    alias dirt="ls -all --color=auto -t"
    alias dirs="ls -all --color=auto -S"
    alias rd="rmdir"
    alias md="mkdir"
    alias del="rm -i"
    alias ren="mv -i"
    alias copy="cp -i"
    alias q="exit"
    alias diskfree="df -Ph"
    alias path="echo $PATH"
    alias mem="cat /proc/meminfo && free"
    alias ver="cat /proc/version"
    alias makediff="diff -u -d -w -B"
    alias makediff_recurse="diff -U3 -d -w -rN"

    if [ -f /sdcard/Fox/fox.shrc ]; then
       . /sdcard/Fox/fox.shrc
    elif [ -f /sdcard/Fox/fox.bashrc ]; then
       . /sdcard/Fox/fox.bashrc
    elif [ -f $HOME/.shrc ]; then
       . $HOME/.shrc
    elif [ -f /sdcard/.shrc ]; then
       . /sdcard/.shrc
    elif [ -f /FFiles/.shrc ]; then
       . /FFiles/.shrc
    elif [ -f /data/recovery/.shrc ]; then
       . /data/recovery/.shrc
    elif [ -f /sdcard1/.shrc ]; then
       . /sdcard1/.shrc
    fi

    [ -z "$HOME" ] && export HOME=/sdcard
    [ -z "$LINES" ] && export LINES=34
    [ -z "$COLUMNS" ] && export COLUMNS=63
    [ -z "$TERM" ] && export TERM=xterm-256color
    [ -z "$SHELL" ] && export SHELL=sh
    [ -z "$IS_ORANGEFOX_USER_TERM" ] && export IS_ORANGEFOX_USER_TERM=true

    red=$'\x1b[01;31m'
    green=$'\x1b[01;32m'
    blue=$'\x1b[01;34m'
    purple='\033[35m'
    NC=$'\x1b[0m'

    if [ "$(id -u)" -eq 0 ]; then
        PS1='#'
    else
        PS1='$'
    fi

    export PS4='[$(date +%s.%N)]'

    e=$?
    new_ps1=''
    [ $e -ne 0 ] && new_ps1="${red}${e}${NC}|"

    new_ps1+="${green}[ ${HOSTNAME} | $(whoami) ]${NC} : ${blue}\${PWD}${NC}"
    if [ -n "$VIRTUAL_ENV" ]; then
        new_ps1+="${purple} (venv:$(basename $VIRTUAL_ENV))${NC}"
    fi

    new_ps1+=" 
$PS1> "
    PS1="$new_ps1"
    return $e

    export TERM=pcansi
    alias nano='nano --term pcansi "$@"'
}

InitRecovery

if [ -f /sbin/from_fox_sd.sh ]; then
   source /sbin/from_fox_sd.sh
fi
