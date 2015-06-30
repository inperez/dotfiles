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
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# POSTGRES
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin


# NODE
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh  # Add NVM to PATH for scripting

# GULP
eval "$(gulp --completion=bash)"

# GIT

alias gs="git status -s"

git config --global alias.ca 'commit -am'
git config --global push.default current

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# some options for prompt
# PS1="\n\e[0;33m\w\e[m\n\u@\h  sez:\n"
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# PS1='\n\e[0;33m\w\e[m\n\u@\h $(__git_ps1 "(on \e[0;35m\]%s\[\e[0m\])"):\n'
PS1='\n\e[0;34m\w/\e[m $(__git_ps1 "(on \e[0;91m\]%s\[\e[0m\])"):\n'

git config --global color.ui true
alias gl="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# from https://github.com/git/git/tree/master/contrib/completion
source $DOTFILESDIR/git-completion.sh

# from https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
source $DOTFILESDIR/git-prompt.sh

### HEROKU
export PATH="/usr/local/heroku/bin:$PATH"

# VAGRANT
alias vgs='vagrant global-status'

# SIMPLE SERVERS
alias serve='python -m SimpleHTTPServer'
alias sserve='twistd -n web -p 8887 --path .'

# HELPERS

# Open new tab
source $DOTFILESDIR/tab.bash


# usage `killp 4000`
function killp(){
  if [[ $# -eq 0 ]] ; then
    echo 'Kill Process on Port'
    echo '---'
    echo 'Specify a port to to kill processes. i.e. `killport 4000`'
    return
  fi
  lsof -t -i :$1
  kill $(lsof -t -i :$1)

}

function openp (){
  open http://localhost:$1
}



# OREILLY
export GOREILLY="src/github.com/oreillymedia"
function goreilly () {
  if [[ $1 = "s" ]]; then
    cd $GOPATH/$GOREILLY/styleguide
    gulp server
  elif [[ $1 = "p" ]]; then
    cd $GOPATH/$GOREILLY/prototype-server
  elif [[ $1 = "a" ]]; then
    cd $GOPATH/$GOREILLY/prototype-api
  else
    cd $GOPATH/$GOREILLY/styleguide
    tab $GOPATH/$GOREILLY/prototype-server 'gulp server'
    tab $GOPATH/$GOREILLY/prototype-api gin
  fi
}

# GENERAL
alias ls='ls -F'
alias ll='ls -l -h'
alias la='ls -a'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

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