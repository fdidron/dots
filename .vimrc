" Set leader
:let mapleader = " "

" Custom Key map
nnoremap <Leader><Tab> <C-^>
nnoremap <Leader>s :sp<CR>
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>l <C-W><C-L>
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :Buffers<CR>

" No arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Better split opening behavior
set splitbelow
set splitright

"General options
"set relativenumber
set list listchars=tab:\ \ ,trail:·
set hidden

"Indentation
filetype plugin indent on
syntax on
set expandtab
set tabstop=2
set shiftwidth=2

"Autocommands
if has("autocmd")
  " Automatically clean trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
  " Run prettier on save
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
  "autocmd BufEnter * silent! lcd %:p:h
  autocmd FileType go setlocal shiftwidth=4 tabstop=4
  augroup autoindent
    au!
    autocmd BufWritePre *.rb,*.erb :normal migg=G`i
  augroup End
endif

"StatusLine
  function! ALEWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('  W:%d ', all_non_errors)
  endfunction

  function! ALEErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(' E:%d ', all_errors)
  endfunction

  function! ALEStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? ' ok ' : ''
  endfunction

  set laststatus=2
  set statusline=%<%f
  set statusline+=%w%h%m%r

  set statusline+=\ %y
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%\

  set statusline+=\%#StatusLineOk#%{ALEStatus()}
  set statusline+=\%#StatusLineError#%{ALEErrors()}
  set statusline+=\%#StatusLineWarning#%{ALEWarnings()}

"--- VimPlug
call plug#begin()
"UI
  Plug 'luochen1990/rainbow'
  Plug 'chriskempson/base16-vim'
  Plug 'chrisbra/Colorizer'

"File Navigation
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'francoiscabrol/ranger.vim'

"Task runners
  Plug 'w0rp/ale'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"Git
  Plug 'tpope/vim-fugitive'

"Search
  Plug 'haya14busa/incsearch.vim'

"Autocomplete
  Plug 'Valloric/YouCompleteMe', { 'do': 'git submodule update --init --recursive' }
  Plug 'ervandew/supertab'

" Language Support
" Snippets
  Plug 'SirVer/ultisnips'
  Plug 'fdidron/vim-react-snippets'
  Plug 'epilande/vim-es2015-snippets'
  Plug 'joaohkfaria/vim-jest-snippets'

" JavaScript
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'jparise/vim-graphql'

" Go
  Plug 'fatih/vim-go'

" Less
  Plug 'groenewege/vim-less'

" Gherkin
  Plug 'chr15m/vim-gherkin'

" Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

" Rails
  Plug 'tpope/vim-rails'

" CSV
  Plug 'chrisbra/csv.vim'
call plug#end()

"--- Plugin conf

"Colorscheme
syntax enable
set termguicolors
hi Normal guibg=NONE ctermbg=NONE
let g:rainbow_active = 1

"Linting / Fixing
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ }

"Autocomplete
let g:ycm_server_python_interpreter = '/usr/bin/python2'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"Open ranger when opening a directory
let g:ranger_replace_netrw = 1

"Incsearch setup
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

let g:vim_markdown_folding_disabled = 1

colorscheme base16-solarflare
