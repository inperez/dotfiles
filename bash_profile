# DOTFILESDIR SHOULD BE DEFINED FOR THIS TO RUN PROPERLY
DOTFILESDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:~/bin" # Add bin
export PATH="$DOTFILESDIR:$PATH" # add this folder

# ATLAS
source $DOTFILESDIR/atlas

# GO
export GOPATH="$HOME/WORK/gocode" # add the gopath var
export PATH="$PATH:$GOPATH/bin" # add executable

# RUBY
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NODE
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh  # Add NVM to PATH for scripting

# GULP
eval "$(gulp --completion=bash)"

# GIT
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# PS1="\n\e[0;33m\w\e[m\n\u@\h  sez:\n"
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# PS1='\n\e[0;33m\w\e[m\n\u@\h $(__git_ps1 "(on \e[0;35m\]%s\[\e[0m\])"):\n'
PS1='\n\e[0;33m\w\e[m $(__git_ps1 "(on \e[0;35m\]%s\[\e[0m\])"):\n'


git config --global color.ui true
alias gitlg="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"

alias s="git status -s"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# from https://github.com/git/git/tree/master/contrib/completion
source $DOTFILESDIR/git-completion.sh

# https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
source $DOTFILESDIR/git-prompt.sh

# VAGRANT
alias vgs='vagrant global-status'

# SIMPLE SERVERS
alias serve='python -m SimpleHTTPServer'
alias sserve='twistd -n web -p 8887 --path .'

# GENERAL

alias ls='ls -F'
alias ll='ls -l -h'
alias la='ls -a'
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'

if ! grep -Fxq "set completion-ignore-case On" ~/.inputrc; then
  echo "set completion-ignore-case On" >> ~/.inputrc
fi

# Move to trash.
function rm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}
