autoload -U compinit promptinit colors
compinit
colors

promptinit

# source rvm
if [[ -s "${HOME}/.rvm/scripts/rvm" ]]; then
    . "${HOME}/.rvm/scripts/rvm" && unset RUBYOPT
    export PATH="${PATH}:${HOME}/.rvm/bin"
fi

# source zsh config files
if [[ -d "${HOME}/.zsh" ]]; then
    for config_file ($HOME/.zsh/*.zsh) source $config_file
fi

[[ -f "${HOME}/python/startup.py" ]] && export PYTHONSTARTUP="${HOME}/python/startup.py"

if [[ -x "${HOME}/programs/dotnet/dotnet" ]]; then
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
    export DOTNET_ROOT="${HOME}/programs/dotnet"
fi

if [[ -x "${HOME}/programs/nim/bin/nim" ]]; then
    export PATH="${PATH}:${HOME}/programs/nim/bin"
    export PATH="${PATH}:${HOME}/.nimble/bin"
fi

if [[ -d "$HOME/.krew" ]]; then
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

if [[ -x $(which mpd) ]]; then
    export MPD_HOST="127.0.0.1"
    export MPD_PORT="6600"
fi

if [[ -x $(which tig) ]]; then
    alias tiga='tig --all'
fi

if [[ -x "$HOME/.zsh/gradle-wrapper.sh" ]]; then
    alias gradle="$HOME/.zsh/gradle-wrapper.sh"
fi

if [[ -x $(which docker-compose) ]]; then
    alias dockerc='docker-compose'
fi

if [[ -x $(which ag) ]]; then
    alias ag='ag --smart-case --ignore tags'
fi

alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'

alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

if [[ -x $(which nvim) ]]; then
    alias vim=nvim
fi

if [[ -x $(which timew) ]]; then
    alias tiday='timew summary :id'
    alias tiweek='timew summary :week :id'
fi

export FZF_DEFAULT_OPTS="--no-mouse"
export FZF_DEFAULT_COMMAND='fd --type f --color never'
export FZF_CTRL_T_OPTS="--preview 'bat --color always --style numbers {}' --preview-window down"
export FZF_CTRL_T_COMMAND='fd --type f --color never'

export BAT_THEME='1337'

alias tiga='tig --all'

alias '..'='cd ..'
alias 'cd..'='cd ..'
alias 'cd...'='cd ../..'
alias 'cd....'='cd ../../..'
alias 'cd.....'='cd ../../../..'
alias 'cd/'='cd /'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias cal='cal -3'

cd () {
    if [[ "x$*" == "x..." ]]; then
        cd ../..
    elif [[ "x$*" == "x...." ]]; then
        cd ../../..
    elif [[ "x$*" == "x....." ]]; then
        cd ../../..
    elif [[ "x$*" == "x......" ]]; then
        cd ../../../..
    else
        builtin cd "$@"
    fi
}

alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

waitfor() {
    local process
    pgrep "$@" > /dev/null 2>&1 || return 1
    for process in "$@"; do
        echo -n "Waiting for '$process' "
        while pgrep "$process" > /dev/null 2>&1; do
            echo -n "."
            sleep 30
        done
        echo ""
    done
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias cal='cal -3'

alias gd='git diff'
alias gf='git fetch'
alias ga='git add'

if [[ -x $(which timew) ]]; then
    alias tiday='timew summary :id'
    alias tiweek='timew summary :week :id'
fi

if [[ -x $(which starship) ]]; then
    eval "$(starship init zsh)"
else
    PROMPT='%{${fg_bold[white]}%}%n@%m%{${fg_bold[red]}%}!%{${fg_bold[white]}%}%!%(?..%{${fg_bold[red]}%} %?%{${fg_bold[white]}%})$(_python_prompt)>%{${reset_color}%} '
    RPROMPT=' %~'

    _KONGO_ASYNC_PROMPT=0
    _KONGO_ASYNC_COMM="/tmp/.zsh_prompt_$$"

    function _python_prompt() {
        if [[ -n "${VIRTUAL_ENV}" ]]; then
            local venv="$(basename "${VIRTUAL_ENV}")"
            echo -n "%{${fg_bold[green]}%}!%{${reset_color}%}${venv//python-/}"
        fi
    }

    function _kongo_precmd() {
        function async() {
            printf "%s %%~" "$(git_prompt)" >| $_KONGO_ASYNC_COMM
            kill -s USR1 $$
        }

        if [[ "${_KONGO_ASYNC_PROMPT}" != 0 ]]; then
            kill -s HUP $_KONGO_ASYNC_PROMPT >/dev/null 2>&1 || :
        fi

        async &!
        _KONGO_ASYNC_PROMPT=$!
    }

    function _kongo_trap() {
        RPROMPT="$(cat $_KONGO_ASYNC_COMM)"
        _KONGO_ASYNC_PROMPT=0

        # reset prompt
        zle && zle reset-prompt
    }

    function _kongo_atexit() {
        # cleanup on shutdown
        rm -f $_KONGO_ASYNC_COMM
    }

    precmd_functions+=(_kongo_precmd)
    zshexit_functions+=(_kongo_atexit)
    trap '_kongo_trap' USR1
fi

EDITOR="/usr/local/bin/nvim"

# toggle vi mode
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

bindkey "^n" history-beginning-search-backward
bindkey "^p" history-beginning-search-forward
bindkey "^r" history-incremental-search-backward

bindkey -M vicmd "\e." insert-last-word
bindkey -M viins "\e." insert-last-word

# history settings
#
HISTFILE=~/.zshhistory
HISTORY_IGNORE="(l|ls|ll|exit|cd|su|su -|gf|gs|gd|tiday|git ci|git cia|cd -|tiga|tig|vim|tmux)"
HISTSIZE=25000
SAVEHIST=100000

LISTMAX=0

# Expansion options
#
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Completion caching
#
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Expand partial paths
#
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Case sensitivity
#
## case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## case-insensitive (all) completion
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
## case-insensitive,partial-word and then substring completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Include non-hidden directories in globbed file completions
# for certain commands
#
zstyle ':completion::complete:*' '\'

#  tag-order 'globbed-files directories' all-files
#
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
#
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups
#
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
#
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
#
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'

# Describe options in full
#
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# zsh Options

# change dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

# completion
setopt always_to_end
setopt complete_aliases
setopt complete_in_word
setopt glob_complete
setopt list_packed

setopt no_listbeep

# expansion/globbing
setopt bad_pattern
setopt equals
setopt numeric_glob_sort

setopt no_glob_subst
setopt no_casematch

# history
setopt append_history
setopt extended_history
setopt hist_allow_clobber
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

setopt no_hist_beep

# i/o
setopt correct
setopt path_dirs
setopt short_loops
setopt notify
setopt long_list_jobs

setopt no_correct_all
setopt no_clobber
setopt no_hup

# prompt
setopt prompt_subst

# zle
setopt zle
setopt vi

setopt no_beep

# source fzf if existing
if [[ -s ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# source zsh-autocompletions
#   <https://github.com/zsh-users/zsh-autosuggestions>
if [[ -s ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -x $(which scmpuff) ]]; then
    eval "$(scmpuff init -s)"

    # integrate scm-puff with flutter
    function flformat() {
        eval "$(scmpuff expand -- flutter format "$@")"
    }

    # integrate scm-puff with vim
    function vimf() {
        eval "$(scmpuff expand -- vim "$@")"
    }
fi

if [ -x "$HOME/.gradle-wrapper.sh" ]; then
    alias gradle="$HOME/.gradle-wrapper.sh"
fi

if [[ -x $(which direnv) ]]; then
    eval "$(direnv hook zsh)"
fi

if [[ -x $(which zoxide) ]]; then
    eval "$(zoxide init zsh)"
fi

if [[ -x $(which nnn) ]]; then
    alias n='nnn -c -a -P p'
    export NNN_PLUG="p:preview-tui"
    export NNN_OPENER=nuke
fi

if [[ -f "${HOME}/.ripgreprc" ]]; then
    export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
fi

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/programs/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/programs/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/programs/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/programs/google-cloud-sdk/completion.zsh.inc"; fi

# YARN
if [[ -d "$HOME/.yarn/bin" ]]; then
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# NVM
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
