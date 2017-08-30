#!/bin/bash

# USAGE:
# extract ARCHIVE
#   ARCHIVE:
#       *.tar.bz2
#       *.tar.gz
#       *.bz2
#       *.rar
#       *.gz
#       *.tar
#       *.tbz2
#       *.tgz
#       *.zip
#       *.Z
#
# @NOTE: plucked it from the internet somewhere, so i don't take any credit

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1        ;;
            *.tar.gz)   tar xzf $1        ;;
            *.bz2)      bunzip2 $1        ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1        ;;
            *.tar)      tar xf $1        ;;
            *.tbz2)     tar xjf $1        ;;
            *.tgz)      tar xzf $1        ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1    ;;
            *)
                log error "'$1' cannot be extracted via extract()"
                return 1
            ;;
        esac
    else
        if [[ "$1" == "-h" || "$1" == "--help" ]]; then
            cat << _USAGE
extract ARCHIVE
  ARCHIVE:
      *.tar.bz2
      *.tar.gz
      *.bz2
      *.rar
      *.gz
      *.tar
      *.tbz2
      *.tgz
      *.zip
      *.Z
_USAGE
        else
            log error "'$1' is not a valid file"
            return 1
        fi
    fi
    return 0
}

export -f extract
export util_bash_extract="true"
