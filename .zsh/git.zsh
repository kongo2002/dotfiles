# git status colors

ZSH_THEME_GIT_PROMPT_CLEAN="%{${fg_bold[green]}%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${fg_bold[green]}%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{${fg_bold[yellow]}%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{${fg_bold[yellow]}%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{${fg_bold[yellow]}%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{${fg_bold[red]}%}"

# get the current branch

function current_branch() {
ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

# build the git prompt string

git_prompt () {
    INDEX=$(git status --porcelain 2> /dev/null)
    GIT=""

    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_UNMERGED"
    elif $(echo "$INDEX" | grep '^A ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_ADDED"
    elif $(echo "$INDEX" | grep '^M ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_ADDED"
    elif $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_MODIFIED"
    elif $(echo "$INDEX" | grep '^R ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_RENAMED"
    elif $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_DELETED"
    elif $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
        GIT="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    else
        GIT="$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi

    echo "$GIT($(current_branch))%{${reset_color}%}"
}
