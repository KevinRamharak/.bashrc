#!/bin/bash

#####################################################
#  @project : nginx-gen                             #
#  @author  : Kevin Ramaharak <kevin@ramharak.nl>   #
#####################################################
# Set root directory for imports                    #
# root_dir="/path/to/custom/dir"                    #
# Set log mode                                      #
# 0 = off                                           #
# 1 = stderr only                                   #
# 2 = stdout only                                   #
# 3 = all                                           #
# log_mode="3"                                      #
### Exposes: ########################################
# function log                                      #
#                                                   #
# @description:                                     #
# Print arguments to stdout                         #
# If first argument is 'error', print remaining     #
# arguments to stderr                               #
#                                                   #
# @arguments:                                       #
# string        :  $1   > 'error' || string         #
# Array<string> :  $@:1 > optional if $1 != 'error' #
# # # # # # # # # # # # # # # # # # # # # # # # # # #
# function include                                  #
#                                                   #
# @description:                                     #
# Tries to source every argument as a bash script   #
# These should be either in $PATH, $root_dir or     #
# the current working directory                     #
#                                                   #
# @arguments:                                       #
# Array<string> :  $@                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # #
# function require                                  #
#                                                   #
# @description:                                     #
# same as 'include' but exits on failure            #
#                                                   #
# @arguments:                                       #
# Array<string> :  $@                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # #

# need at least $root_dir and $log_mode to be valid
if [[ -z "$root_dir" ]]; then
    export root_dir="/home/kevin/bin/"
fi

if [[ -z "$log_mode" ]]; then
    export log_mode=3
fi

if [[ ! -d "$root_dir" ]]; then
    echo "'$root_dir' is not a directory" >&2
    exit 1
fi

if [[  "$log_mode" != [0-3] ]]; then
    echo "\$log_mode should be a number between 0 and 3, instead got: $log_mode" >&2
    exit 1
fi

function log {
    if [[ "$#" -eq 0 ]]; then
        return 0;
    fi

    case $1 in
        error)
            if [[ "$log_mode" -eq 1 || "$log_mode" -eq 3 ]]; then
                echo -e "ERROR: ${@:2}" >&2
            fi
            ;;
        *)
            if [[ "$log_mode" -gt 2 ]]; then
                echo -e "$@"
            fi
            ;;
    esac
}

function include {
    if [[ -z "$1" ]]; then
        log error "include takes 1 argument"
        return 1
    fi

    if [[ ! -f "$1.bash" && ! -f "$root_dir/$1.bash" ]]; then
        log error "file '$1.bash' does not exist"
        return 1
    else
        source "$1.bash" 2>/dev/null \
        || source "$root_dir/$1.bash" 2>/dev/null \
        || (log error "failed importing file: '$1.bash'" && return 1)
    fi;
}

function require {
    if [[ -z $1 ]]; then
        log error "require takes 1 argument"
        return 1;
    fi
    output=$(include "$1" 2>&1)
    if [[ $? -ne 0 ]]; then
        log error "$output"
        log error "failed to require file: '$1.bash'"
        exit 1
    fi
}

export -f log
export -f include
export -f require
