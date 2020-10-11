version 6.0
if &cp | set nocp | endif

syntax enable           " enable syntax processing
colorscheme molokai    " cool colors!
"colorscheme seoul256    " cool colors!

""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
" remap numpad for insert mode:
inoremap <Esc>0q 1
inoremap <Esc>Or 2
inoremap <Esc>Os 3
inoremap <Esc>Ot 4
inoremap <Esc>Ou 5
inoremap <Esc>Ov 6
inoremap <Esc>Ow 7
inoremap <Esc>Ox 8
inoremap <Esc>Oy 9
inoremap <Esc>Op 0
inoremap <Esc>On .
inoremap <Esc>OQ /
inoremap <Esc>OR *
inoremap <Esc>Ol +
inoremap <Esc>OS -
inoremap <Esc>OM <Enter>

" remap F5 to remove trailing white spaces:
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins for vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins will be downloaded under the specified directory
call plug#begin('~/.vim/plugged')

" list of plugins to install
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'neoclide/coc.nvim', {'branch':'release'}

" end of plugins list
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""
" Configurations for Coc (code completion plugin)
"""""""""""""""""""""""""""""""""""""""""""""""""
function! SetupCommandAbbrs(from, to)
      exec 'cnoreabbrev <expr> '.a:from
              \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
              \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gdec <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)





""""""""""""""""""""""""""""""""""""""""""""""""""
" Old configurations, before finding:
" https://github.com/amix/vimrc/blob/master/vimrcs/extended.vim
" 2019-04-25
""""""""""""""""""""""""""""""""""""""""""""""""""
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set fileencodings=utf-8,latin1
set helplang=en
set history=500
set hlsearch
set suffixesadd+=.log
set ruler
set viminfo='20,\"50
set pastetoggle=<F2>
" vim: set ft=vim :

set nobackup
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftwidth=4
set expandtab

vnoremap // y/\V<C-R>"<CR>

highlight DiffAdd ctermfg=black ctermbg=green
highlight DiffDelete ctermfg=black ctermbg=red
highlight DiffChange ctermfg=black ctermbg=blue
highlight DiffText ctermfg=black ctermbg=yellow
set list
set listchars=tab:>-

set mouse-=a
set number

set ignorecase
set smartcase
