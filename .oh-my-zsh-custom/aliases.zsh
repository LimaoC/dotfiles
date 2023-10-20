# for managing my dotfiles repository, I use `config` instead of `git`
# REF: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ,="cd .."
alias ,,="cd ../.."
alias ,,,="cd ../../.."

alias python=python3

# Add an "alert" alias for long running commands, use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Top 5 most frequently used comments
# REF: https://old.reddit.com/r/archlinux/comments/t4ohgq/what_are_your_top_5_most_used_shell_commands/
alias top5='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 5'

