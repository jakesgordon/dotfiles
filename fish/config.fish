if status is-interactive

  #==============================================================================
  # COMMON VARIABLES
  #==============================================================================

  set -gx EDITOR nvim

  #==============================================================================
  # ADDITIONAL PATHS
  #==============================================================================

  if test -d "$HOME/.asdf/shims"
    fish_add_path -p "$HOME/.asdf/shims"
  end

  if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
  end

  if test -d "$HOME/.bun/bin"
    fish_add_path "$HOME/.bun/bin"
  end

  if test -d "$HOME/.npm-global/bin"
    fish_add_path "$HOME/.npm-global/bin"
  end

  if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
  end

  if test -d "$HOME/.dotnet/tools"
    fish_add_path "$HOME/.dotnet/tools"
  end

  if test -d "/usr/local/go/bin"
    fish_add_path "/usr/local/go/bin"
  end

  #==============================================================================
  # COMMON ALIASES
  #==============================================================================

  abbr v    'nvim'
  abbr vim  'nvim'
  abbr c    'clear'
  abbr less 'less -r'
  abbr ps   'ps xawf'

  abbr vimvim   'nvim -c EditVim'
  abbr vimbash  'nvim -c EditBash'
  abbr ports    'sudo lsof -i -P -n'
  abbr ubuntu   'lsb_release -a'
  abbr kernel   'uname -r'
  abbr fancytop 'bpytop'
  abbr ftop     'bpytop'

  abbr ci        'cd ~/codeincomplete'
  abbr dot       'cd ~/.dotfiles'
  abbr provision 'cd ~/.provision'
  abbr id        'cd ~/id'
  abbr ae        'cd ~/andthen/ensemble'
  abbr aed       'cd ~/andthen/ensemble/experiences/detective'
  abbr aep       'cd ~/andthen/ensemble/experiences/pitchable'
  abbr aec       'cd ~/andthen/ensemble/experiences/change-my-mind'

  #==============================================================================
  # LSD
  #==============================================================================

  if type -q lsd
    abbr ls 'lsd'
    abbr ll 'lsd -Al'
  end

  #==============================================================================
  # GIT
  #==============================================================================

  if type -q git
    abbr gs      'git status'
    abbr gc      'git commit'
    abbr gb      'git branch -a'
    abbr gbd     'git branch -d'
    abbr gbD     'git branch -D'
    abbr gl      'git log --graph --all --decorate'
    abbr gd      'git diff HEAD --color'
    abbr gp      'git pull -p'
    abbr gf      'git fetch'
    abbr gap     'git add -p'
    abbr gpush   'git push'
    abbr gcancel 'git reset --hard'
  end

  #==============================================================================
  # JUST
  #==============================================================================

  if type -q just
    abbr j   'just'
    abbr ji  'just install'
    abbr js  'just start'
    abbr jb  'just build'
    abbr jt  'just test'
    abbr jl  'just lint'
    abbr jf  'just format'
    abbr jc  'just cover'
    abbr jj  'just jake'
    abbr jdb 'just db'
    abbr jrd 'just run-detective'
    abbr jrp 'just run-pitchable'
  end

  #==============================================================================
  # NODE and BUN
  #==============================================================================

  if type -q npm
    abbr ni 'npm install'
    abbr nr 'npm run'
    abbr ns 'npm run start'
    abbr nb 'npm run build'
    abbr nt 'npm run test'
    abbr nl 'npm run lint'
    abbr nf 'npm run format'
  end

  if type -q bun
    abbr bi 'bun install'
    abbr br 'bun run'
    abbr bs 'bun run start'
    abbr bb 'bun run build'
    abbr bt 'bun run test'
    abbr bl 'bun run lint'
    abbr bf 'bun run format'
  end

  #==============================================================================
  # PYTHON
  #==============================================================================

  if type -q python
    abbr py  'python'
    abbr pss 'python -m http.server'
  end

  if type -q poetry
    abbr pr  'poetry run'
    abbr prp 'poetry run python'
    abbr prt 'poetry run pytest'
  end

  #==============================================================================
  # ELIXIR/MIX
  #==============================================================================

  if type -q mix
    abbr imix  'iex -S mix'
    abbr ms    'mix server'
    abbr mr    'mix run --no-halt'
    abbr md    'mix deps.get'
    abbr mi    'mix deps.get'
    abbr mt    'mix test'
    abbr mtw   'mix test.watch'
    abbr mb    'mix build'
    abbr mc    'mix compile'
    abbr ml    'mix lint'
    abbr mcov  'mix cover'
    abbr mcovd 'mix cover.detail'
    abbr mrdb  'mix resetdb'
    abbr mtdb  'mix testdb'
  end

  #==============================================================================
  # RUST
  #==============================================================================

  if type -q cargo
    abbr cb 'cargo build'
    abbr cr 'cargo run'
    abbr ct 'cargo test'
  end

  #==============================================================================
  # POSTGRES
  #==============================================================================

  if type -q pg_restore
    abbr pgr 'pg_restore --verbose --clean --no-acl --no-owner -h localhost'
  end

  #==============================================================================
  # DOCKER
  #==============================================================================

  if type -q docker-compose
    abbr dc 'docker-compose'
  end

  #==============================================================================
  # AWS ENVIRONMENT
  #==============================================================================

  if test -d "$HOME/.aws"
      if test -e "$HOME/.aws/aws_access_key"
          set -gx AWS_ACCESS_KEY (cat $HOME/.aws/aws_access_key)
      end
      if test -e "$HOME/.aws/aws_secret_key"
          set -gx AWS_SECRET_KEY (cat $HOME/.aws/aws_secret_key)
      end
  end

# #==============================================================================
# # FD and FZF
# #==============================================================================
#
# if [ -x "$(command -v fdfind)" ]; then
#   alias fd=fdfind
# fi
#
# if [ -x "$(command -v fzf)" ]; then
#   export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git --ignore-file .gitignore"
#   export FZF_DEFAULT_OPTS=""
# fi
#
# #==============================================================================
# # RIPGREP
# #==============================================================================
#
# if [ -e "$HOME/.ripgreprc" ]; then
#   export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# fi

end
