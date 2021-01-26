""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
filetype plugin indent on
syntax on

set t_Co=256
set background=light
let g:solarized_termcolors=256
"colorscheme solarized
"colors dante            " placed under .vim/colors/<choose ur own style>.vim
                        " vimcolorschemetest.googlecode.com/svn/html/index-c.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a                 " enable mouse - life is good when you can point at things
set whichwrap+=<,>,h,l,[,]  " allow cursor to wrap with arrow keys
"set colorcolumn=80          " set margin at column 80, Note: only in vim 7.3 and newer
set autoindent              " indents next line the same as the previous
set paste					" indent text pasted into vim
set ic                      " ignore case
set is                      " highlight match while typing search pattern
set hlsearch                " highlight search matches
set nu                      " line number display
set nowrap                  " disables word-wrap
set ru                      " show cursor line and column in the status line
set ai                      " always set autoindenting on
set laststatus=2            " shows the status bar at all time
set sm                      " show match
set sw=4                    " shift with
set ts=4                    " tab stop
"set et                      " expand tab to space characters
set ru                      " show cursor line and column in the status line
set nocompatible            " Use Vim defaults (much better!)
set bs=2                    " allow backspacing over everything in insert mode
"set mh                     " hide mouse pointer while typing
"set backup                 " keep a backup file
set showmode                " shows the mode in which we are in
"set viminfo='20,\"50       " read/write a .viminfo file, don't store more than 50 lines of registers
set modelines=0
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set ruler
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=   " no annoying ding dongs
"set foldmethod=syntax  "zf = add fold, zc/C = close, zo/O = open, zr/R = recurse
" refer http://stevelosh.com/blog/2010/09/coming-home-to-vim/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
map  <F1> :e#<cr>
"map <F2> :previous<cr>
"map <F3> :next<cr>
nmap <F2> :bp<cr>
nmap <F3> :bn<cr>
map  <F4> :ls<C-M>:e#
"map  <F12> :bd<cr>
" open current file tree view
map  <F5> :TlistToggle<cr>
" open NERDTree explorer
map  <F6> :NERDTreeToggle<cr>
" find the word under the cursor and list it in the QuickFix window
map <F10> :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
" enable parenthesis highlighting plugin
map <F11> :so ~/.vim/plugin/RainbowParenthsis.vim<CR>
" generate tags from present dir (recurse into sub-directories)
" ctrl+] to jump to definition, ctrl+t to jump back
map <F12> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving across windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Resize windows
nmap <S-j> :resize +10<CR>
nmap <S-k> :resize -10<CR>
nmap <S-h> :vertical resize -10<CR>
nmap <S-l> :vertical resize +10<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup cprog
    " Remove all cprog autocommands
    au!
    " When starting to edit a file:
    " For *.c and *.h files set formatting of comments and set C-indenting on.
    " For other files switch it off.
    " Don't change the order, it's important that the line with * comes first.
    autocmd BufRead *                         set formatoptions=tcql  nocindent comments&
    autocmd BufRead *.c,*.h                   set formatoptions=croql   cindent comments=sr:/*,mb:*,el:*/,://
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
iab gbpf printf("\n__GB__ \n");<left><left><left><left><left>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE IT EASY TO UPDATE/RELOAD_vimrc
" nmap ,s :source ~/.vimrc<CR>
" nmap ,v :split ~/.vimrc<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "******* HELP *******"
" "1.     :cd         takes to current files directory
" "2.     :cd ..      previous directory
" "3.     '.          jump to last modified line
" "4.     `.          jump to exact sopt of last modified line
" "5.     ctrl+o      
" "6.     ctrl+i
" "7.     "<reg>10yy  example: "a10yy  yank 10 lines to "a" register
" "8.     "<reg>p     example: "ap     paste from register "a"
" "9.     :reg        lists the contents of all register
" "10.    :r !ls !date  put the output of command line at cursor position
" "11.    :ccl        close the QuickFix List window
" "******* HELP *******"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
