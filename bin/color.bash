#!/bin/bash

# USAGE:
# color [TYPE = 'foreground'] [COLOR = 'default']
#   TYPE:
#       fg, foreground, text - set foreground (text) color
#       bg, background       - set background color
#   COLOR:
#       default
#       black
#       white
#       : NOTE : colors beneath can be prefixed with 'light_' for lighter color
#       grey
#       red
#       green
#       yellow
#       blue
#       magenta
#       cyan
#

# import dependencies
import version
import log
import array

# do a version check
version 4

# initialise arrays
array new foreground_color_map
array new background_color_map

# foreground (text)
array set foreground_color_map default "\e[39m"
array set foreground_color_map black "\e[30m"
array set foreground_color_map white "\e[97m"
array set foreground_color_map grey "\e[90m"
array set foreground_color_map red "\e[31m"
array set foreground_color_map green "\e[32m"
array set foreground_color_map yellow "\e[33m"
array set foreground_color_map blue "\e[34m"
array set foreground_color_map magenta "\e[35m"
array set foreground_color_map cyan "\e[36m"
array set foreground_color_map light_grey "\e[37m"
array set foreground_color_map light_red "\e[91m"
array set foreground_color_map light_green "\e[92m"
array set foreground_color_map light_yellow "\e[93m"
array set foreground_color_map light_blue "\e[94m"
array set foreground_color_map light_magenta "\e[95m"
array set foreground_color_map light_cyan "\e[96m"

array set background_color_map default "\e[49m"
array set background_color_map black "\e[40m"
array set background_color_map white "\e[107m"
array set background_color_map grey "\e[100m"
array set background_color_map red "\e[41m"
array set background_color_map green "\e[42m"
array set background_color_map yellow "\e[43m"
array set background_color_map blue "\e[44m"
array set background_color_map magenta "\e[45m"
array set background_color_map cyan "\e[46m"
array set background_color_map light_grey "\e[47m"
array set background_color_map light_red "\e[101m"
array set background_color_map light_green "\e[102m"
array set background_color_map light_yellow "\e[103m"
array set background_color_map light_blue "\e[104m"
array set background_color_map light_magenta "\e[105m"
array set background_color_map light_cyan "\e[106m"

color() {
    if [ $# -eq 0 ]; then return 1; fi; # no args

    local echoString=''
    local color=''

    if [ $# -eq 1 ]; then color="$1"; fi
    if [ $# -eq 2 ]; then color="$2"; fi

    case $1 in
        bg|background)
            echoString=$(array get background_color_map $color)
        ;;
        -h|--help)
            cat << _USAGE
color [TYPE = 'foreground'] [COLOR = 'default']
  TYPE:
      fg, foreground, text - set foreground (text) color
      bg, background       - set background color
  COLOR:
      default
      black
      white
      : NOTE : colors beneath can be prefixed with 'light_' for lighter color
      grey
      red
      green
      yellow
      blue
      magenta
      cyan
_USAGE
        ;;
        fg|foreground|text)
        ;& # fall trough
        *)
            echoString=$(array get foreground_color_map $color)
        ;;
    esac

    if [ -z "$echoString" ]; then
        log error "color: '$color' is not a valid color"
    else
        echo -en "$echoString"
    fi

    return 0;
}

export -f color
export util_bash_color="true"
