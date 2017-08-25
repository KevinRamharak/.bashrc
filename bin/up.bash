## cool function to up a directory for $N = 1 times
..() {
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

export -f ..
export util_bash_up="true"
