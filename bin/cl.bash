#!/bin/bash

# cool function to combine cd and ls
cl() {
    if [[ $# -ne 0 ]]; then
        cd "$1"
    fi
    ls -l
}

export -f cl
export util_bash_cl="true"
