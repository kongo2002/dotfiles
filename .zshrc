autoload -U compinit promptinit
compinit

if [[ "$HOST" -eq "eeepc" ]]; then
    promptinit
else
    promptinit; prompt gentoo
fi

source /etc/profile

export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# XDG variables
export XDG_CONFIG_HOME="/home/kongo/.config"
export XDG_DATA_HOME="/home/kongo/.data"
export XDG_CACHE_HOME="/home/kongo/.cache"

alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g ....='../../../..'

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias ig='grep -i'
alias ping='ping -c 5'

alias boistop='sudo /etc/init.d/boinc stop'
alias boistart='sudo /etc/init.d/boinc start'

alias kvm-arch='kvm -hda ~/.kvm_arch/arch-i686.img -net nic -net tap,ifname=qtap0,script=no,downscript=no -boot c -m 1024 -soundhw es1370'

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

git_b() {
    if [[ -d ".git" ]] then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    fi
}

git_c() {
    if [[ -d ".git" ]] then
        s="$(git status 2> /dev/null | tail -1 | sed -e 's/^\(\w*\).*/\1/')"

        if [ "$s" = "nothing" ]; then
            GCOLOR=$PR_BOLD_GREEN
        elif [ "$s" = "no" ]; then
            GCOLOR=$PR_BOLD_YELLOW
        else
            GCOLOR=$PR_BOLD_RED
        fi

        printf "%s" "${GCOLOR}"
    else
        echo ""
    fi
}

setprompt() {    # load colors
    autoload -U colors
    colors

    for COLOR in RED GREEN YELLOW BLUE WHITE BLACK; do
        eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
        eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    done

    PROMPT='${PR_BOLD_BLUE}$VIMODE${PR_BOLD_WHITE}%n@%m${PR_BOLD_RED}!${PR_BOLD_WHITE}%!>%{${reset_color}%} '
    RPROMPT='$(git_c)$(git_b)%{${reset_color}%} %~'
}

EDITOR="/usr/bin/vim"

# toggle vi mode
bindkey -v

# history settings
#
HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000

bindkey "^n" history-beginning-search-backward
bindkey "^p" history-beginning-search-forward
bindkey -M vicmd "\e." insert-last-word
bindkey -M viins "\e." insert-last-word

# grc stuff for colored output
#
if [ "$TERM" != dumb ] && [ -x /usr/bin/grc ] ; then
    alias cl='/usr/bin/grc -es --colour=auto'
    alias configure='cl ./configure'
    alias diff='cl diff'
    alias make='cl make'
    alias gcc='cl gcc'
    alias g++='cl g++'
    alias as='cl as'
    alias gas='cl gas'
    alias ld='cl ld'
    alias netstat='cl netstat'
    alias ping='cl ping'
    alias traceroute='cl /usr/sbin/traceroute'
fi

# Other misc settings
#
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

# {{{ Simulate my old dabbrev-expand 3.0.5 patch
#
zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false

#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#
# zsh Options
#

setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
     NO_auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
        beep                 \
        brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     correct                 \
     NO_correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
        hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
        inc_append_history   \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
        nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
     NO_sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle

setprompt
