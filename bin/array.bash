#!/bin/bash

# USAGE:
# array ACTION ARGS...
#   create : array new NAME
#   get    : $(array get NAME KEY)
#   set    : array set NAME KEY VALUE
#

# import dependencies
import version
import log

# do a version check
version 4 3

function array {
    if [ $# -eq 0 ]; then return 1; fi; # no args
    case $1 in
        new)
            if [ $# -ne 2 ]; then return 1; fi;
            declare -g -A "$2"
        ;;
        get)
            if [ $# -ne 3 ]; then return 1; fi;
            declare -n local_array="$2";
            echo ${local_array[$3]};
        ;;
        set)
            if [ $# -ne 4 ]; then return 1; fi;
            declare -n local_array="$2";
            local_array[$3]="$4"
        ;;
        -h|--help)
            cat << _USAGE
array ACTION ARGS...
    ACTION:
        new    - array new NAME
        get    - array get NAME KEY
               - var=$(array get NAME KEY)
        set    : array set NAME KEY VALUE
_USAGE
        ;;
        *)
            log error "array: invalid syntax :: '$@'"
        ;;
    esac
    return 0;
}

export -f array
export util_bash_array="true"
