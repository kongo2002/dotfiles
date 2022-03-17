# k8s.zsh
#
# Registers key-binding for CTRL-K to insert a kubernetes
# pod, deployment or service name into the command.
#
# The name selection is piped through FZF.

# check of FZF exists
if [[ ! -x $(which fzf) ]]; then
    return 0
fi

# check if kubernetes CLI exists
if [[ ! -x $(which kubectl) ]]; then
    return 0
fi

# CTRL-K - select kubernetes pod name
__kpodsel() {
    local entity
    case "$LBUFFER" in
        *pod*)
            entity="pod"
            ;;
        *service*)
            entity="service"
            ;;
        *deployment*)
            entity="deployment"
            ;;
        *)
            entity="pod"
            ;;
    esac
    local cmd="kubectl get ${entity} -o custom-columns=NAME:.metadata.name --no-headers"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local item
    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS" fzf | while read item; do
        echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
}

fzf-kpod-widget() {
    LBUFFER="${LBUFFER}$(__kpodsel)"
    local ret=$?
    zle reset-prompt
    return $ret
}

zle     -N   fzf-kpod-widget
bindkey '^K' fzf-kpod-widget
