alias ,="cd .."
alias ,,="cd ../.."
alias ,,,="cd ../../.."

# Add an "alert" alias for long running commands, use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

