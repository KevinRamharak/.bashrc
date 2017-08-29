## explicitly state alias expansion
shopt -s expand_aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### Aliases

## alias `cls` to `clear`
alias cls='clear'

## some more ls aliases
alias li='ls -alF'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

## since i got used to 'vscode' instead of 'code'
alias vscode='code'

## alias 'tree' to ignore 'vendor|node_modules'
alias tree='tree -I "vendor|node_modules"'
