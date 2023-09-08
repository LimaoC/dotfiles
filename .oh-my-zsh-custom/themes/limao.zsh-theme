# Comment and uncomment the optional lines below to your liking. Optional lines are marked with an asterisk *.
PROMPT="%{$fg_bold[magenta]%}λ %{$fg_bold[blue]%}%(4~|…/%3~|%~) "
PROMPT+="%{$fg_bold[magenta]%}[%{$fg_bold[green]%}\$CONDA_DEFAULT_ENV%{$fg_bold[magenta]%}] "  # *Conda env name
PROMPT+='%{$reset_color%}$(git_prompt_info)'                                                   # *Git branch
PROMPT+="%{$fg_bold[magenta]%}»%{$reset_color%} "                                              # Prompt suffix
# RPROMPT="%{$fg_bold[grey]%}[%T]"                                                             # *Timestamp on right of prompt

# Required for git_prompt_info:
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[magenta]%}] %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

