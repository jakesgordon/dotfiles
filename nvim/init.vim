" =======
" PLUGINS
" =======

packadd minpac
call minpac#init()
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('jremmen/vim-ripgrep')
call minpac#add('junegunn/fzf')
call minpac#add('kien/ctrlp.vim')
call minpac#add('mhinz/vim-startify')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-projectionist')
call minpac#add('maxbrunsfeld/vim-yankstack')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-omni.vim')
call minpac#add('andreypopp/asyncomplete-ale.vim')
" ============================
" PROGRAMMING LANGUAGE PLUGINS
" ============================
call minpac#add('dense-analysis/ale')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('fatih/vim-go')
call minpac#add('rust-lang/rust.vim')
call minpac#add('posva/vim-vue')
call minpac#add('hail2u/vim-css3-syntax')
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('pangloss/vim-javascript')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('stephpy/vim-yaml')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('peitalin/vim-jsx-typescript')
call minpac#add('OmniSharp/omnisharp-vim')
call minpac#add('NoahTheDuke/vim-just')
command! InstallPlugins :call minpac#update()

"=================
" GENERAL SETTINGS
"=================

syntax on               " enable syntax highlighting
filetype plugin on      " enable per-filetype plugins

set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set backup                          " keep a backup file
set backupcopy=yes                  " use overwrite strategy for backups (to avoid issues with node file watchers)
set backupdir=~/.backup             " custom backup directory
set ch=3                            " set command line 3 lines high
set colorcolumn=100                 " highlight the 120th column
set completeopt=menu,menuone,preview,noselect,noinsert
set expandtab                       " expand tabs to spaces
set exrc                            " enable per-project .vimrc files in a secure way - https://andrew.stwrt.ca/posts/project-specific-vimrc/
set gdefault                        " replace all instances on line when doing global search/replace
set hidden                          " allow hidden buffers with unsaved changes
set hlsearch                        " highlight search terms
set ignorecase                      " case insensitive search by default
set incsearch                       " do incremental searching
set laststatus=2                    " always put a status line in.
set nofoldenable                    " disable code folding (I find it annoying)
set nowrap                          " no line wrapping
set number                          " enable line numbers
set ruler                           " show the cursor position all the time
set scrolloff=10                    " start scrolling 10 lines from the top/bottom
set secure                          " enable per-project .vimrc files in a secure way - https://andrew.stwrt.ca/posts/project-specific-vimrc/
set shiftwidth=2                    " indent action = 2 spaces
set showcmd                         " display incomplete commands
set showmatch                       " show matching parens
set showmode                        " so you know what mode you are in
set smartcase                       " do case sensitive search if search term contains uppercase
set softtabstop=2                   " soft tabs = 2 spaces 
set tabstop=2                       " tabs = 2 spaces
set timeoutlen=1000                 " timeout on mappings after 1 second
set ttimeoutlen=0                   " timeout on key codes immediately (to avoid pause after ESC)
set virtualedit+=block              " allow virtual-block select to go past end of lines
set whichwrap+=<,>,[,]              " allow arrow keys to line wrap
set wildignore+=*.o,*.a,*.d,*.gch   " (ditto)
set wildignore+=*.pui,*.prj         " ignore these when completing file or directory names
set wildignore+=*.svn,*.git         " (ditto)
set wildignore+=*.swp               " (ditto)
set wildignore+=_build              " (ditto)
set wildignore+=bin,gen             " (ditto)
set wildignore+=deps                " (ditto)
set wildignore+=node_modules        " (ditto)
set wildignore+=tmp                 " (ditto)
set wildignore+=vendor              " (ditto)
set wildmenu                        " enable enhanced command line completion
set wildmode=longest,list           " and show bash like auto complete list

" COLOR SCHEME
" ============

set termguicolors
set background=light
colorscheme solarized8
let g:airline_theme="solarized"

" LEADER KEYS
" ===========

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :OmniSharpCodeFormat<CR>
nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>r :CtrlPMRU<CR>
nnoremap <Leader>g :ALEGoToDefinition<CR>

nnoremap <Leader>d :set background=dark<CR>:colorscheme nord<CR>
nnoremap <Leader>l :set background=light<CR>:colorscheme solarized8<CR>

vmap <leader>Y "+y
nmap <leader>P "+P
nmap <leader>p <Plug>yankstack_substitute_older_paste

" FUNCTION KEYS
" =============

" nnoremap <F5>    :wa<CR>:Make<CR>
" nnoremap <F6>    :wa<CR>:Make clean<CR>:Make<CR>
" nnoremap <F7>    :wa<CR>:Make test<CR>
" nnoremap <F8>    :wa<CR>:Make run<CR>
nnoremap <F12>   :noh<CR>:cclose<CR>:syntax sync fromstart<CR>

" QUICK SAVE
" ==========

noremap  <C-s> :wa<CR>
inoremap <C-s> <Esc>:wa<CR>
noremap  <C-q> :qa<CR>
inoremap <C-q> <Esc>:qa<CR>

" QUICK ENTRY INTO INSERT MODE
" ============================

nnoremap <Space> i<Space>
nnoremap <Del>   i<Del>

" WINDOW MANAGEMENT
" =================

nnoremap _         <C-W>s<C-W><Down>
nnoremap <Bar>     <C-W>v<C-W><Right>
nnoremap <C-x>     <C-w>c
nnoremap <C-w>-   5<C-w>-
nnoremap <C-w>_   5<C-w>-
nnoremap <C-w>+   5<C-w>+
nnoremap <C-w>=   5<C-w>+
nnoremap <C-w><  10<C-w><
nnoremap <C-w>>  10<C-w>>
nnoremap <C-w>,  10<C-w><
nnoremap <C-w>.  10<C-w>>

" QUICKFIX WINDOW SHORTCUTS
" =========================

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

" FORCE ME TO USE HJKL INSTEAD OF ARROWS
" ======================================

" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" vnoremap <up> <nop>
" vnoremap <down> <nop>
" vnoremap <left> <nop>
" vnoremap <right> <nop>

" CUSTOM COMMANDS
" ===============
command EditVim  :edit   ~/.config/nvim/init.vim
command EditBash :edit   ~/.bashrc

" Customize NERD tree
" ===================
let NERDTreeIgnore=['\~$', '\.swp$', '^gen$', '^bin$', '^obj$', 'node_modules', '^_build', '^deps' ]

" Customize vim-ripgrep
" =====================
let g:rg_highlight = 1
let g:rg_command = 'rg --vimgrep --color=never'

" Customize FZF
" ===================
" - Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.5, 'relative': v:true, 'yoffset': 1.0 } }

" Customize CtrlP
" ===============
let g:ctrlp_max_height = 20
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = [ '.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f' ]

" Customize Airline
" =================
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_section_y = ""

" Customize startify
" ==================
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_change_to_dir = 0
let g:startify_padding_left = 10

" Customize ALE
" =============
let g:ale_completion_enabled = 1
let g:ale_linters = {
 \ "javascript": ["eslint", "tslint", "standard", "tsserver", "typecheck", "xo"],
 \ "typescript": ["eslint", "tslint", "standard", "tsserver", "typecheck", "xo"],
 \ "typescriptreact": ["eslint", "tslint", "standard", "tsserver", "typecheck", "xo"],
 \ "rust": ["analyzer"],
 \ "cs": ["OmniSharp"],
 \ "go": ["gofmt", "govet", "staticcheck"],
 \ }
let g:ale_fixers = {
 \ "cs": ["omnisharp-fixer"],
 \ "go": ["gofmt"],
 \ }

function! OmniSharpFixer(buffer) abort
  OmniSharpCodeFormat
endfunction

call ale#fix#registry#Add('omnisharp-fixer', 'OmniSharpFixer', ['cs'], 'Use OmniSharpCodeFormat as your ALE fixer')

let g:ale_fix_on_save = 0
augroup ale_go_fix
  autocmd!
  autocmd FileType go let b:ale_fix_on_save = 1
augroup END

" DENO STUFF
" ==========

function! FindDenoJsonc(path)
    " Check if we're at the root (/ or C:\):
    if a:path == '/' || a:path =~ '^[A-Z]:\\$'
        return 0
    endif

    " Check for deno.jsonc in the current path
    if filereadable(a:path . '/deno.jsonc')
        return 1
    endif

    " Recurse up the directory tree
    let parent = fnamemodify(a:path, ':h')
    return FindDenoJsonc(parent)
endfunction

" Auto command to set makeprg if deno.jsonc is found in any parent directory
autocmd BufRead,BufNewFile *.ts,*.tsx,*.js*.jsx if FindDenoJsonc(expand('%:p:h'))
    \ | let b:isdeno = 1
    \ | let b:ale_linters = {
    \     "typescript": ["deno", "cspell", "eslint", "tslint", "standard", "typecheck", "xo"],
    \     "typescriptreact": ["deno", "cspell", "eslint", "tslint", "standard", "typecheck", "xo"],
    \     }
    \ | else
    \ | let b:isdeno = 0
    \ | let b:ale_linters = {
    \     "typescript": ["cspell", "eslint", "tslint", "standard", "tsserver", "typecheck", "xo"],
    \     "typescriptreact": ["cspell", "eslint", "tslint", "standard", "tsserver", "typecheck", "xo"],
    \     }
    \ | endif

" ======================
" DOTNET OMNISHARP STUFF
" ======================
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_server_use_mono = 0
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'

augroup omnisharp_commands
  autocmd!

  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)

  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
augroup END

"=====================
" ASYNC COMPLETE STUFF
"=====================
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

au User asyncomplete_setup call asyncomplete#ale#register_source({
 \ 'name': 'reason',
 \ 'linter': 'flow',
 \ })

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1

augroup asyncomplete_omnifunc_go
  autocmd!
  autocmd FileType go call asyncomplete#register_source({
    \ 'name': 'omni',
    \ 'allowlist': ['go'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#omni#completor'),
    \ 'trigger_patterns': {
    \   'go': ['\.\w*']
    \ },
    \ })
augroup END

let g:go_fmt_autosave = 0

" MISCELLANEOUS
" =============

" disable auto-comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" remove comment leader when joining comment lines
autocmd FileType * setlocal formatoptions+=j

" ensure elixir filetypes are detected correctly
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
