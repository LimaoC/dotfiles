# ===== Oh My Zsh configuration ================================================================== #

export PATH=$HOME/bin:$PATH                   # May need to change $PATH if you come from bash.
export ZSH="$HOME/.oh-my-zsh"                 # Path to my oh-my-zsh installation.
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"   # Path to my oh-my-zsh custom configuration.
export NVM_LAZY_LOAD=true                     # Lazy load nvm (zsh-nvm).
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')  # Load nvm when nvim is invoked (required for pyright)

zstyle ':omz:update' mode reminder  # Remind me to update when it's time

ZSH_THEME="limao"
CASE_SENSITIVE="false"                # Case-sensitive completion
HYPHEN_INSENSITIVE="true"             # Hyphen-insensitive competion
DISABLE_UNTRACKED_FILES_DIRTY="true"  # Disable marking untracked files under VCS as dirty
DISABLE_AUTO_TITLE="true"             # Disable auto-changing title
plugins=(git zsh-autosuggestions zsh-nvm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ===== User configuration ======================================================================= #

export PATH=$HOME/.local/bin:$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR=vim
    export VISUAL=vim
else
    export EDITOR=nvim
    export VISUAL=nvim
fi

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt append_history      # allow multiple sessions to append to one history
setopt bang_hist           # treat ! special during command expansion
setopt extended_history    # Write history in :start:elasped;command format
setopt hist_find_no_dups   # When searching history, don't repeat
setopt hist_ignore_space   # prefix command with a space to skip its recording
setopt hist_reduce_blanks  # Remove extra blanks from each command added to history
setopt hist_verify         # Don't execute immediately upon history expansion
setopt inc_append_history  # Write to history file immediately, not when shell quits
setopt share_history       # Share history among all sessions

# Tab completion
autoload -Uz compinit && compinit
setopt auto_menu                    # show completion menu on succesive tab presses
setopt autocd                       # cd to a folder just by typing it's name
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'  # These "eat" the auto prior space after a tab complete

# Miscellaneous
setopt interactive_comments  # allow # comments in shell; good for copy/paste
export BLOCK_SIZE="'1"       # Add commas to file sizes

# Time zsh startup time
# REF: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# Only add valid commands to history. This is nice when used in conjunction with zsh-autosuggestions
# REF: https://www.zsh.org/mla/users//2014/msg00715.html
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# ===== Tool & Language configuration ============================================================ #

# ghcup-env
[ -f "/home/limao/.ghcup/env" ] && source "/home/limao/.ghcup/env"

export GOPATH=$HOME/.go                                     # go path
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.yarn/bin                           # yarn path
export PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux  # texlive path
export PATH=$PATH:$HOME/.spicetify                          # spicetify path

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/limao/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/limao/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/limao/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/limao/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/limao/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ===== Welcome message ========================================================================== #

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
