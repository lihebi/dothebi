#!/bin/sh
# smt.zsh-theme, based on dogenpunk by Matthew Nelson.

MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="➤ %{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function prompt_char() {
  git branch >/dev/null 2>/dev/null && echo "%{$fg[green]%}±%{$reset_color%}" && return
  hg root >/dev/null 2>/dev/null && echo "%{$fg_bold[red]%}☿%{$reset_color%}" && return
  darcs show repo >/dev/null 2>/dev/null && echo "%{$fg_bold[green]%}❉%{$reset_color%}" && return
  echo "%{$fg[cyan]%}◯%{$reset_color%}"
}


function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg_bold[red]%}(ssh) "
  fi
}
function quote() {
  echo " 我坐在观众席上看，尔等的愚笨"
}
function name() {
  echo "合璧"
}

PROMPT='
$(ssh_connection)%{$fg[cyan]%}%m%{$reset_color%} $(name) %{$fg[cyan]%}%~ %{$reset_color%}$(git_prompt_info) $(quote)
%{$fg[red]%}˚∆˚%{$reset_color%} $(prompt_char) : '

RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%}'
