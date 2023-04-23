# for managing my dotfiles repository, I use `config` instead of `git`
# see https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ,="cd .."
alias ,,="cd ../.."
alias ,,,="cd ../../.."

alias python=python3

# Add an "alert" alias for long running commands, use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

