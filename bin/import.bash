#!/bin/bash

# USAGE:
# import FUNCTION
#     FUNCTION - function name to import
#              - can be:
#                full filepath
#                filepath as in ~/bin/$FILE_PATH

import() {
    if [ $# -eq 0 ]; then return 1; fi; # no args
    case $1 in
        -h|--help)
            cat << _USAGE
import FUNCTION
    FUNCTION - function name to import
               where FUNCTION is a:
                 full filepath OR
                 filepath as in ~/bin/$FILE_PATH
_USAGE
        ;;
        *)
        local file="$1.bash"
            if [[ ! -f "$file" && -f "~/bin/$file" ]]; then
                (echo "import: could not find '$file'" >&2 && exit 1)
            else
                source "$file" 2>/dev/null \
            ||  source "~/bin/$file" 2>/dev/null \
            ||  (echo "import: failed sourcing '$file'" >&2 && exit 1)
            fi
        ;;
    esac
    return 0;
}

export -f import
export util_bash_import="true"
