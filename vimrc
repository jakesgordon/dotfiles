set nocompatible
filetype off

packadd minpac
call minpac#init()
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('kien/ctrlp.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rails')
" call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-projectionist')
call minpac#add('majutsushi/tagbar')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('maxbrunsfeld/vim-yankstack')
call minpac#add('thinca/vim-localrc')
call minpac#add('kana/vim-textobj-user')
call minpac#add('kana/vim-textobj-entire')
call minpac#add('vim-ruby/vim-ruby')
call minpac#add('fatih/vim-go')
call minpac#add('posva/vim-vue')
call minpac#add('hail2u/vim-css3-syntax')
call minpac#add('elixir-lang/vim-elixir')
call minpac#add('pangloss/vim-javascript')
call minpac#add('plasticboy/vim-markdown')
call minpac#add('stephpy/vim-yaml')
call minpac#add('jremmen/vim-ripgrep')

command! InstallPlugins :call minpac#update()

set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set backup                       " keep a backup file
set backupdir=~/.backup          " custom backup directory
set backupcopy=yes               " use overwrite strategy for backups (to avoid issues with node file watchers)
set history=100                  " keep 100 lines of command line history
set ruler                        " show the cursor position all the time
set showcmd                      " display incomplete commands
set mouse=a                      " enable the mouse
set lazyredraw                   " dont update the display while executing macros
set showmode                     " so you know what mode you are in
set laststatus=2                 " always put a status line in.
set scrolloff=10                 " start scrolling 10 lines from the top/bottom
set ch=2                         " set command line 2 lines high
set nowrap                       " no line wrapping 
set shiftwidth=2                 " round indent actions to multiple of 2
set softtabstop=2                " soft tabs = 2 spaces 
set tabstop=2                    " tabs = 2 spaces
set expandtab                    " expand tabs to spaces
set incsearch                    " do incremental searching
set hlsearch                     " highlight search terms
set ignorecase                   " case insensitive search
set gdefault                     " replace all instances on line when doing global search/replace
set number                       " enable line numbers
set showmatch                    " show matching parens
set hidden                       " allow hidden buffers with unsaved changes
set whichwrap+=<,>,[,]           " allow arrow keys to line wrap
set wildmenu                     " enable enhanced command line completion
set wildmode=longest,list        " and show bash like auto complete list
set wildignore+=*.pui,*.prj      " ignore these when completing file or directory names
set wildignore+=*.svn,*.git      " (ditto)
set wildignore+=*.swp            " (ditto)
set wildignore+=*.o,*.a,*.d,*.gch   " (ditto)
set wildignore+=bin,gen,depends  " (ditto)
set wildignore+=tmp              " (ditto)
set wildignore+=node_modules     " (ditto)
set wildignore+=vendor           " (ditto)
set wildignore+=deps             " (ditto)
set wildignore+=_build           " (ditto)
set ttyfast                      " faster terminal updates
set virtualedit+=block           " allow virtual-block select to go past end of lines
set timeoutlen=1000              " timeout on mappings after 1 second
set ttimeoutlen=0                " timeout on key codes immediately (to avoid pause after ESC)
set colorcolumn=100              " highlight the 100th column
set nofoldenable                 " disable code folding (I find it annoying)

syntax on                        " enable syntax highlighting
filetype plugin on               " enable per-filetype plugins

" Enable True Color
" =================
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"       " see :h xterm-true-color for details
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
colorscheme solarized8
let g:airline_theme="solarized"

" Easy edit/open commands
" =======================
command EditVim  :edit   ~/.vimrc
command EditBash :edit   ~/.bashrc

" Leaders
" =======

nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>g :TagbarToggle<CR>
nnoremap <Leader>r :CtrlPMRU<CR>
nnoremap <Leader>t :CtrlP<CR>

" nnoremap <Leader>d :set background=dark<CR>:colorscheme nord<CR>
nnoremap <Leader>d :set background=dark<CR>:colorscheme solarized8<CR>
nnoremap <Leader>l :set background=light<CR>:colorscheme solarized8<CR>

nnoremap <leader>m  :Make<CR>
nnoremap <leader>ma :Make clean<CR>:Make all<CR>
nnoremap <leader>mt :Make test<CR>
nnoremap <leader>mc :Make clean<CR>
nnoremap <leader>mr :Make run<CR>

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

nmap <Leader><Enter> i<Enter><Esc>

nnoremap <Leader>, :Tabularize /,\zs<CR>
vnoremap <Leader>, :Tabularize /,\zs<CR>
nnoremap <Leader>: :Tabularize /:\zs<CR>
vnoremap <Leader>: :Tabularize /:\zs<CR>
nnoremap <Leader>{ :Tabularize /{<CR>
vnoremap <Leader>{ :Tabularize /{<CR>
nnoremap <Leader>} :Tabularize /}<CR>
vnoremap <Leader>} :Tabularize /}<CR>
vnoremap <Leader>= :Tabularize /=<CR>

nnoremap <Backspace> %

" Function Keys
" =============

nnoremap <F5>    :wa<CR>:Make<CR>
nnoremap <F6>    :wa<CR>:Make clean<CR>:Make<CR>
nnoremap <F7>    :wa<CR>:Make test<CR>
nnoremap <F8>    :wa<CR>:Make run<CR>
nnoremap <F12>   :noh<CR>:cclose<CR>:syntax sync fromstart<CR>

" QuickFix Shortcuts
" ==================

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

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
inoremap jj      <ESC>

" " USE VERY-MAGIC (PERL-STYLE) REGEXP FOR SEARCH
" " =============================================
" nnoremap / /\v
" vnoremap / /\v

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

" Customize vim-ripgrep
" =====================
let g:rg_highlight = 1

" Customize CtrlP
" ===============
let g:ctrlp_max_height = 20
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = 0

" Customize NERD tree
" ===================
let NERDTreeIgnore=['\~$', '\.swp$', '^gen$', '^obj$', 'node_modules', '^_build' ]

" Customize Airline
" =================
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_section_y = ""

" Customize VimRails
" ==================

let g:rails_projections = {
 \   "lib/app/*.rb": { "test": "test/app/%s_test.rb" },
 \   "lib/api/*.rb": { "test": "test/api/%s_test.rb" },
 \   "lib/*.rb":     { "test": "test/lib/%s_test.rb" },
 \   "test/app/*_test.rb": { "alternate": "lib/app/%s.rb" },
 \   "test/api/*_test.rb": { "alternate": "lib/api/%s.rb" },
 \   "test/lib/*_test.rb": { "alternate": "lib/%s.rb" }
 \ }

" force .md files to be considered markdown (not modula-2)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" disable auto-comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" remove comment leader when joining comment lines
autocmd FileType * setlocal formatoptions+=j

" disable autoindent for all file types - it's just far too annoying and never works cleanly
autocmd FileType * setlocal noautoindent nosmartindent nocindent

