" Preamble ----------------------------------------------------------------- {{{
" .vimrc by Max Ilsen

" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by: runtime! debian.vim

" use Vim defaults instead of vi compatibility
if &compatible |
    set nocompatible |
endif

" Plugin-Manager Pathogen:
" each plugin gets a directory in ~/.vim/bundle, git clone plugins into it
filetype off                " filetype off for pathogen to work, later on again
let g:pathogen_disabled = ['syntastic']
call pathogen#infect()
call pathogen#helptags()    " generate helptags for everything in 'runtimepath'
filetype plugin indent on   " load filetype-specific indentation and plugins

" }}}
" Color Scheme ------------------------------------------------------------- {{{
syntax on               " enable syntax highlighting
set t_Co=16             " tell vim to make use of the 256 color-terminal
set background=light    " use the light solarized colorscheme
colorscheme solarized
let g:solarized_termcolors=16
let g:solarized_contrast="high"

" }}}
" General Settings --------------------------------------------------------- {{{

" Appearance {{{
set encoding=utf-8      " show characters correctly
set title               " show filename in titlebar
set laststatus=2        " show statusbar always
set showcmd             " show (partial) command in status line
set number              " show line numbers
set ruler               " show the cursor position all the time
set showmatch           " show matching brackets
set nolist              " do not show normally invisible characters
set noerrorbells        " no audio cues for warnings
set visualbell t_vb=    " no visual cues for warnings

" }}}
" Search {{{
set ignorecase          " do case insensitive matching
set smartcase           " unless there is a capital in the search term
set incsearch           " incremental search
set hlsearch            " highlights search terms

augroup hlsearch_toggle " stop highlighting search results when in insert-mode
    autocmd!
    autocmd InsertEnter * :set nohlsearch
    autocmd InsertLeave * :set hlsearch
augroup end

" }}}
" Miscellaneous Settings {{{
set timeout             " wait fpr next key during key codes
set ttimeoutlen=500     " wait 500ms during key codes for next key
set cpoptions+=E        " failed operator does not enter insert mode
set nomodeline          " disable modelines for security reasons
set magic               " use regular expressions without \
set hidden              " hide buffers when they are abandoned
set mouse=a             " enable mouse usage (all modes)
set backspace=2         " backspace over indents, eol and bol
set clipboard+=unnamed  " always use system clipboard for copy-pasting
set scroll=10           " scroll over 30 lines with Ctrl+u and Ctrl+d
set scrolloff=4         " keep cursor 4 lines away from edge while scrolling
let g:netrw_liststyle=3 " liststyle of netrw-file-browser (:Explore)
set keywordprg="man"    " open man with help-key (M)
set wildmenu            " command completion with tab
set complete+=k         " use dictionary-auto-completion

set splitbelow          " hsplit windows always below
set splitright          " vsplit windows always to the right
" }}}
" Backups, History, Autowrite {{{
set history=1000        " keep 1000 lines of command line history
set undofile            " create undo history files in ~/.undofiles
set undodir=~/.vim/undofiles
" set backup
set backupdir=~/.vim/backupfiles
set swapfile
set directory=~/.vim/swapfiles
set autowrite           " automatically save before commands like :next or :make

" }}}
" Wrapping, Formatting and Indenting {{{
set wrap                " wrap lines if window is smaller than line length
set textwidth=80        " set textwidth to 60 columns
set formatoptions=tcq   " t - autowrap to textwidth
                        " c - autowrap comments to textwidth
                        " q - allow formatting of comments with 'gq'
set autoindent          " automatic indenting when on a new line
set nosmartindent       " no smart indenting
set expandtab           " use spaces instead of tabs
set softtabstop=4       " one tab is 4 spaces while writing
set shiftwidth=4        " one tab is 4 spaces while indenting
set shiftround          " set indenting to multiple of shiftwidth
set tabstop=4           " irrelevant: one tab is 4 spaces in the file

"}}}
" Folding {{{
set nofoldenable        " do not enable folding of code by default
set foldmethod=indent   " use indentation to fold code
set foldlevelstart=0    " start editing with all folds closed
set foldnestmax=6       " set the maximal fold-nesting to 6
set foldtext=FoldText() " let fold text look like described in function

" }}}

" }}}
" Autocommands ------------------------------------------------------------- {{{

augroup buffer_autocmds " {{{
    autocmd!
    " go to the directory of the file you are editing
    " unless it is just the help file
    autocmd BufEnter *
       \ if &ft != 'help' |
       \   silent! lcd %:p:h |
       \ endif
    " go to the last position when reopening a file
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g'\"zv" |
        \ endif
    " shutdown Eclim if it is still running
	autocmd VimLeavePre * ShutdownEclim
augroup end " }}}

" Filetype-Specific {{{
"
augroup filetype_general
  autocmd!
  " use filetype-specific dictionaries for completion
  autocmd FileType *  execute
        \ "setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>')
augroup END

" do not switch buffers in help or similar windows, it is just confusing
augroup no_buffer_switching
  autocmd!
  autocmd FileType help noremap <buffer> <silent> <C-j> <nop>
  autocmd FileType help noremap <buffer> <silent> <C-K> <nop>
  autocmd FileType gundo noremap <buffer> <silent> <C-j> <nop>
  autocmd FileType gundo noremap <buffer> <silent> <C-K> <nop>
  autocmd FileType quickfix noremap <buffer> <silent> <C-j> <nop>
  autocmd FileType quickfix noremap <buffer> <silent> <C-K> <nop>
  autocmd FileType preview noremap <buffer> <silent> <C-j> <nop>
  autocmd FileType preview noremap <buffer> <silent> <C-K> <nop>
augroup END

augroup git_commits
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72
augroup END

augroup filetype_java
  autocmd!
  autocmd FileType java setlocal expandtab softtabstop=4 shiftwidth=4
augroup END

augroup filetype_ruby
  autocmd!
  autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2
augroup END

augroup filetype_tex
  autocmd!
  autocmd FileType tex setlocal foldenable
augroup END

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal foldenable
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal keywordprg='help'
augroup END

" }}}

" }}}
" Mappings ----------------------------------------------------------------- {{{

" mapleader is ',', local leader is '\'
let mapleader = ","
let maplocalleader = "\\"

" Leader Commands {{{

" edit files with Leader+e(file identifier)
nnoremap <Leader>e# :vs#<CR>
nnoremap <Leader>E# :e#<CR>
nnoremap <Leader>ev :vs $MYVIMRC<CR>
nnoremap <Leader>Ev :e $MYVIMRC<CR>
nnoremap <Leader>eb :vs ~/.bashrc<CR>
nnoremap <Leader>Eb :e ~/.bashrc<CR>
nnoremap <Leader>eB :vs ~/.bash_aliases<CR>
nnoremap <Leader>EB :e ~/.bash_aliases<CR>

" source vimrc with Leader+sv
nnoremap <Leader>Sv :source $MYVIMRC<CR>


" Toggling
" switch between light and dark background
nnoremap <silent> <Leader>b :call BackgroundToggle()<CR>

" switch off hlsearch
nnoremap <silent> <Leader>n :nohlsearch<CR>
vnoremap <silent> <Leader>n :nohlsearch<CR>

" toggle relative line numbers
nnoremap <silent> <Leader>N :set relativenumber!<CR>

" reset syntax highlighting
nnoremap <silent> <Leader>r :sy sync fromstart<CR>


" Text Commands
" indent the whole file
nnoremap <silent> <Leader>= :call Preserve("normal! gg=G")<CR>

" remove trailing whitespace
nnoremap <silent> <Leader>w :call Preserve("%s/\\s\\+$//e")<CR>

" substitute more quickly
nnoremap <Leader>s :%s:::g<Left><Left><Left>
vnoremap <Leader>s :s:::g<Left><Left><Left>


" copy and paste from the system register with Leader+p/y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" copy into command line with Leader+c
nnoremap <Leader>c :<C-r><C-w>
vnoremap <Leader>c ""y:<C-r>"

" get help with Leader+m (for manual)
nnoremap <Leader>m :vert<Space>help<Space>

" }}}
" LocalLeader Commands {{{

" Latex-Box: viewing files with \lv only works if you are in that directory
nnoremap <LocalLeader>lv :lcd %:p:h<CR>:pwd<CR><LocalLeader>lv

" Eclim setup
nnoremap <silent> <LocalLeader>e :call EclimSetup()<CR><CR>
nnoremap <silent> <LocalLeader>E :ShutdownEclim<CR>

" }}}
" Plugin-Toggling {{{

noremap <silent> <F2> :NERDTreeToggle<CR>
noremap <silent> <F3> :GundoToggle<CR>

" }}}
" Movement and Navigation {{{

" leave insert mode with jk
inoremap jk <Esc>

" big movements with HJKL
nnoremap H ^
nnoremap <silent> J :call SmoothScroll(1,0)<CR>
nnoremap <silent> K :call SmoothScroll(0,0)<CR>
nnoremap L $
vnoremap H ^
vnoremap <silent> J :<C-u>call SmoothScroll(1,1)<CR>
vnoremap <silent> K :<C-u>call SmoothScroll(0,1)<CR>
vnoremap L $

" buffer navigation with Ctrl-hkjl
noremap <C-h> <C-w>W
noremap <silent> <C-j> :bnext<CR>
noremap <silent> <C-K> :bprevious<CR>
noremap <C-l> <C-w>w

" go through previous commands with Ctrl+h/j/k/l
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" jumps, keep screen in the middle
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <CR> <C-]>zzzv
nnoremap <BS> <C-o>zzzv

" go through completion results (e.g. SuperTab) with Ctrl+j/k
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" writing and quitting
nnoremap <silent> Ö :w<CR>
nnoremap <silent> X :call KillSwitch()<CR>

" let Y copy the rest of the line (and behave like other operators)
nnoremap Y y$

" use M for manual
nnoremap M K
vnoremap M K

" split and seam up lines with S (formerly J)
nnoremap <silent> sj Do<Esc>pgk:call Preserve("s/\v +$//")<CR>gj
nnoremap <silent> sk DO<Esc>pgj:call Preserve("s/\v +$//")<CR>gk==
nnoremap <silent> Sj :call Preserve("normal! J")<CR>
nnoremap <silent> Sk :call Preserve("normal! kddpgkJ")<CR>gk
vnoremap <silent> S J

" do not accidentally kill vim
nnoremap ZQ :echo "Use :q! instead."<CR>
nnoremap <C-z> u
inoremap <C-z> <Esc>ui
vnoremap <C-z> <Esc>uv

" folding commands
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <Leader><Space> zi

" }}}
" Operator-Pendant Mappings {{{

onoremap H ^
onoremap L $

" }}}

" }}}
" Abbreviations ------------------------------------------------------------ {{{

iabbrev improt import

" }}}
" Plugins ------------------------------------------------------------------ {{{

" Airline {{{
"let g:airline_theme=solarized
let g:airline_powerline_fonts = 0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" }}}
" CtrlP {{{

let g:ctrlp_map = '<Leader>,'          " start CtrlP with Leader+
let g:ctrlp_use_caching = 0            " do not use caching for CtrlP
let g:ctrlp_show_hidden = 1            " search for hidden files as well
let g:ctrlp_max_files = 1000           " search for maximally 1000 files
let g:ctrlp_max_depth = 10             " search maximally 10 directories deep
let g:ctrlp_open_multiple_files = 'i'  " open multiple files in buffers with C-z
let g:ctrlp_regexp = 1                 " regex mode as default
let g:ctrlp_match_window = 'order:tbb' " order result from top to bottom

" do not open files in netrw, help or quickfix windows
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'

" }}}
" DelimitMate {{{

let delimitMate_matchpairs = "(:),[:],{:}"

" move closing delimiter one line further when inserting opening delimiter+<CR>
let delimitMate_expand_cr = 1

" in vimscript " denotes comments so do not use closing quotes
augroup DelimitMate
  autocmd!
  au FileType vim let b:delimitMate_quotes = "` '"
augroup End

" }}}
" LatexBox {{{
let g:LatexBox_output_type="pdf"
"let g:LatexBox_viewer="evince"
let g:LatexBox_quickfix="2"       " open qfix after compiling, do not jump to it
let g:LatexBox_Folding="1"        " activate folding in latex-files
let g:LatexBox_fold_preamble="1"  " fold the preamble
let g:LatexBox_fold_envs="0"      " do not fold environments
let g:LatexBox_fold_text="1"      " use the latex-box foldtext
let g:LatexBox_custom_indent="0"  " no latexbox-custom indentation

" }}}
" NerdTree {{{

augroup NERDTree
  autocmd!
  " close vim if NERDTree is the last open buffer
  autocmd BufEnter *
        \ if (winnr("$") == 1 && exists("b:NERDTreeType")
        \                     && b:NERDTreeType == "primary") |
        \ q |
        \ endif
augroup END

" }}}
" SuperTab {{{
" use SuperTab with Tab and remapped C-j/k

" no completion after start of a line, space or tab, or closing brackets
let g:SuperTabNoCompleteAfter=['^','\s','\t',')',']','}','''','"','`']

" completion as user-defined to work with eclim
let g:SuperTabContextDefaultCompletionType="<C-x><C-u>"

" }}}
" Syntactic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}
" UltiSnips {{{

let g:UltiSnipsSnippetsDir="~/.vim/snippets"
let g:UltiSnipsExpandTrigger="<Tab>"       " snip expansion with Tab (like SuperTab)
let g:UltiSnipsListSnippets="<S-Tab>"      " snip listing with Shift+Tab
let g:UltiSnipsJumpForwardTrigger="<C-j>"  " go to next and previous snippet
let g:UltiSnipsJumpBackwardTrigger="<C-k>" " field with Ctrl-j/-k
" BUG:
" <C-k> falls back on regular insert-mode mapping when snippet in last field ($0)

" }}}

" }}}
" Functions ---------------------------------------------------------------- {{{

function! BackgroundToggle() " {{{
  if &bg ==# "light"
    set bg=dark
  else
    set bg=light
  endif
endfunction " }}}

function! EclimSetup() " {{{
  " setup eclim daemon assuming that eclimd is found in \opt\eclipse\
  if exists("*eclim#EclimAvailable") && !(eclim#EclimAvailable())
    execute "!/opt/eclipse/eclimd &>/dev/null &"
  endif
endfunction " }}}

function! FillWithMinus() " {{{
  " strip trailing whitespace at the end of the line
  .s/\s\+$//e

  " length of '-'-string =  textwidth - linelength - 2 spaces - 3 braces
  let linelength = len(getline('.'))
  let fillcount = 80 - linelength - 5

  " insert space+minuses+space at the end of the line
  execute "normal! A " . repeat('-', fillcount) . " "
endfunction "}}}

function! FoldText() " {{{
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth
  let foldedlinecount = v:foldend - v:foldstart
  let restspaces = 4 - len(foldedlinecount)

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  " let line = substitute(line, '\t', onetab,'g')

  " line + filler spaces + 4 fields for foldedlincount + 1 extra space
  let line = strpart(line, 0,  windowwidth - 5)
  let fillcount = windowwidth - len(line) - 5
  return line . repeat(" ", fillcount + restspaces) . foldedlinecount . ' '
endfunction " }}}

" ???if foldlevel(line(".")) ==# 0
" function! FoldToggle() "{{{
"   if allfoldsclosed > -1 && foldbackup == 0
"       normal! zR
"   elseif &foldlevel ==# 0
"       call FoldRestore()
"   elseif allfoldsopen
"       normal! zM
"   else " some folds are open
"       call FoldBackup()
"           normal! zM
"   endif
" foldclosed
" foldclosedend
" foldlevel
" endfunction "}}}
"
" function! FoldToggleBackwards() "{{{
"   if allfoldsopen && foldbackup == 0
"       execute "normal! zM"
"   elseif &foldlevel ==# 0
"       execute "normal! zR"
"   elseif allfoldsopen
"       call FoldRestore()
"   else " some folds are open
"             let g:foldbackup=
"       execute "normal! zR"
"   endif
" endfunction "}}}

function! KillSwitch() "{{{
  " TODO do not close window when using bdelete
  " get number of all 'possible' buffers that may exist
  " number of listed buffers
  let l:b_all = range(1, bufnr('$'))
  let l:b_listed = len(filter(l:b_all, 'buflisted(v:val)'))

  " get number of all windows in current tab
  " get number of windows with same buffer displayed as current buffer
  let l:w_all = range(1, winnr("$"))
  let l:w_same = len(filter(l:w_all, 'winbufnr(0) ==# winbufnr(v:val)'))

  " if there is another window with the same buffer open
  " or there is only one buffer, quit, else just delete the buffer
  if l:w_same > 1 || l:b_listed ==# 1
    if &ft ==# 'gundo' " close second gundo window
      quit
    endif
    quit
  else
    bdelete
  end
endfunction "}}}

function! Preserve(command) "{{{
  let l:winview = winsaveview()   " save cursor and window position
  execute "silent!" . a:command | " execute the given command
  call winrestview(l:winview)     " restore cursor and window position
endfunction "}}}

function! SmoothScroll(down,visual) "{{{
  " set keys depending on movement direction and being in visual or normal mode
  let l:key = a:down ==# 1 ? 'j' : 'k'
  let l:vkey = a:visual ==# 1 ? 'gv' : ''

  " get number of lines in window divided by two and the line of your cursor
  let l:whalfheight = winheight("0")/2
  let l:wline = winline()

  " if cursor is in the middle of the window, go two lines up/down and center
  " window on cursor, else go two lines up/down but do not center window
  if l:whalfheight ==# l:wline ||
        \ l:whalfheight ==# l:wline+1 ||
        \ l:whalfheight ==# l:wline-1
    execute "normal! ".l:vkey."g".l:key."zzg".l:key."zz"
  else
    execute "normal! ".l:vkey."2g".l:key
  endif
endfunction "}}}

" }}}
