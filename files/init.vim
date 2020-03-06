"               _
"              (_)
"    _ ____   ___ _ __ ___
"   | '_ \ \ / / | '_ ` _ \
"   | | | \ V /| | | | | | |
"   |_| |_|\_/ |_|_| |_| |_|
"
"

" Plugins
call plug#begin()
Plug 'drewtempelmeyer/palenight.vim'

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

Plug 'editorconfig/editorconfig-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~40%' }

Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'

Plug 'rbgrouleff/bclose.vim' " nvim dep for ranger
Plug 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language supports
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save=1

Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

call plug#end()

let mapleader = ","
let g:mapleader = ","

" Override clipboard because wl-paste messes up line ending by default
let g:clipboard = {
      \   'name': 'wayland-strip-carriage',
      \   'copy': {
      \      '+': 'wl-copy --foreground --type text/plain',
      \      '*': 'wl-copy --foreground --type text/plain --primary',
      \    },
      \   'paste': {
      \      '+': {-> systemlist('wl-paste | tr -d "\r"')},
      \      '*': {-> systemlist('wl-paste --primary | tr -d "\r"')},
      \   },
      \   'cache_enabled': 1,
      \ }

" Editor settings
set termguicolors
set background=dark
colorscheme palenight
set autoread
set laststatus=2
set clipboard+=unnamedplus
set ignorecase
set smartcase
set hidden
set path+=**
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Text rendering
set conceallevel=0
set encoding=utf8               " character encoding used inside Vim
set fileencoding=utf-8
set fileformats=unix            " end-of-line format
set scrolloff=5                 " minimal lines above and below the cursor.
set linespace=3
set number                      " show absolute line numbers
set backspace=indent,eol,start

" Performance
set lazyredraw                  " screen will not be redrawn while executing macros
set timeoutlen=1000
set ttimeoutlen=10

" Backup and undo files
set nobackup                    " create a permanent backup for a file
set nowritebackup               " create temporary backup for a file
set noswapfile                  " not create swapfiles
set undofile                    " persistent undo
set undodir=~/.config/nvim/undodir      " directory for undofiles

" Indentation and tabs
filetype plugin on
filetype indent on
set autoindent                  " copy indent from current to new line
set smartindent                 " auto indent after '{', before '}', etc.
set expandtab                   " in insert mode use spaces to insert a tab
set smarttab                    " use 'swiftwidth', 'tabstop' values in from of a line
set shiftwidth=2                " number of spaces to use for (auto)indentation
set tabstop=2                   " number of spaces that a <Tab> counts

" No sound on errors
set noerrorbells
set novisualbell

" Keybindings
" easier keybinding for inserting a newline
nmap <CR><CR> o<ESC>
map <C-f> :FZF<cr>
map <C-n> :Ranger<cr>
map <leader>ts :tab sp<cr>
map <leader>tn :tabnew<cr>

augroup go
  au!
  au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  "  au Filetype go inoremap <buffer> . .<C-x><C-o>
  au Filetype go map <leader>gd :GoDef<cr>
augroup END

" COC
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
