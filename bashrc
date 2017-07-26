#!/bin/bash

[ -z "$PS1" ] && return    # If not running interactively, don't do anything

#==============================================================================
# SETTINGS
#==============================================================================

export EDITOR=vim                       # editor
PS1="\u@\[\e[0;32m\]\h\[\e[m\]\w\$ "    # prompt
HISTCONTROL=ignoredups:ignorespace      # don't duplicate lines in history
HISTSIZE=1000                           # history length
HISTFILESIZE=2000
export HH_CONFIG=hicolor,rawhistory

shopt -s histappend                # append to history, don't overwrite it
shopt -s checkwinsize              # dynamically update the values of LINES and COLUMNS

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"  # make less more friendly for non-text input files, see lesspipe(1)

stty stop undef     # stop <C-s> being swallowed by xterm
stty start undef    # stop <C-q> being swallowed by xterm

#==============================================================================
# PATH MANIPULATION
#==============================================================================

append_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

prepend_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

#==============================================================================
# ANDROID
#==============================================================================

if [ -d "$HOME/android" ]; then
  append_path "$HOME/android/tools"
  append_path "$HOME/android/platform-tools"
fi

#==============================================================================
# GO
#==============================================================================

if [ -d "$HOME/go" ]; then
  export GOPATH=$HOME/go
  append_path "$GOPATH/bin"
fi

if [ -d "/usr/local/go" ]; then
  append_path "/usr/local/go/bin"
fi

#==============================================================================
# AWS ENVIRONMENT
#==============================================================================

if [ -d "$HOME/.aws" ]; then
  if [ -e "$HOME/.aws/aws_access_key" ]; then
    export AWS_ACCESS_KEY=`cat $HOME/.aws/aws_access_key`
  fi
  if [ -e "$HOME/.aws/aws_secret_key" ]; then
    export AWS_SECRET_KEY=`cat $HOME/.aws/aws_secret_key`
  fi
fi

#==============================================================================
# DIGITAL OCEAN ENVIRONMENT
#==============================================================================

if [ -d "$HOME/.digitalocean" ]; then
  if [ -e "$HOME/.digitalocean/do_access_token" ]; then
    export DO_ACCESS_TOKEN=`cat $HOME/.digitalocean/do_access_token`
  fi
  if [ -e "$HOME/.digitalocean/do_client_id" ]; then
    export DO_CLIENT_ID=`cat $HOME/.digitalocean/do_client_id`
  fi
  if [ -e "$HOME/.digitalocean/do_api_key" ]; then
    export DO_API_KEY=`cat $HOME/.digitalocean/do_api_key`
  fi
fi

#==============================================================================
# BUNDLER/RUBY HELPERS
#==============================================================================

alias bi='bundle install'
alias be='bundle exec'
alias rg='be rails generate'
alias rr='be rake routes'
alias rt='be rake test'
alias rit='be ruby -Itest -Ilib -Iapp'

alias fs='foreman start -p 3000'
alias fr='foreman run'

function rs()
{
  be rails server -b 0.0.0.0
}

function rc()
{
  be rails console
}

#==============================================================================
# GIT & MERCURIAL HELPERS
#==============================================================================

alias gs='git status'
alias gr='git pull --rebase'
alias gb='git branch -a'
alias gl='git log --graph --all --decorate'
alias gd='git diff HEAD'
alias gp='git pull --ff-only'
alias gf='git fetch'
alias gc='git reset --hard'

alias hgs='hg status'
alias hgb='hg branches -a'
alias hgl='hg log'
alias hgr='hg recent'
alias hgd='hg diff'
alias hgp='hg pull && hg update'

#==============================================================================
# NODE HELPERS
#==============================================================================

alias ni='npm install'
alias nt='npm run test'
alias ns='npm run start'
alias nb='npm run build'
alias nr='npm run'

#==============================================================================
# ELIXIR/MIX HELPERS
#==============================================================================

alias imix='iex -S mix'
alias mps='mix phoenix.server'
alias mpr='mix phoenix.routes'
alias mi='mix deps.get'

dmix() {
  iex --name `hostname`@127.0.0.1 --cookie debug --erl "-kernel inet_dist_listen_min 9001 inet_dist_listen_max 9001" -S mix $1
}

dtunnel() {
  ssh -N -L 9001:localhost:9001 -L 4369:localhost:4369 ${1:-jake@192.168.56.100}
}

dobserve() {
  erl -name `hostname`@127.0.0.1 -setcookie debug -run observer
}

#==============================================================================
# PYTHON HELPERS
#==============================================================================

alias pss='python -m SimpleHTTPServer'

#==============================================================================
# KUBERNETES HELPERS
#==============================================================================

alias kc='kubectl'
alias kcs='kubectl --namespace=kube-system'

#==============================================================================
# OTHER ALIASES
#==============================================================================

if [ -x /usr/bin/dircolors ]; then  # enable color support of ls and grep
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias c='clear'
alias less='less -r'

alias ll='ls -Al'
alias la='ls -A'

alias h=history

alias vimvim="vim -c EditVim"
alias vimbash="vim -c EditBash"

alias tmux="TERM=xterm-256color tmux"

alias api='cd ~/api'
alias www='cd ~/www'
alias demo='cd ~/demo'
alias up='cd ~/up'

alias ci='ssh ci'
alias lp='ssh lp'

app() {
  if [ -d "$HOME/app" ]; then
    cd "$HOME/app"
  elif [ -d "$HOME/application" ]; then
    cd "$HOME/application"
  fi
}

dev() {
  if [ -d "$HOME/dev" ]; then
    cd "$HOME/dev"
  elif [ -d "$HOME/development" ]; then
    cd "$HOME/development"
  fi
}

ops() {
  if [ -d "$HOME/ops" ]; then
    cd "$HOME/ops"
  elif [ -d "$HOME/operations" ]; then
    cd "$HOME/operations"
  fi
}

services() {
  if [ -d "$GOPATH/src/github.com/chemistrygroup/services" ]; then
    cd "$GOPATH/src/github.com/chemistrygroup/services"
  fi
}

#==============================================================================
# BUILDING DEBIAN PACKAGES (http://packaging.ubuntu.com/html/getting-set-up.html#configure-your-shell)
#==============================================================================
export DEBFULLNAME="Jake Gordon"
export DEBEMAIL="jake@codeincomplete.com"

#==============================================================================

if type brew > /dev/null 2>&1; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi
