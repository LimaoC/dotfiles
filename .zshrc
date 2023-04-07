# ===== Oh My Zsh configuration ================================================================== #

export PATH=$HOME/bin:$PATH                  # If you come from bash you might have to change your $PATH.
export ZSH="$HOME/.oh-my-zsh"                # Path to my oh-my-zsh installation.
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"  # Path to my oh-my-zsh custom configuration.

zstyle ':omz:update' mode reminder  # Remind me to update when it's time

ZSH_THEME="limao"
CASE_SENSITIVE="false"     # Case-sensitive completion
HYPHEN_INSENSITIVE="true"  # Hyphen-insensitive competion
DISABLE_UNTRACKED_FILES_DIRTY="true"  # Disable marking untracked files under VCS as dirty
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ===== User configuration ======================================================================= #

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
setopt append_history           # allow multiple sessions to append to one history
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip its recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt share_history            # Share history among all sessions

# Tab completion
autoload -Uz compinit && compinit
setopt auto_menu                    # show completion menu on succesive tab presses
setopt autocd                       # cd to a folder just by typing it's name
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'  # These "eat" the auto prior space after a tab complete

# Miscellaneous
setopt interactive_comments     # allow # comments in shell; good for copy/paste
export BLOCK_SIZE="'1"          # Add commas to file sizes

# Time zsh startup time; ref https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# ===== Tool & Language configuration ============================================================ #

# ghcup-env
[ -f "/home/limao/.ghcup/env" ] && source "/home/limao/.ghcup/env"

# lazy load nvm; ref http://broken-by.me/lazy-load-nvm/
load_nvm() {
    export NVM_DIR=$HOME/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                     # Load nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
    nvm "$@"
}
nvm() { unset -f nvm; load_nvm }
node() { unset -f node; load_nvm }
npm() { unset -f npm; load_nvm }

export GOPATH=$HOME/.go                                     # go path
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.yarn/bin                           # yarn path
export PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux  # texlive path
export PATH=$PATH:$HOME/.spicetify                          # spicetify path

### Welcome message

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

