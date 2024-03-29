# ----- MISC BASH CONFIG --------------------------------------------------------------------------------------------- #
# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth   # don't put duplicate lines or lines starting with space in the history.
HISTSIZE=1000            # number of commands stored in memory
HISTFILESIZE=2000        # number of commands stored on disk
PROMPT_DIRTRIM=3         # shorten directory path to 3 max

shopt -s histappend    # append to the history file, don't overwrite it
shopt -s checkwinsize  # check window size after each command and, if necessary, update LINES and COLUMNS

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable this, if it's already enabled in
# /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# alias definitions, see .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ----- COLOUR ------------------------------------------------------------------------------------------------------- #
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_colour_prompt=yes  # coloured prompt, if the terminal has the capability
if [ -n "$force_colour_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u \[\033[01;35m\]@\[\033[00m\] '
    PS1+='\[\033[01;34m\]\w\[\033[00m\] \[\033[01;35m\]» \[\033[00m\]'
    else
    PS1='${debian_chroot:+($debian_chroot)}\u @ \w » '
    fi
fi
unset force_colour_prompt

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ----- LANGUAGE AND PROGRAM CONFIGS --------------------------------------------------------------------------------- #

# ghcup-env
[ -f "/home/limao/.ghcup/env" ] && source "/home/limao/.ghcup/env"

# go path
export GOPATH=$HOME/.go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# set nvim as default editor
export EDITOR=nvim
export VISUAL=nvim

# nvm path and dir
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn path
export PATH=$PATH:$HOME/.yarn/bin

# texlive path
export PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/limao/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/limao/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# ----- WELCOME MESSAGE ---------------------------------------------------------------------------------------------- #

# note: you will need to install `lolcat` for this to work
echo -e "
  @@@@      %@@                             
    @@       @@                             
    @@                                      
    @@                                      
    @@      @@@     @@@  /@@@@@ /@@@@@@     
    @@       @@       @/@@/   @@@/    @@    
    @@       @@       @@/     @@      @@@   
    @@       @@       @@      @@      @@@   
    @@       @@       @@      @@      @@@   
    @@       @@       @@      @@      @@@   
    @@       @@       @@      @@      @@@   
  @@@@@@   @@@@@@   @@@@@@  @@@@@@  @@@@@@@ 
                                            
                       @@                   
   @@@@                 @@         @@@@@    
 &@/   @@                @@      @@      @  
     @@@@    @@@@@@@@@@@@@@@@    @       #@ 
 @@&/  @@                @@     .@       #@.
@@@   /@@ @             @@       @/      @% 
  @@@@  @@             @@          @@@@@@   
                                            " | lolcat

