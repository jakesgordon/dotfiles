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
# LOAD ASDF (if present)
#==============================================================================

if [ -d "$HOME/.asdf/shims" ]; then
  prepend_path "$HOME/.asdf/shims"
  . <(asdf completion bash)
fi

#==============================================================================
# LOCAL BIN
#==============================================================================

if [ -d "$HOME/.local/bin" ]; then
  append_path "$HOME/.local/bin"
fi

#==============================================================================
# JUST
#==============================================================================

if [ -x "$(command -v just)" ]; then
  . <(just --completions bash)
  alias j='just'
  alias ji='just install'
  alias js='just start'
  alias jb='just build'
  alias jt='just test'
  alias jl='just lint'
  alias jf='just format'
  alias jc='just cover'
  alias jj='just jake'
  alias jdb='just db'
  alias jrd='just run-detective'
  alias jrp='just run-pitchable'
  complete -F _just -o bashdefault -o default j
fi

#==============================================================================
# BAT
#==============================================================================

if [ -x "$(command -v batcat)" ]; then
  alias bat='batcat'
fi

#==============================================================================
# FD and FZF
#==============================================================================

if [ -x "$(command -v fdfind)" ]; then
  alias fd=fdfind
fi

if [ -x "$(command -v fzf)" ]; then
  export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git --ignore-file .gitignore"
  export FZF_DEFAULT_OPTS=""
fi

#==============================================================================
# RIPGREP
#==============================================================================

if [ -e "$HOME/.ripgreprc" ]; then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
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
# DOTNET
#==============================================================================

if [ -d "$HOME/.dotnet/tools" ]; then
  append_path "$HOME/.dotnet/tools"
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
# GRIP TOKEN
#==============================================================================

if [ -e "$HOME/.grip-token" ]; then
  export GRIP_TOKEN=`cat $HOME/.grip-token`
fi

alias grip='grip --user=jakesgordon --pass=$GRIP_TOKEN'

#==============================================================================
# GIT HELPERS
#==============================================================================

alias gs='git status'
alias gc='git commit'
alias gb='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gl='git log --graph --all --decorate'
alias gd='git diff HEAD --color'
alias gp='git pull -p'
alias gf='git fetch'
alias gap='git add -p'
alias gpush='git push'
alias gcancel='git reset --hard'

#==============================================================================
# RUST HELPERS
#==============================================================================
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'

if [ -d "$HOME/.cargo/bin" ]; then
  append_path "$HOME/.cargo/bin"
fi

#==============================================================================
# NODE and BUN HELPERS
#==============================================================================

alias ni='npm install'
alias nr='npm run'
alias ns='npm run start'
alias nb='npm run build'
alias nt='npm run test'
alias nl='npm run lint'
alias nf='npm run format'

alias bi='bun install'
alias br='bun run'
alias bs='bun run start'
alias bb='bun run build'
alias bt='bun run test'
alias bl='bun run lint'
alias bf='bun run format'

if [ -d "$HOME/.bun/bin" ]; then
  append_path "$HOME/.bun/bin"
fi

if [ -d "$HOME/.npm-global/bin" ]; then
  append_path "$HOME/.npm-global/bin"
fi

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

#==============================================================================
# PYTHON HELPERS
#==============================================================================

alias pss='python3 -m http.server'
alias py='python3'
alias pr='poetry run'
alias prp='poetry run python'
alias prt='poetry run pytest'

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

alias v='vim'
alias c='clear'
alias less='less -r'
alias ll='ls -Al'
alias la='ls -A'
alias ps='ps xawf'

alias vimvim="vim -c EditVim"
alias vimbash="vim -c EditBash"

alias ports='sudo lsof -i -P -n'
alias ubuntu='lsb_release -a'
alias kernel='uname -r'

alias ae='cd ~/andthen/ensemble'
alias aed='cd ~/andthen/ensemble/experiences/detective'
alias aep='cd ~/andthen/ensemble/experiences/pitchable'
alias aec='cd ~/andthen/ensemble/experiences/change-my-mind'
alias ci='cd ~/codeincomplete'
alias dot='cd ~/.dotfiles'
alias provision='cd ~/.provision'
alias id='cd ~/id'
alias fancytop=bpytop
alias ftop=bpytop

alias no-color='sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"'

dotenv() {
  set -o allexport
  source ${1:-.env}
  set +o allexport
}

alias pgr='pg_restore --verbose --clean --no-acl --no-owner -h localhost'

#==============================================================================
# BUILDING DEBIAN PACKAGES (http://packaging.ubuntu.com/html/getting-set-up.html#configure-your-shell)
#==============================================================================
export DEBFULLNAME="Jake Gordon"
export DEBEMAIL="jakesgordon@gmail.com"

export FLYCTL_INSTALL="$HOME/.fly"
if [ -d "$FLYCTL_INSTALL" ]; then
  append_path "$FLYCTL_INSTALL/bin"
fi

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
