##
## ~/.bashrc
##

# set PATH so it includes user's private bin directories
PATH="$PATH:$HOME/bin:$HOME/.local/bin"

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use extra globing features. See man bash, search extglob.
shopt -s extglob
# when a glob expands to nothing, make it an empty string instead of the literal characters.
shopt -s nullglob
# fix spelling errors for cd, only in interactive shell
shopt -s cdspell

## prevent LC_CTYPE error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## disable PC speaker because it scares me and is annoying
xset b off

## history
export HISTCONTROL="ignoreboth"
export HISTSIZE=1000
export HISTFILESIZE=5000
export HISTIGNORE="&:l[ails]:cls:clear:tree:cd:pwd:[bf]g:exit:* shutdown *:* reboot"

## editor
export EDITOR=vim

## use most as manual page reader
export PAGER="/usr/bin/most -s"

## source aliases
. "$HOME/.bash_aliases"

## custom util functions made available with 'import FUNCTION'
## see '~/bin/import.bash' for more info
## @NOTE: maybe use '$HOME' instead of '~'
if [[ -f ~/bin/import.bash ]]; then
    source ~/bin/import.bash

    # simple stuff that is usefull
    import cl
    import cdir
    import up # '..' function
    import extract

    # needed for prompt
    import color # @NOTE: this also imports 'version|log|array'
fi

## bash prompt
red=$(color light_red)
blue=$(color light_blue)
green=$(color light_green)
grey=$(color grey)
default=$(color default)
PS1="$red[$blue\u@\h$red]$red[$green\w$red] $grey\$$default "
