#
# sample system-wide bashrc file for OrangeFox
#

# shell
export PS1='\s-\v \w > '
export TERM='xterm-256color'

# aliases
alias cls="clear"
alias seek='find . -name "$@"'
alias dir="ls -all --color=auto"
alias rd="rmdir"
alias md="mkdir"
alias del="rm -i"
alias ren="mv -i"
alias copy="cp -i"
alias diskfree="df -Ph"
alias nano='nano --term xterm-256color "$@"'

# go to a neutral location
cd /tmp
echo "Welcome, Enjoy this Recovery. =D"
#
