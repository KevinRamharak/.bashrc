##
## ~/.bashrc
##

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## enable extensive pattern matching
shopt -s extglob

# Prevent LC_CTYPE error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Export stuff for '~/bin/google'
export browser_bin="chromium" # path to binary executable of your browser (chrom{e,ium}|firefox)
export default_action="search" # see 'google -h' for valid actions, invalid action falls back on search

# Disable PC speaker because it scares me and is annoying
xset b off

. "$HOME/.bash_aliases"

# cool function to combine cd and ls
function cl {
    if [[ $# -eq 0 ]]; then
        ls -l
    else
        cd "$1" && ls -l
    fi
}

## cool function to combine mkdir and cd
function cdir {
    if [[ $# -eq 0 ]]; then
        return
    else
        mkdir -p "$1" && cd "$1"
    fi
}

## cool function to up a directory for $N = 1 times
function .. {
    if [[ -z "$1" || "$1" != +([0-9]) ]]; then
        local n=1
    else
        local n="$1"
    fi

    while [[ "$n" -ne 0 ]]; do
        ((n--))
        cd ./..
    done
}

# color escape codes
# NOTE: Needs bash 4.0 (?) or higher
declare -A fg_color_map
declare -A bg_color_map
fg_color_map=(
    ['default']="\e[39m"
    ['black']="\e[30m"
    ['red']="\e[31m"
    ['green']="\e[32m"
    ['yellow']="\e[33m"
    ['blue']="\e[34m"
    ['magenta']="\e[35m"
    ['cyan']="\e[36m"
    ['light_grey']="\e[37m"
    ['dark_grey']="\e[90m"
    ['light_red']="\e[91m"
    ['light_green']="\e[92m"
    ['light_yellow']="\e[93m"
    ['light_blue']="\e[94m"
    ['light_magenta']="\e[95m"
    ['light_cyan']="\e[96m"
    ['white']="\e[97m"
)
bg_color_map=(
    ['default']='\e[49m'
    ['black']='\e[40m'
    ['red']='\e[41m'
    ['green']='\e[42m'
    ['yellow']='\e[43m'
    ['blue']='\e[44m'
    ['magenta']='\e[45m'
    ['cyan']='\e[46m'
    ['light_grey']='\e[47m'
    ['dark_grey']='\e[100m'
    ['light_red']='\e[101m'
    ['light_green']='\e[102m'
    ['light_yellow']='\e[103m'
    ['light_blue']='\e[104m'
    ['light_magenta']='\e[105m'
    ['light_cyan']='\e[106m'
    ['white']='\e[107m'
)

function set_fg_color {
    if [[ -z "$1" ]]; then
        local color='default'
    else
        local color="$1"
    fi
    echo -en "${fg_color_map[$color]}"
}

function set_bg_color {
    if [[ -z "$1" ]]; then
        local color='default'
    else
        local color="$1"
    fi
    echo -en "${bg_color_map[$color]}"
}

function set_color {
    case "$1" in
        -f)
            local type='fg'
            local color="$2"
            ;;
        -b)
            local type='bg'
            local color="$2"
            ;;
        *)
            local type='fg'
            local color="$1"
            ;;
    esac

    "set_${type}_color" "$color"
}

export fg_color
export bg_color

## bash prompt
# NOTE: this could be made more readable and compact by using "``" or "${}" syntax and the above defined functions
PS1="${fg_color_map[light_red]}[${fg_color_map[light_blue]}\u@\h${fg_color_map[light_red]}]${fg_color_map[light_red]}[${fg_color_map[light_green]}\w${fg_color_map[light_red]}] ${fg_color_map[dark_grey]}\$${fg_color_map[default]} "

## custom util functions
if [[ -f ~/bin/util.bash ]]; then
    source ~/bin/util.bash
fi
# log -> (['error',]  ...string) => write to stdout (stderr if first arg is 'error')
# include -> (file) => sources '${file}.bash' from current working directory or '~/bin/'
# require -> (file) => same as include but exits on failure
# NOTE: This is a really crude import system, only usefull to 
