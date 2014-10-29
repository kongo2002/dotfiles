autoload -U compinit promptinit colors
compinit
colors

promptinit; prompt gentoo

source /etc/profile

# extend PATH
[[ -d "${HOME}/.bin" ]] && export PATH="${PATH}:${HOME}/.bin"
[[ -d "${HOME}/.cabal/bin" ]] && export PATH="${HOME}/.cabal/bin:${PATH}"

# source rvm
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm" && unset RUBYOPT

# source zsh config files
if [[ -d "${HOME}/.zsh" ]]; then
    for config_file ($HOME/.zsh/*.zsh) source $config_file
fi

if [[ -x $(which mpd) ]]; then
    export MPD_HOST="127.0.0.1"
    export MPD_PORT="6600"
fi

if [[ -x $(which tig) ]]; then
    alias tiga='tig --all'
fi

export FZF_DEFAULT_OPTS="--no-mouse"

# register git-achievements
if [[ -x "${HOME}/programs/git-achievements/git-achievements" ]]; then
    export PATH="${PATH}:${HOME}/programs/git-achievements"
    alias 'git'='git-achievements'
fi

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

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias ls="ls -h --color=auto"
alias ll="ls -lh --color=auto"
alias l="ls -lha --color=auto"

# use a light gtk theme
alias gtkl="GTK2_RC_FILES='MorningGlory:$HOME/.themes/MorningGlory/gtk-2.0/gtkrc'"

# get current vi mode
VIMODE="[I] "
function zle-line-init zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/[C] }/(main|viins)/[I] }"
    zle reset-prompt
}

# register new zsh widget
zle -N zle-line-init
zle -N zle-keymap-select

PROMPT='%{${fg_bold[blue]}%}$VIMODE%{${fg_bold[white]}%}%n@%m%{${fg_bold[red]}%}!%{${fg_bold[white]}%}%!%(?..%{${fg_bold[red]}%} %?%{${fg_bold[white]}%})>%{${reset_color}%} '
RPROMPT='$(git_prompt) %~'

EDITOR="/usr/bin/vim"

# toggle vi mode
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

bindkey "^n" history-beginning-search-backward
bindkey "^p" history-beginning-search-forward
bindkey -M vicmd "\e." insert-last-word
bindkey -M viins "\e." insert-last-word

# history settings
#
HISTFILE=~/.zshhistory
HISTIGNORE="ls:ll:exit:cd:su"
HISTSIZE=25000
SAVEHIST=10000

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
#
setopt                         \
     NO_all_export             \
        always_last_prompt     \
        always_to_end          \
        append_history         \
     NO_auto_cd                \
        auto_list              \
        auto_menu              \
     NO_auto_name_dirs         \
        auto_param_keys        \
        auto_param_slash       \
        auto_pushd             \
        auto_remove_slash      \
     NO_auto_resume            \
        bad_pattern            \
        bang_hist              \
        beep                   \
        brace_ccl              \
        correct_all            \
     NO_bsd_echo               \
        cdable_vars            \
     NO_chase_links            \
     NO_clobber                \
        complete_aliases       \
        complete_in_word       \
     correct                   \
     NO_correct_all            \
        csh_junkie_history     \
     NO_csh_junkie_loops       \
     NO_csh_junkie_quotes      \
     NO_csh_null_glob          \
        equals                 \
        extended_glob          \
        extended_history       \
        function_argzero       \
        glob                   \
     NO_glob_assign            \
        glob_complete          \
     NO_glob_dots              \
        glob_subst             \
        hash_cmds              \
        hash_dirs              \
        hash_list_all          \
        hist_allow_clobber     \
        hist_beep              \
        hist_expire_dups_first \
        hist_ignore_dups       \
        hist_ignore_space      \
     NO_hist_no_store          \
        hist_verify            \
     NO_hup                    \
     NO_ignore_braces          \
     NO_ignore_eof             \
        interactive_comments   \
        inc_append_history     \
     NO_list_ambiguous         \
     NO_list_beep              \
        list_types             \
        long_list_jobs         \
        magic_equal_subst      \
     NO_mail_warning           \
     NO_mark_dirs              \
     NO_menu_complete          \
        multios                \
        nomatch                \
        notify                 \
     NO_null_glob              \
        numeric_glob_sort      \
     NO_overstrike             \
        path_dirs              \
        posix_builtins         \
     NO_print_exit_value       \
     NO_prompt_cr              \
        prompt_subst           \
        pushd_ignore_dups      \
     NO_pushd_minus            \
        pushd_silent           \
        pushd_to_home          \
        rc_expand_param        \
     NO_rc_quotes              \
     NO_rm_star_silent         \
     NO_sh_file_expansion      \
        sh_option_letters      \
        short_loops            \
     NO_sh_word_split          \
     NO_single_line_zle        \
     NO_sun_keyboard_hack      \
        unset                  \
     NO_verbose                \
        zle

# source fzf if existing
[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh
