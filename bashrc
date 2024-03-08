#!/bin/bash

[ -z "$PS1" ] && return    # If not running interactively, don't do anything

#==============================================================================
# SETTINGS
#==============================================================================

export EDITOR=vim                              # editor
PS1="\u@\[\e[0;32m\]\h\[\e[m\]\w\$ "           # prompt
shopt -s checkwinsize                          # dynamically update the values of LINES and COLUMNS
export BASH_SILENCE_DEPRECATION_WARNING=1      # stop macOS Catalina from trying to get me to upgrade to zshell

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"  # make less more friendly for non-text input files, see lesspipe(1)

stty stop undef     # stop <C-s> being swallowed by xterm
stty start undef    # stop <C-q> being swallowed by xterm

#===================================================================
# KEEP RUN-TIME TRACK OF CWD SO NEW TERMINALS CAN OPEN IN SAME PLACE
#===================================================================

if [ ! -z "$XDG_RUNTIME_DIR" ]; then
  PROMPT_COMMAND='pwd > "${XDG_RUNTIME_DIR}/most-recent-directory"'
  if [ -f "$XDG_RUNTIME_DIR/most-recent-directory" ]; then
    cd `cat $XDG_RUNTIME_DIR/most-recent-directory`
  fi
fi

#==============================================================================
# LOAD SECRETS INTO ENVIRONMENT (if any)
#==============================================================================

if [ -f $HOME/.env ]; then
  . $HOME/.env
fi

#==============================================================================
# HISTORY (extended with hh from dvorka/hstr)
#==============================================================================

shopt -s histappend                            # append to history, don't overwrite it
export HISTCONTROL=ignoredups:ignorespace      # don't duplicate lines in history
export HISTSIZE=10000                          # history length
export HISTFILESIZE=10000
export HH_CONFIG=hicolor,prompt-bottom

if [ -x "$(command -v hh)" ]; then
  alias h=hh
  if [[ $- =~ .*i.* ]]; then
    bind '"\C-r": "\C-a hh -- \C-j"';
  fi
  # export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
else
  alias h=history
fi

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
# BAT
#==============================================================================

if [ -x "$(command -v batcat)" ]; then
  alias cat=batcat
fi

#==============================================================================
# NCDU
#==============================================================================

if [ -x "$(command -v ncdu)" ]; then
  alias du="ncdu --hide-hidden"
fi

#==============================================================================
# FD and FZF
#==============================================================================

if [ -x "$(command -v fdfind)" ]; then
  alias fd=fdfind
fi

if [ -x "$(command -v fzf)" ]; then
  export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
  export FZF_DEFAULT_OPTS=""
fi

#==============================================================================
# RIPGREP
#==============================================================================

if [ -e "$HOME/.ripgreprc" ]; then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

#==============================================================================
# PGCLI
#==============================================================================

if [ -x "$(command -v pgcli)" ]; then
  alias psql=pgcli
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
# FLUTTER
#==============================================================================

if [ -d "/usr/local/bin/flutter/bin" ]; then
  append_path "/usr/local/bin/flutter/bin"
fi

#==============================================================================
# YARN
#==============================================================================

if [ -d "$HOME/.yarn/bin" ]; then
  append_path "$HOME/.yarn/bin"
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
# GRIP TOKEN
#==============================================================================

if [ -e "$HOME/.grip-token" ]; then
  export GRIP_TOKEN=`cat $HOME/.grip-token`
fi

alias grip='grip --user=jakesgordon --pass=$GRIP_TOKEN'

#==============================================================================
# BUNDLER/RUBY/RAILS HELPERS
#==============================================================================

alias bi='bundle install'
alias be='bundle exec'
alias routes='be rake routes'
alias rt='be rake test'
alias rit='be ruby -Itest -Ilib -Iapp'
alias rs='be rails server -b 0.0.0.0'
alias rc='be rails console'
alias fs='foreman start'
alias fr='foreman run'

#==============================================================================
# GIT & MERCURIAL HELPERS
#==============================================================================

alias gs='git status'
alias gr='git pull --rebase'
alias gb='git branch -a'
alias gl='git log --graph --all --decorate'
alias gd='git diff HEAD --color'
alias gp='git pull'
alias gf='git fetch'
alias gc='git reset --hard'

alias hs='hg status'
alias hb='hg branches -a'
alias hl='hg log'
alias hr='hg recent'
alias hd='hg diff'
alias hp='hg pull && hg update'

#==============================================================================
# RUST HELPERS
#==============================================================================
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'

#==============================================================================
# MAKE HELPERS
#==============================================================================

# replaced with MIX helpers (below)

# alias mt='make test'
# alias mr='make run'
# alias md='make deps'
# alias mi='make install'
# alias mw='make watch'
# alias mb='make build'
# alias ml='make lint'
# alias mc='make cover'

#==============================================================================
# DENO HELPERS
#==============================================================================

alias dt='deno task --quiet'
alias dtc='dt console'
alias dts='dt start'
alias dtt='dt test'
alias dtf='dt fmt'
alias dtl='dt lint'
alias dtdb='dt db'
alias dr='deno run'

alias v='cd ~/void'
alias vc='cd ~/void/cloud'
alias cloud='cd ~/void/cloud'
alias sdk='cd ~/void/sdk'
alias app='cd ~/void/app'
alias snakes='cd ~/void/snakes'
alias tiny='cd ~/void/tiny-platformer'

#==============================================================================
# NODE and YARN HELPERS
#==============================================================================

alias ni='npm install'
alias nt='npm run test'
alias ns='npm run start'
alias nb='npm run build'
alias nr='npm run'

alias yi='yarn install'
alias yr='yarn run'
alias ys='yarn start'
alias yt='yarn test'
alias yl='yarn lint'
alias yb='yarn build'
alias yw='yarn watch'
alias yc='yarn cover'

alias ysi='yarn server:install'
alias yss='yarn server:start'
alias yst='yarn server:test'
alias ysl='yarn server:lint'
alias ysc='yarn server:cover'
alias ycs='yarn client:start'
alias yct='yarn client:test'
alias ycl='yarn client:lint'
alias ycc='yarn client:cover'

alias yscd='yarn server:cover:detail'
alias ystw='yarn server:test:watch'
alias yctw='yarn client:test:watch'
alias yclw='yarn client:lint:watch'

export NODE_OPTIONS=--max-old-space-size=4096

#==============================================================================
# ELIXIR/MIX HELPERS
#==============================================================================

alias imix='iex -S mix'

alias ms='mix server'
alias mr='mix run --no-halt'
alias md='mix deps.get'
alias mi='mix deps.get'
alias mt='mix test'
alias mtw='mix test.watch'
alias mb='mix build'
alias mc='mix compile'
alias ml='mix lint'
alias mcov='mix cover'
alias mcovd='mix cover.detail'
alias mrdb='mix resetdb'
alias mtdb='mix testdb'

dmix() {
  iex --name `hostname`@127.0.0.1 --cookie debug --erl "-kernel inet_dist_listen_min 9001 inet_dist_listen_max 9001" -S mix $1
}

dtunnel() {
  ssh -N -L 9001:localhost:9001 -L 4369:localhost:4369 ${1:-jake@192.168.56.100}
}

dobserve() {
  erl -name `hostname`@127.0.0.1 -setcookie debug -run observer
}

alias ports='sudo lsof -i -P -n'
alias ubuntu='lsb_release -a'

#==============================================================================
# PYTHON HELPERS
#==============================================================================

alias pss='python3 -m http.server'
alias py='python3'
alias pye='source ./env/bin/activate'

if [ -d "$HOME/.local/bin" ]; then
  append_path "$HOME/.local/bin"
fi

#==============================================================================
# DOCKER HELPERS
#==============================================================================

alias dc='docker-compose'

#==============================================================================
# KUBERNETES HELPERS
#==============================================================================

alias kc='kubectl'
alias kcc='kubectl config'
alias kck='kubectl kustomize'
alias kcs='kubectl --namespace=kube-system'
alias kx='kubectx'
alias kn='kubens'

alias kube-debug='kubectl run jake-debug-shell --generator=run-pod/v1 --rm -i --tty --image busy-box -- sh'

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

if hash lsd 2>/dev/null; then
  alias ls='lsd'
fi

if hash dog 2>/dev/null; then
  alias dig='dog'
fi

alias c='clear'
alias less='less -r'
alias ll='ls -Al'
alias la='ls -A'
alias ps='ps xawf'

alias vimvim="vim -c EditVim"
alias vimbash="vim -c EditBash"

alias ci='cd ~/codeincomplete'
alias dot='cd ~/.dotfiles'
alias provision='cd ~/.provision'
alias tmp='cd ~/tmp'
alias icc='cd ~/icc'
alias fw='cd ~/firewatch'
alias oz='cd ~/ozeki'
alias fancytop=bpytop

alias netflix='/opt/google/chrome/chrome --app=https://netflix.com'

alias no-color='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"'

dotenv() {
  set -o allexport
  source ${1:-.env}
  set +o allexport
}

alias pgr='pg_restore --verbose --clean --no-acl --no-owner -h localhost'

#==============================================================================
# LOAD ASDF (if present)
#==============================================================================

if [ -f $HOME/.asdf/asdf.sh ]; then
  . $HOME/.asdf/asdf.sh
fi

if [ -f $HOME/.asdf/completions/asdf.bash ]; then
  . $HOME/.asdf/completions/asdf.bash
fi

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

if type git > /dev/null 2>&1; then
  if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    # GIT_PROMPT_THEME=Solarized
    GIT_PROMPT_THEME=Single_line_Dark
    source ~/.bash-git-prompt/gitprompt.sh
  fi
fi

