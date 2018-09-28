# DOTFILESDIR SHOULD BE DEFINED FOR THIS TO RUN PROPERLY
DOTFILESDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:~/bin" # Add bin
export PATH="$DOTFILESDIR:$PATH" # add this folder

# ATLAS
source $DOTFILESDIR/atlas

# GO
export GOPATH="$HOME/WORK/gocode" # add the gopath var
export PATH=$PATH:/usr/local/opt/go/libexec/bin # add the gopath var
export PATH="$PATH:$GOPATH/bin" # add executable

# Kubernetes kubectl
# source <(kubectl completion bash)

#PYTHON
alias python='python3'
alias pip='pip3'
# source /usr/local/bin/virtualenvwrapper.sh

# RUBY
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# POSTGRES
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin


# NODE

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
export PATH="$PATH:node_modules/.bin" # add local nodes to executable

# GULP
eval "$(gulp --completion=bash)"

# PHP / COMPOSER
export PATH="$(brew --prefix php@5.6)/bin:$PATH"
export PATH="$PATH:~/.composer/vendor/bin" # add composer to executable

# Convert TTF/OTF font to @font-face font stack
alias fontstack='~/bin/css3FontConverter/convertFonts.sh'

# GIT

alias gs="git status -s"

git config --global alias.ca 'commit -am'
git config --global push.default current
git config --global alias.undo 'reset --soft HEAD^'

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# some options for prompt
# PS1="\n\e[0;33m\w\e[m\n\u@\h  sez:\n"
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# PS1='\n\e[0;33m\w\e[m\n\u@\h $(__git_ps1 "(on \e[0;35m\]%s\[\e[0m\])"):\n'
PS1='\n\e[0;34m\w/\e[m $(__git_ps1 "(on \e[0;91m\]%s\[\e[0m\])"):\n'

git config --global color.ui true
alias gl="git log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"

alias git_cleanup_remote="git branch -r --merged master |grep origin | grep -v '>' | grep -v master | awk '{split($0,a,"/"); print a[2]}'| xargs git push origin --delete"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# from https://github.com/git/git/tree/master/contrib/completion
source $DOTFILESDIR/git-completion.sh

# from https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
source $DOTFILESDIR/git-prompt.sh

# VAGRANT
alias vgs='vagrant global-status'

# SIMPLE SERVERS
# alias serve='python -m http.server 8000 --bind localhost'
alias serve='http-server'
alias pserve='php -S localhost:8000'

# HELPERS

# Open new tab
source $DOTFILESDIR/tab.bash


function whichp(){
  for var in "$@"
  do
    lsof -n -i :$var | grep LISTEN
  done
}

# usage `killp 4000`
function killp(){
  for var in "$@"
  do
    lsof -n -i :$var | grep LISTEN | awk '{print $2}' | xargs kill -9
  done
}

function openp (){
  open http://localhost:$1
}


# GENERAL
alias ls='ls -F'
alias ll='ls -l -h'
alias la='ls -a'

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
