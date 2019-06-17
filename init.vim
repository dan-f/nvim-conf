" vim-plug {{{
call plug#begin('~/.vim/plugged')

" Tools:
" Plug 'SirVer/ultisnips'
Plug 'ElmCast/elm-vim/'
Plug 'hynek/vim-python-pep8-indent'
Plug 'itchyny/vim-haskell-indent'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-slash'
Plug 'majutsushi/tagbar'
Plug 'vimscripts/matchit.zip'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mxw/vim-jsx'
Plug 'niklasl/vim-rdf'
Plug 'pangloss/vim-javascript'
Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

" Cosmetic:
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'junegunn/seoul256.vim'
Plug 'vim-scripts/rainbow_parentheses.vim'
Plug 'whatyouhide/vim-gotham'

call plug#end()
" }}}
" NeoVim {{{
tnoremap <Esc> <C-\><C-n>
" }}}
" Better defaults {{{
set hidden
set number
set mouse=a
" set ttymouse=xterm2
set splitbelow
set splitright
set autoread
set wildmenu
set wildignore=*.o,*.obj,*.pyc,*.class
set laststatus=2
set shell=/bin/bash
" }}}
" Formatting {{{
set sw=2
set textwidth=80
set backspace=2
set expandtab
set cinkeys=0{,0},0),0#,;,:,o,O,e
set indentkeys=o,O,:,0#,e
set cinoptions+=(0   " indent parenthetical function arguments correctly
set cinoptions+=g0   " do not indent access modifiers
set cinoptions+=:0
set formatoptions-=t " don't wrap text in programming modes
set formatoptions+=c " Auto-wrap text using textwidth
set formatoptions+=r " Auto-insert current comment leader on next line
set formatoptions+=o " Same as above, but when you hit o/O
set formatoptions+=q " Lets you format comments with gq
set formatoptions+=n " recognizes numbered lists when formatting text
" }}}
" Folding {{{
nnoremap <Space> za
vnoremap <Space> za
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
nnoremap <Leader><Space> zMzvzz
" }}}
" Remaps {{{
let mapleader=","
" easier defaults {{{
nnoremap Y y$
inoremap kj <Esc>
inoremap jk <Esc>

" replaces current visual selection with last yanked text.
xnoremap <leader>p "_dP

nnoremap ; :
vnoremap ; :
nnoremap <Leader>; ;

nnoremap <Leader>k :bp\|bd #<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" }}}
" Searching {{{
set ignorecase          " search without caring of case
set smartcase           " only ignore case when lowercase
set incsearch           " show matches as they occur
set hlsearch
set pastetoggle=<F5>    " used for pasting in data
set ruler               " always show location information
set showmatch           " show matching paren
" }}}
" Plugin settings {{{
filetype plugin on
filetype plugin indent on

" fzf
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :FZF<CR>

" NERDTree
let g:NERDTreeRespectWildIgnore=1
nnoremap <Leader>N :NERDTreeToggle<CR>

" auto-pairs
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutJump=''

" yankstack
let g:yankstack_map_keys = 0
nmap <M-p> <Plug>yankstack_substitute_older_paste
nmap <M-n> <Plug>yankstack_substitute_newer_paste

" fugitive
nnoremap <Leader>g :Gstatus<CR>

" vim-sleuth
runtime! plugin/sleuth.vim

" deoplete
let g:deoplete#enable_at_startup = 1

" vim-jsx
let g:jsx_ext_required = 0

" tagbar
nnoremap <Leader>t :Tagbar<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" }}}
" Autocmds {{{
augroup filetype_settings
  autocmd!

  autocmd FileType vim setlocal foldmethod=marker

  autocmd FileType python setlocal sw=4
  autocmd FileType python setlocal keywordprg=pydoc

  autocmd FileType javascript setlocal sw=2
  autocmd FileType javascript setlocal fo-=c " Don't auto-wrap

  autocmd FileType htmldjango setlocal sw=4

  autocmd FileType java setlocal sw=4

  autocmd FileType haskell setlocal sw=2

  autocmd FileType elm setlocal sw=2

  autocmd FileType go setlocal sw=4
  autocmd FileType go setlocal ts=4
  autocmd FileType go setlocal noet
  autocmd FileType go setlocal nolist

  " default filetype
  autocmd FileType text setlocal formatoptions+=t " auto wrap lines
augroup END

augroup default_filetype
  autocmd!
  autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif
augroup END

augroup delete_whitespace
  " Always delete trailing whitespace before saving
  autocmd!
  autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

augroup AutoReloadVimRC
  " reload .vimrc whenever saved -- from https://gist.github.com/1988620
  autocmd!
  " automatically reload vimrc when it's saved
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
  autocmd BufWritePost $MYVIMRC execute "syntax on"
augroup END

" compiling
augroup compilation
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
  autocmd Filetype java setlocal makeprg=javac\ %
augroup END

" }}}
" Helper Macros/functions{{{
" global file replace on inner word
nnoremap <leader>R yiw:%s/<C-r>"//g<Left><Left>
" }}}
" Appearance {{{
syntax on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set listchars=extends:»,tab:▸\ ,trail:·
set list
set cursorline
if has('gui_running')
  set guioptions-=T " hide toolbar
  set guioptions-=r " hide scrollbar
  set guifont=Menlo\ Regular:h12
endif
color seoul256
" }}}
" Stuff from Ben {{{
" I Make a bunch of text headlines
map! <Leader>ul <esc>:let @h=@/<cr>yypV:s/^[ ]*//<CR>V:s/./-/g<cr>:let @/=@h<CR>kJi<CR><esc>o
map  <Leader>ul :let @h=@/<cr>yypV:s/^[ ]*//<CR>V:s/./-/g<cr>:let @/=@h<CR>kJi<CR><esc>
vmap <Leader>ul <esc>:let @h=@/<cr>yyPj:s/./ /g<CR>gvr-:let @/=@h<CR>k$
map! <Leader>hl <cr><esc>079A-<esc>o
map  <Leader>hl o<esc>079A-<esc>

" The date
nmap <Leader>ldate :r!date<cr>
map! <Leader>ldate <esc>:r!date<cr>
nmap <Leader>date i<cr><esc>k:r!date +"\%d \%B \%Y"<cr>kJJ
map! <Leader>date <cr><esc>k:r!date +"\%d \%B \%Y"<cr>kJJi
nmap <Leader>sdate i<cr><esc>k:r!date +"\%m/\%d/\%y"<cr>kJJ
map! <Leader>sdate <cr><esc>k:r!date +"\%m/\%d/\%y"<cr>kJJi
" }}}
" Misc {{{
" insert current path into command prompt
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
nnoremap <Leader>v :tabe ~/.config/nvim/init.vim<CR>
" }}}
