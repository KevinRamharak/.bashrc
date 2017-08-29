##
## ~/.bashrc
##

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## enable extensive pattern matching
shopt -s extglob

## prevent LC_CTYPE error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Disable PC speaker because it scares me and is annoying
xset b off

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
