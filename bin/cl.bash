#!/bin/bash

# cool function to combine cd and ls
function cl {
    if [[ $# -eq 0 ]]; then
        ls -l
    else
        cd "$1" && ls -l
    fi
}

export -f cl
export util_bash_cl="true"
