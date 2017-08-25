#!/bin/bash

# version MAIN [SUB]
#     MAIN - main version number
#     SUB  - sub version number
# example:
#     version 4 4  => exits if bash version is lower than 4.4
#

# import dependecies
import log

version() {
    if [[ $# -eq 0 ]] then return 1; fi # no args
    local regex="^"
    case $1 in
        -h|--help)
            cat << _USAGE
version MAIN [SUB]
    MAIN - main version number
    SUB  - sub version number

example:
    version 4 4  => exits if bash version is lower than 4.4
_USAGE
        ;;
        *)
            if [[ $# -eq 1 ]]; then
                regex="$regex$1.*"
            else
                if [[ "$2" -gt 9 ]]; then
                    regex="$regex$1.[${2::1}-9][${2:1}-9].*"
                else
                    regex="$regex$1.[$2-9].*"
                fi
            fi
        ;;
    esac
    echo "$BASH_VERSION" | grep -q -e "$regex"
    if [[ $? -ne 0 ]]; then
        log error "this script requires bash version $1.$2 or higher"
        exit 1;
    fi;
}

export -f version
export util_bash_version="true"
