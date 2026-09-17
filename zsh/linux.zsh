# linux specific settings

if [[ "$(uname -s)" != "Linux" ]]; then
    return 0
fi

if [[ -x $(which eza) ]]; then
    alias ls='eza'
    alias ll='eza -l --git --no-permissions --octal-permissions'
    alias l='eza -la --git --no-permissions --octal-permissions'
else
    alias ls='ls -h --color=auto'
    alias ll='ls -lh --color=auto'
    alias l='ls -lha --color=auto'
fi

export PLAYWRIGHT_BROWSERS_PATH=~/.ms-playwright/
