# Cheatsheet:
# %F/%f => start/stop foreground colour
# %B/%b => start/stop bold
# %T => current time of day in 24hr format

# Required for git_prompt_info:
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{magenta}[%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{magenta}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Show conda environment name only if an environment is activated
conda_prompt_info() {
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        echo " %B%F{magenta}[%F{green}$CONDA_DEFAULT_ENV%F{magenta}]"
    fi
}

NEWLINE=$'\n'

# Comment and uncomment the optional lines below to your liking. Optional lines are marked with an asterisk *.
PROMPT="%B%F{magenta}λ %F{yellow}%n"
# PROMPT+='@%m'                                  # *Hostname
PROMPT+=' %F{blue}%(4~|…/%3~|%~)'                # Current directory
PROMPT+='$(git_prompt_info)'                     # *Git info
PROMPT+='$(conda_prompt_info)'                   # *Conda environment name
PROMPT+="${NEWLINE}%F{magenta}»%b%f "            # Prompt suffix
# RPROMPT="%B%F{7}%T"                            # *Timestamp on right of prompt

