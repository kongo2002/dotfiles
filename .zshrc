autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

source /etc/profile

export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# settings for uzbl (especially)
export XDG_CONFIG_HOME="/home/kongo/.config"
export XDG_DATA_HOME="/home/kongo/.data"

# settings for lancelot nlp solver engine
export LANDIR="/home/kongo/programs/lancelot/lancelot"
alias sdlan="$LANDIR/sdlan"
alias lan="$LANDIR/lan"

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias igrep='grep -i'
alias ping='ping -c 5'

alias boistop='sudo /etc/init.d/boinc stop'
alias boistart='sudo /etc/init.d/boinc start'

alias kvm-arch='kvm -hda ~/.kvm_arch/arch-i686.img -net nic -net tap,ifname=qtap0,script=no,downscript=no -boot c -m 1024 -soundhw es1370'

alias screen='screen -T $TERM'

alias ls="ls -h --color=auto"
alias ll="ls -lh --color=auto"
alias l="ls -lha --color=auto"

parse_git_branch() {
    if [[ -d ".git" ]] then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    fi
}

fg_green=$'%{\e[1;32m%}'
fg_no=$'%{\e[0m%}'

PROMPT='%n@%m> '
RPROMPT='$fg_green$(parse_git_branch)$fg_no %~'

EDITOR="/usr/bin/vim"

set -o vi

# history settings
#
HISTFILE=~/.zshhistory
HISTSIZE=3000
HISTIGNORE=ll:ls
SAVEHIST=3000

bindkey "^f" history-beginning-search-backward
 
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
