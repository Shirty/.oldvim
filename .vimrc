" Author: ShirtyKezRat

" Global options, commands----------------
" General Settings -----------------------{{{
" ----------------------------------------
set nocompatible " Better safe then sorry, just want Vim Improved!
au! bufwritepost .vimrc source % " Source Vimrc on write
set clipboard=unnamed " Usual clipboard way

filetype off

" Setting Vundle up-----------------------{{{
" ----------------------------------------

if has("win32") " Different place depending on system
  set rtp+=~/vimfiles/bundle/vundle/
	let path='~/vimfiles/bundle'
	call vundle#begin(path)
else
  set rtp+=~/.vim/bundle/vundle/
	call vundle#begin()
endif

" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle " Command for getting vundle
" Let Vundle manage Vundle " --- Required!
Plugin 'gmarik/vundle'
Plugin 'fugitive.vim'
Plugin 'scrooloose/nerdtree'
if has('unix')
  let g:UsingYouCompleteMe=1
  Plugin 'Valloric/YouCompleteMe'
endif
" TODO: Needs to go down in java
" If using YouCompleteMe and eclim:
"   let g:EclimCompletionMethod = 'omnifunc'
Plugin 'majutsushi/tagbar'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'groenewege/vim-less'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim.git'
Plugin 'klen/python-mode'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin  'altercation/vim-colors-solarized.git'
" Haxe plugin
Plugin 'jdonaldson/vaxe'

call vundle#end()

" Bundle 'msanders/snipmate.vim' " FIXME  Doesn't work properly with YouCompleteMe
" Bundle 'Townk/vim-autoclose' " FIXME Issue with indenting
" Plugin 'sontek/rope-vim.git' FIXME Issue with installing asks for password ALSO Included in python-mode
" Bundle 'ervandew/supertab' " FIXME Doesn't work like in tutorial
" Bundle 'sontek/minibufexpl.vim' " FIXME Brings changed URI
" Bundle 'wincent/Command-T' FIXME Requires vim with ruby
" WINDOWS INSTALL -> TODO http://chrislaco.com/blog/gettimg-command-t-working-on-windows/

" TODO Look into these plugins
" Bundle 'tPope/vim-ragtag'
" Bundle 'davidhalter/jedi-vim' " FIXME Does not work with python3
" Bundle 'Lokaltog/powerline' " NOTE {'rtp': 'powerline/bindings/vim/'}

" TagList is installed independently
" }}}

syntax on " Normally filetype takes care of this? Not sure why I put this here but leaving it here
filetype plugin indent on " Filetype on, with plugins and indent enabled

set backspace=indent,eol,start " Allow backspacing over everything
set autoindent 
set number
set history=100
set ruler   " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch   " do incremental searching
set hlsearch " Highlight seach

" Basic indent
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" Folding
set foldcolumn=1

" Use mouse
set mouse=a

" Leaderkeys
let mapleader = "-"
let maplocalleader = ","

" Swap files
if has("win32")
  set directory=.\_backup,c:\temp
  set backupdir=.\_backup,c:\temp
else
  set dir-=.
endif

" Handle issue with mate-terminal and using ctrl
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" For numbers also
let c='0'
while c <= '9'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw


" TODO lookup ttimeout if timeout bad
set timeout ttimeoutlen=50

" Windows specifics-----------------------{{{
" ----------------------------------------
if has("win32")
  set visualbell
  set t_vb= 
endif
" }}}

" Xterm/Gui/Colors -----------------------{{{

" -m = no menu bar, -T = no toolbar, gfn = GUIFONT
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
if has("win32")
    set gfn=Consolas:h10:cANSI
else
    set gfn=DejaVu\ Sans\ Mono\ 9
endif

" Setting 256 color for xterm
set t_Co=256

" Colorscheme
if has("win32")
    colorscheme grb3
    colorscheme moria
else
    colorscheme grb3
    colorscheme grb256
    colorscheme moria
endif

if has("win32")
  au GUIENTER * simalt ~x " x on an English windows version n on a french
endif
" }}}
" }}}
" General Key Mappings -------------------{{{
" Functions ------------------------------{{{
" Number Toggle function------------------{{{
" Toggles between relative number and number
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber 
	else
		set relativenumber
	endif
endfunction

nnoremap <C-n> :call NumberToggle()<cr>
" }}}
" }}}

" Accessing VIMRC from anywhere-----------
if has("win32")
  nnoremap <leader>ev :vsplit $HOME/_vimrc<cr>
  nnoremap <leader>eV :vsplit $HOME/vimfiles/README<cr>
else
  nnoremap <leader>ev :vsplit ~/.vim/.vimrc<cr>
  nnoremap <leader>eV :vsplit ~/.vim/README<cr>
endif

" Terminal Execute
nnoremap <leader>e :!

" Scheme changing functionality-----------{{{
if !exists("g:MY_COLORSCHEME_INDEX")
  let g:MY_COLORSCHEME_INDEX=0
endif

function! ChangeColorscheme()

python << endpython

import vim

list_of_colors = ["moria", "grb3", "grb256"]
list_of_darkbefores = ["moria"]

index = int(vim.eval("g:MY_COLORSCHEME_INDEX"))

index = (index + 1) % len(list_of_colors)

# Had to do this because of weird colorflitches
if list_of_colors[index] in list_of_darkbefores:
  vim.command("colorscheme evening")

vim.command("colorscheme " + list_of_colors[index])

vim.command("let g:MY_COLORSCHEME_INDEX=" + str(index))

endpython

endfunction

nnoremap <leader>� :call ChangeColorscheme()<cr>
" }}}

" NOP Window changing---------------------{{{
nnoremap <c-w>h <nop>
nnoremap <c-w>j <nop>
nnoremap <c-w>k <nop>
nnoremap <c-w>l <nop>
" }}}
" Tabs------------------------------------{{{
" New Tab
nnoremap <leader>m :tabnew<cr>

" Tab Selection
nnoremap <m-1> :tabn 1<cr>
nnoremap <m-2> :tabn 2<cr>
nnoremap <m-3> :tabn 3<cr>
nnoremap <m-4> :tabn 4<cr>
nnoremap <m-5> :tabn 5<cr>
nnoremap <m-6> :tabn 6<cr>
nnoremap <m-7> :tabn 7<cr>
nnoremap <m-8> :tabn 8<cr>
nnoremap <m-9> :tabn 9<cr>
" }}}
" Indenting-------------------------------{{{
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv
" }}}
" Window Management ----------------------{{{
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
" Reload Buffer --------------------------
nnoremap <leader>rb :e! "%"<cr>:execute ":cd "."%:p:h"<cr>:pwd<cr>
nnoremap <leader>$$ :redraw!<cr>
" }}}
" Folding---------------------------------{{{
" Up/Down
nnoremap <m-j> zj
nnoremap <m-k> zk
" Open/Close
nnoremap <m-l> za
" nnoremap <m-l> ]z
" nnoremap <m-L> za
" nnoremap <m-H> zM
" nnoremap <m-J> zo
" nnoremap <m-K> zc
" }}}
" Quit and Save---------------------------{{{
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <leader>s :w<cr>
nnoremap <C-s> :w<cr>
" nnoremap <leader>e :e! 
" }}}
" File Browsing---------------------------{{{
nnoremap <leader>f :e .<cr>
nnoremap <leader>F :e! .<cr>
" }}}
" Accessing outside programs--------------{{{
" TODO Replace with something more cross platform
" nnoremap <leader>y :exec "!xfce4-terminal -x python3 "<cr><cr>
" nnoremap <leader>tt :!xfce4-terminal &<cr><cr>
" nnoremap <leader>T :!thunar &<cr><cr>
" }}}
" Graphics--------------------------------{{{
nnoremap <leader>è :colo grb3<cr>
nnoremap <leader>ü :colo habiLight<cr> 
nnoremap <leader>n :noh<cr> 
" }}}

" }}}
" FileType options, commands--------------
" General FileType Settings --------------{{{
" Detecting new filetypes
" augroup Filetype_detect
"     au!
"     au BufNewFile,BufRead *.less setf less
" augroup END
" }}}

" Python FileType Settings ---------------{{{ 
augroup FileType_Python
    " If resourcing of vimrc this will overwrite previous autocmd's
    au!
    " Setting Tab making
    au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 
    " Folding
    au filetype python setlocal foldlevel=20
    au filetype python setlocal foldlevel=20
    " Launch python from within vim TODO As above need cross platform
    " au FileType python nnoremap <buffer> <localleader>y :exec "!xfce4-terminal 
    "             \-x python3 -i -m" "%:r" "&"<cr><cr>
    " au FileType python nnoremap <buffer> <localleader><s-y> :exec "!xfce4-terminal 
    "             \-x python2 -i -m" "%:r" "&"<cr><cr>
    " Commenting
    " Line Commenting
    au FileType python nnoremap <buffer> <localleader>c I#<esc>
    au FileType python vnoremap <buffer> <localleader>c <c-v>I#<esc>
    " EOL Commenting
    " au FileType python inoremap <buffer> <C-c> <esc>A # 
    " au FileType python nnoremap <buffer> <C-c> A # 
    au FileType python let g:pyindent_continue = 'shiftwidth()'
    " What is this FIXME ^
augroup END
" }}}
" Java FileType Settings ---------------{{{ 
augroup FileType_Java
    " If resourcing of vimrc this will overwrite previous autocmd's
    au!
    " Setting Tab making
    au FileType java setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 
augroup END
" }}}
" C FileType Settings --------------------{{{
augroup FileType_C_CPP
    au!
    " Had to overule settings here -> ~/.vim/ftplugin/after/c.vim
    au filetype c setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2 
    au filetype cpp setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
    au filetype cpp setlocal foldmethod=syntax
    au filetype c setlocal foldmethod=syntax
    au filetype cpp setlocal foldnestmax=1
    au filetype c setlocal foldnestmax=1
    " I prefer seeing the whole file first, also for snippets its better because if no foldlevel given when adding code
    " with snippets some of it is ofuscated
    au filetype cpp setlocal foldlevel=20
    au filetype c setlocal foldlevel=20

    " FIXME Snippet?
    " au filetype c iabbrev Cmain int main(int argc, char *argv[])<cr>{<cr><cr>return EXIT_SUCCESS;<cr>}<esc>%
    " au filetype c iabbrev Incl #include <stdio.h><cr>#include <stdlib.h><cr><cr><esc>
    " Line Commenting #TODO fix
    au filetype c nnoremap <buffer> <localleader>c I//<esc>
    au filetype c nnoremap <buffer> <localleader>C ^xx
    au filetype c vnoremap <buffer> <localleader>c <c-v>I//<esc>
    au filetype c vnoremap <buffer> <localleader>C <c-v>lx
    " EOL Commenting
    " au filetype c inoremap <buffer> <C-c> <esc>A /**/<esc>hi
    " au filetype c nnoremap <buffer> <C-c> A /**/<esc>hi
    au filetype c nnoremap <buffer> Uc //<esc>vnd
    " Navigation
    au filetype cpp nnoremap <buffer> <localleader>h :e %<.h<cr>
    au filetype cpp nnoremap <buffer> <localleader>c :e %<.cpp<cr>
    au filetype cpp nnoremap <buffer> <localleader>c :e %<.cpp<cr>
    " Make FIXME Reinstate?
    " au filetype cpp nnoremap <buffer> <localleader>m :make<cr>
    " au filetype cpp nnoremap <buffer> <localleader>M :make<cr>:cwindow<cr>
    " " or _cope
    " au filetype cpp nnoremap <buffer> <localleader>n :cn<cr>
    " au filetype cpp nnoremap <buffer> <localleader>p :cp<cr>
augroup END   
"  " }}}
" Latex FileType Settings-----------------{{{
augroup filetype_latex
    " General Settings------------------------{{{
    au!
    au filetype tex setlocal spell spelllang=fr
    " TODO Need to be able to change this and make it effect shortcuts
    " }}}
    " Shortcut maps --------------------------{{{
    " }}}
    " General Maps ---------------------------{{{
    " Spelling--------------------------------
    au filetype tex nnoremap <buffer> <localleader>se :setlocal spell spelllang=en_us<cr>
    au filetype tex nnoremap <buffer> <localleader>sf :setlocal spell spelllang=fr<cr>
    au filetype tex nnoremap <buffer> <localleader>sn :setlocal nospell<cr>.dvi

    " Inserting Time--------------------------
    au filetype tex nnoremap <buffer> <localleader>ti :call InsertTime("E")<cr>
    au filetype tex inoremap <buffer> <localleader>ti <esc>:call InsertTime("E")<cr>

    " FIXME Not cross platform at all
    " Build-----------------------------------
    au filetype tex nnoremap <buffer> <localleader>md :execute ":!xfce4-terminal
                \ -x /usr/local/texlive/2012/bin/x86_64-linux/latex %"<cr>
                \:execute ":!evince %:r.dvi &"<cr>
    au filetype tex nnoremap <buffer> <localleader>mp :execute ":!xfce4-terminal
                \ -x /usr/local/texlive/2012/bin/x86_64-linux/pdflatex %"<cr>
                \:execute ":!evince %:r.pdf &"<cr>
    " Line breaking --------------------------
    au filetype tex setlocal tw=100

    " Commmenting-----------------------------
    au filetype tex nnoremap <buffer> <localleader>c ^i% <esc>
    au filetype tex vnoremap <buffer> <localleader>c i%<esc> <esc>
    " }}}
    " General Map Functions----------------{{{
    function! InsertTime(lang)
        if a:lang == "E"
            let time = strftime("%c")
            execute ":normal a".time
        endif
    endfunction
    "  " }}}
augroup end
" }}}
" VimScript Filetype Settings ------------{{{
augroup FileType_VimScript
    au!
    " Formatting, folding---------------------
    au FileType vim setlocal wrap tw=0
    au FileType vim setlocal foldmethod=marker

    " Commands--------------------------------
    " Commenting------------------------------
    au FileType vim nnoremap <buffer> <localleader>c O" <esc>40A-<esc>^llR
    "^topcomment
    " au FileType vim nnoremap <buffer> <C-c> A "
    "^EOL comment
    " Folding---------------------------------
    au FileType vim vnoremap <buffer> <localleader>c "aygvdOO" 
                \40A-A{{{" }}}kpkllR
    au FileType vim nnoremap <buffer> <localleader>s :source %<cr>
augroup END
" END-------------------------------------
" }}}
" UnrealScript Filetype Settings -----------------{{{
augroup filetype_uc
    au!
    " TODO This is windows only! But only used on windows for now so....
    au filetype uc let TList_Ctags_Cmd = 'ctags.exe --options="~\dev\tools\unrealcodes\tags.cfg"' " FIXME No more used
    au filetype uc let tlist_uc_settings = 'unrealscript;c:class;f:function;i:simulated;e:event;s:state'
    au filetype uc set tags=tags;/
augroup END
" }}}
" Java Filetype Settings------------------{{{ 
augroup FileType_Java
    " If resourcing of vimrc this will overwrite previous autocmd's
    au!
    " Setting Tab making
    au FileType java setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 
augroup END
" }}}

" Html Filetype Settings -----------------{{{
augroup FileType_Html
    au!
    au FileType html setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2 
augroup END
" }}}
" Javascript Filetype Settings------------{{{
augroup FileType_Javascript
    au!
    au FileType javascript setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2 
    " au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " au BufReadPre *.js let g:used_javascript_libs = 'jquery'
augroup END
" }}}
" Less Filetype Settings -----------------{{{
" TODO needs cleanup
augroup FileType_Less
    au!
    au BufNewFile,BufRead *.less setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2
    " au FileType less setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2 
augroup END
" }}}
" Plugin ---------------------------------
" Fugitive -------------------------------{{{
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
" nnoremap <leader>g :Git !TODO never use this but who know prefer gundo for this
" }}}
" NERDTree -------------------------------{{{
nnoremap <F2> :NERDTreeToggle<cr>
" }}}
" TagList --------------------------------{{{ 
nnoremap <F3> :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
if has("win32")
    let Tlist_Ctags_Cmd = "'C:\Program Files (x86)\ctags58\ctags.exe'" " FIXME No more in use
endif
" }}}
" WindowsFullscreen ----------------------{{{
if has("win32")
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif
" }}}
" YouCompleteMe---------------------------{{{ nnoremap <F3> :TlistToggle<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_ycm_extra_conf'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<cr>
" }}}
" UltiSnips-------------------------------{{{
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}
" Tagbar----------------------------------{{{
nnoremap <F4> :TagbarToggle<CR>
let g:tagbar_left=1
" }}}
" TaskList--------------------------------{{{
" }}}
" Gundo-----------------------------------{{{
map <leader>g :GundoToggle<CR>
" }}}
" SuperTab--------------------------------{{{
" au FileType python set omnifunc=pythoncomplete#Complete " FIXME causes error at start up
" let g:SuperTabDefaultCompletionType = "context"
" set completeopt=menuone,longest,preview
" }}}
" Ack-------------------------------------{{{
nmap <leader>a <Esc>:Ack!
" }}}
" Pymode----------------------------------{{{
let g:pymode_options_colorcolumn = 0
let g:pymode_lint_ignore = "W0611" " Unused vars
let g:pymode_lint_checkers = ['pyflakes', 'mccabe']
let g:pymode_rope_goto_definition_cmd = 'vnew'
" }}}
