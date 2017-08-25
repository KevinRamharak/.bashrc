#!/bin/bash

# cool function to combine cd and ls
cdir() {
    if [[ $# -eq 0 ]]; then return 1; fi # no args
    mkdir -p "$1" && cd "$1"
}

export -f cdir
export util_bash_cdir="true"
