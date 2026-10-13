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
