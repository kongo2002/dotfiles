
if [[ "$(uname -s)" != "Darwin" ]]; then
    return 0
fi

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# vim:set ft=zsh:
