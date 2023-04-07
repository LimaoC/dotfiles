PROMPT="%{$fg_bold[green]%}%n %{$fg_bold[magenta]%}@ "
PROMPT+='%{$fg[blue]%}%(4~|.../%3~|%~) $(git_prompt_info)%{$fg_bold[magenta]%}»%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[magenta]%}] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

