# git status colors

ZSH_THEME_GIT_PROMPT_ADDED="%{${fg_bold[green]}%}+"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${fg_bold[yellow]}%}?"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{${fg_bold[yellow]}%}*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{${fg_bold[yellow]}%}→"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{${fg_bold[red]}%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{${fg_bold[red]}%}-"

# get the current branch

function current_branch() {
ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

# build the git prompt string

git_prompt () {
    INDEX=$(git status --porcelain 2> /dev/null)
    GIT=""

    if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_UNTRACKED$GIT"
    fi

    if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_ADDED$GIT"
    elif $(echo "$INDEX" | grep '^M' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_ADDED$GIT"
    fi

    if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_RENAMED$GIT"
    fi

    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_DELETED$GIT"
    fi

    if $(echo "$INDEX" | grep '^[A-Z ]M ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_MODIFIED$GIT"
    fi

    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_UNMERGED$GIT"
    fi

    echo "$GIT %{${reset_color}%}($(current_branch))"
}
