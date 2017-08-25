#!/bin/bash

# log [error] MESSAGE...
#     error - if first string equals 'error' it will print to 'stderr'
#     MESSAGE - all other args will be concatenatted as one message

function log {
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

export -f log
export util_bash_log="true"
