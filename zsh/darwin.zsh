# macOS specific settings

if [[ "$(uname -s)" != "Darwin" ]]; then
    return 0
fi

if [[ -x $(which eza) ]]; then
    alias ls='eza'
    alias ll='eza -l --git --no-permissions --octal-permissions'
    alias l='eza -la --git --no-permissions --octal-permissions'
else
    alias ls='ls -hG'
    alias ll='ls -lhG'
    alias l='ls -lhaG'
fi
