#!/bin/bash

# log [error] MESSAGE...
#     error - if first string equals 'error' it will print to 'stderr'
#     MESSAGE - all other args will be concatenatted as one message

log() {
    if [[ "$#" -eq 0 ]]; then return 0; fi
    case $1 in
        -h|--help)
            cat << _USAGE
log [error] MESSAGE...
    error - if first string equals 'error' it will print to 'stderr'
    MESSAGE - all other args will be concatenatted as one message
_USAGE
        ;;
        error)
            echo -e "ERROR: ${@:2}" >&2
            ;;
        *)
            echo -e "$@"
            ;;
    esac
}

export -f log
export util_bash_log="true"
