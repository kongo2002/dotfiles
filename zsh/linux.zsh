# linux specific settings

if [[ "$(uname -s)" != "Linux" ]]; then
    return 0
fi

alias ls='ls -h --color=auto'
alias ll='ls -lh --color=auto'
alias l='ls -lha --color=auto'
