autoload -U compinit promptinit colors
compinit
colors

promptinit

source /etc/zsh/zprofile

# extend PATH
[[ -d "${HOME}/.bin" ]] && export PATH="${PATH}:${HOME}/.bin"
[[ -d "${HOME}/.local/bin" ]] && export PATH="${PATH}:${HOME}/.local/bin"
[[ -d "${HOME}/.local/sbin" ]] && export PATH="${PATH}:${HOME}/.local/sbin"
[[ -d "${HOME}/.cabal/bin" ]] && export PATH="${HOME}/.cabal/bin:${PATH}"
[[ -d "${HOME}/.gem/ruby/2.0.0/bin" ]] && export PATH="${PATH}:${HOME}/.gem/ruby/2.0.0/bin"

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

if [[ -x $(which mpd) ]]; then
    export MPD_HOST="127.0.0.1"
    export MPD_PORT="6600"
fi

# convenience bluetooth alias for mplayer
if [[ -x $(which mplayer) ]]; then
    alias mplayer-blue='mplayer -ao alsa:device=bluetooth'
fi

if [[ -x $(which tig) ]]; then
    alias tiga='tig --all'
fi

if [[ -x $(which ag) ]]; then
    alias ag='ag --smart-case --ignore tags'
fi

export FZF_DEFAULT_OPTS="--no-mouse"

# register git-achievements
if [[ -x "${HOME}/programs/git-achievements/git-achievements" ]]; then
    export PATH="${PATH}:${HOME}/programs/git-achievements"
    alias 'git'='git-achievements'
fi

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

function veth_interface_for_container() {
  # Get the process ID for the container named ${1}:
  local pid=$(docker inspect -f '{{.State.Pid}}' "${1}")

  # Make the container's network namespace available to the ip-netns command:
  mkdir -p /var/run/netns
  ln -sf /proc/$pid/ns/net "/var/run/netns/${1}"

  # Get the interface index of the container's eth0:
  local index=$(ip netns exec "${1}" ip link show eth0 | head -n1 | sed s/:.*//)
  # Increment the index to determine the veth index, which we assume is
  # always one greater than the container's index:
  let index=index+1

  # Write the name of the veth interface to stdout:
  ip link show | grep "^${index}:" | sed "s/${index}: \(.*\):.*/\1/"

  # Clean up the netns symlink, since we don't need it anymore
  rm -f "/var/run/netns/${1}"
}

waitfor() {
    for process in "$@"; do
        echo -n "Waiting for '$process' "
        while pgrep "$process" > /dev/null 2>&1; do
            echo -n "."
            sleep 30
        done
        echo ""
    done
}

zsh_stats() {
    history 1 | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias ls="ls -h --color=auto"
alias ll="ls -lh --color=auto"
alias l="ls -lha --color=auto"

# use a light gtk theme
alias gtkl="GTK2_RC_FILES='MorningGlory:$HOME/.themes/MorningGlory/gtk-2.0/gtkrc'"

PROMPT='%{${fg_bold[white]}%}%n@%m%{${fg_bold[red]}%}!%{${fg_bold[white]}%}%!%(?..%{${fg_bold[red]}%} %?%{${fg_bold[white]}%})>%{${reset_color}%} '
RPROMPT='$(git_prompt) %~'

EDITOR="/usr/bin/vim"

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
HISTIGNORE="ls:ll:exit:cd:su"
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

[ -s "${HOME}/.scm_breeze/scm_breeze.sh" ] && source "${HOME}/.scm_breeze/scm_breeze.sh"
