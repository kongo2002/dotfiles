# macOS specific settings

if [[ "$(uname -s)" != "Darwin" ]]; then
    return 0
fi

alias ls='ls -hG'
alias ll='ls -lhG'
alias l='ls -lhaG'
