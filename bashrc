#!/bin/bash

[ -z "$PS1" ] && return    # If not running interactively, don't do anything

#==============================================================================
# SETTINGS
#==============================================================================

export EDITOR=vim                  # editor
PS1="\u@\e[0;32m\h\e[m:\w\$ "      # prompt
HISTCONTROL=ignoredups:ignorespace # don't duplicate lines in history
HISTSIZE=1000                      # history length
HISTFILESIZE=2000

shopt -s histappend                # append to history, don't overwrite it
shopt -s checkwinsize              # dynamically update the values of LINES and COLUMNS

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"  # make less more friendly for non-text input files, see lesspipe(1)

stty stop undef     # stop <C-s> being swallowed by xterm
stty start undef    # stop <C-q> being swallowed by xterm

#==============================================================================
# ALIASES
#==============================================================================

if [ -x /usr/bin/dircolors ]; then  # enable color support of ls and grep
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias less='less -r'

alias ll='ls -Al'
alias la='ls -A'

alias h=history

alias vimvim="vim -c EditVim"
alias vimbash="vim -c EditBash"

alias tmux="TERM=xterm-256color tmux"
