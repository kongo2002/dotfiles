# usually these should be set in `.zshenv` but gentoo's /etc/zprofile
# overwrites the $PATH itself

# extend PATH
[[ -d "${HOME}/.bin" ]] && export PATH="${HOME}/.bin:${PATH}"
[[ -d "${HOME}/.local/bin" ]] && export PATH="${PATH}:${HOME}/.local/bin"
[[ -d "${HOME}/.local/sbin" ]] && export PATH="${PATH}:${HOME}/.local/sbin"
[[ -d "${HOME}/.cabal/bin" ]] && export PATH="${HOME}/.cabal/bin:${PATH}"
[[ -d "${HOME}/go/bin" ]] && export PATH="${PATH}:${HOME}/go/bin"

export MANPATH="$MANPATH:$HOME/.local/share/man"

# source zprofile files
if [[ -d "${HOME}/.zsh" ]]; then
    for profile_file ($HOME/.zsh/*.zprofile) source $profile_file
fi

# k8s
if [[ -d "$HOME/.krew" ]]; then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# devcontainers
if [[ -d "${HOME}/.devcontainers/bin" ]]; then
    export PATH="${HOME}/.devcontainers/bin:$PATH"
fi

# chromedriver (playwright)
if [[ -d "$HOME/programs/chromedriver" ]]; then
    export PATH="$PATH:$HOME/programs/chromedriver"
fi

# .NET tools
if [[ -d "${HOME}/.dotnet/tools" ]]; then
    export PATH="$PATH:${HOME}/.dotnet/tools"
fi
