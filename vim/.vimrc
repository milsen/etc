" Preamble ------------------------------------------------------------- {{{
" .vimrc by Max Ilsen

" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by: runtime! debian.vim

" use Vim defaults instead of vi compatibility
if &compatible
    set nocompatible
endif

" Plugin-Manager vim-plug {{{
" each plugin gets a directory in ~/.vim/bundle, use :PlugUpdate
call plug#begin('~/.vim/bundle')
Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher'
Plug 'Raimondi/delimitMate'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'sjl/gundo.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'wellle/targets.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-sayonara'
Plug 'tpope/vim-surround'

" color schemes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'thomd/vim-wasabi-colorscheme'

" operators and textobjects
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'

" self-maintained
Plug 'milsen/vim-sneak'
Plug '~/.vim/bundle/vim-operator-substitute'
Plug '~/.vim/bundle/vim-terminal-colors'
call plug#end()
" }}}

" }}}
" Color Scheme --------------------------------------------------------- {{{
set t_Co=256            " tell vim to make use of the 256 color-terminal
set background=dark     " use a dark background
colorscheme terminal

" }}}
" General Settings ----------------------------------------------------- {{{

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
set gdefault            " use :s command by default with g(lobal) flag

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
set formatoptions=tcqj  " t - autowrap to textwidth
                        " c - autowrap comments to textwidth
                        " q - allow formatting of comments with 'gq'
                        " j - remove comment leaders where it makes sense
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
" Autocommands --------------------------------------------------------- {{{

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
	autocmd VimLeavePre
          \ if exists("*ShutdownEclim") |
          \   ShutdownEclim
          \ endif
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

augroup bash
  autocmd!
  autocmd FileType conf setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType conf setlocal foldenable foldmethod=marker
  autocmd FileType sh setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType sh setlocal foldenable foldmethod=marker
  autocmd FileType readline setlocal expandtab softtabstop=2 shiftwidth=2
  autocmd FileType readline setlocal foldenable foldmethod=marker
augroup END

augroup git_commits
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72
augroup END

augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  " markdown headers
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>1 yypVr=:redraw<cr>
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>2 yypVr-:redraw<cr>
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>3 mzI###<Space><Esc>`z4l
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>4 mzI####<Space><Esc>`z5l
augroup END

augroup filetype_matlab
  autocmd!
  autocmd FileType matlab setlocal commentstring=%\ %s
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
  " set tex files to tex, not plaintex
  autocmd BufNewFile,BufRead *.tex setlocal filetype=tex
  autocmd FileType tex setlocal spell
  autocmd FileType tex setlocal foldenable
  " for vimtex plugin:
  autocmd FileType tex setlocal foldmethod=expr
  autocmd FileType tex setlocal foldexpr=vimtex#fold#level(v:lnum)
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
" Mappings ------------------------------------------------------------- {{{

" mapleader is ',', local leader is '\'
let mapleader = " "
let maplocalleader = "\\"

" Leader Commands {{{

" edit files with Leader+e(file identifier)
nnoremap <Leader>e# :vs#<CR>
nnoremap <Leader>E# :e#<CR>
nnoremap <Leader>ev :vs $MYVIMRC<CR>
nnoremap <Leader>Ev :e $MYVIMRC<CR>
nnoremap <Leader>eb :vs ~/.bashrc<CR>
nnoremap <Leader>Eb :e ~/.bashrc<CR>
nnoremap <Leader>ea :vs ~/.bash_aliases<CR>
nnoremap <Leader>Ea :e ~/.bash_aliases<CR>
nnoremap <Leader>ef :vs ~/.bash_functions<CR>
nnoremap <Leader>Ef :e ~/.bash_functions<CR>
nnoremap <Leader>el :vs ~/.bash_logout<CR>
nnoremap <Leader>El :e ~/.bash_logout<CR>
nnoremap <Leader>eB :vs ~/.bash_profile<CR>
nnoremap <Leader>EB :e ~/.bash_profile<CR>
nnoremap <Leader>ei :vs ~/.inputrc<CR>
nnoremap <Leader>Ei :e ~/.inputrc<CR>

" load vimrc with Leader+lv
nnoremap <Leader>lv :source $MYVIMRC<CR>


" Toggling
" switch background brightness and colorscheme
nnoremap <silent> <Leader>b @=(&bg==#'dark'?':se bg=light':':se bg=dark')<CR><CR>
nnoremap <silent> <Leader>B :NextColorScheme<CR>

" toggle line numbers
nnoremap <silent> <Leader>n :set number!<CR>
nnoremap <silent> <Leader>N :set relativenumber!<CR>

" toggle cursorline and -column
nnoremap <silent> <Leader>c :set cursorline!<CR>
nnoremap <silent> <Leader>C :set cursorcolumn!<CR>

" switch off hlsearch
nnoremap <silent> <Leader><Space> :nohlsearch<CR>
vnoremap <silent> <Leader><Space> :nohlsearch<CR>

" reset syntax highlighting
nnoremap <silent> <Leader>; :sy sync fromstart<CR>


" open fzf with Leader+.
nnoremap <silent> <Leader>. :FZF<CR>
nnoremap <silent> <Leader>: :FZF ../<CR>
nnoremap <silent> <Leader>~ :FZF ~<CR>

" show contents of registers with Leader+r
nnoremap <silent> <Leader>r :register<CR>


" Plugin-Toggling
noremap <silent> <Leader>d :aboveleft 25vs +Dirvish<CR>
noremap <silent> <Leader>u :GundoToggle<CR>


" Text Commands
" indent the whole file
nnoremap <silent> <Leader>= :call Preserve("normal! gg=G")<CR>

" remove trailing whitespace
nnoremap <silent> <Leader>w :call Preserve("%s/\\s\\+$//e")<CR>

" copy and paste from the system register with Leader+p/y
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$

" copy into command line with Leader+R
nnoremap <Leader>R :<C-r><C-w>
vnoremap <Leader>R ""y:<C-r>"

" get help with Leader+m (for manual)
nnoremap <Leader>m :vert<Space>help<Space>
nnoremap <Leader>M :!man<Space>

" }}}
" LocalLeader Commands {{{

" Eclim setup
nnoremap <silent> <LocalLeader>e :call EclimSetup()<CR><CR>
nnoremap <silent> <LocalLeader>E :ShutdownEclim<CR>

" }}}
" Movement and Navigation {{{

" leave insert mode with jk
inoremap jk <Esc>

" big movements with HJKL
nnoremap H ^
nnoremap J }
nnoremap K {
nnoremap L $
vnoremap H ^
vnoremap J }
vnoremap K {
vnoremap L $
onoremap H ^
onoremap J }
onoremap K {
onoremap L $

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
nnoremap <silent> gg ggzz@=(line('.')==1?'':'zv')<CR>
nnoremap <silent> G Gzz@=(line('.')==line('$')?'':'zv')<CR>
nnoremap <CR> <C-]>zzzv
nnoremap <BS> <C-o>zzzv

" go through completion results (e.g. SuperTab) with Ctrl+j/k
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" writing and quitting
nnoremap <silent> Ö :w<CR>
nnoremap <silent> X :Sayonara<CR>

" let Y copy the rest of the line (and behave like other operators)
nnoremap Y y$

" use M for manual
nnoremap M K
vnoremap M K

" split and seam up lines with gS (formerly J)
nnoremap <silent> gsj Do<Esc>pgk:call Preserve("s/\v +$//")<CR>gj
nnoremap <silent> gsk DO<Esc>pgj:call Preserve("s/\v +$//")<CR>gk==
nnoremap <silent> gSj :call Preserve("normal! J")<CR>
nnoremap <silent> gSk :call Preserve("normal! kddpgkJ")<CR>gk
vnoremap <silent> gS J

" format text using Q
nnoremap Q gwip
vnoremap Q gw

" do not accidentally kill vim
nnoremap ZQ :echo "Use :q! instead."<CR>
nnoremap <C-z> u
inoremap <C-z> <Esc>ui
vnoremap <C-z> <Esc>uv

" folding commands
nnoremap <silent> ö @=(foldlevel('.')?'za':'l')<CR>
nnoremap <silent> <Leader>ö @=(&foldlevel?'zM':'zR')<CR>

" }}}

" }}}
" Abbreviations -------------------------------------------------------- {{{

iabbrev improt import

" }}}
" Plugins -------------------------------------------------------------- {{{

" Airline {{{
let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" }}}
" Colorscheme-Switcher {{{
" define your own mappings for switching colorschemes
let g:colorscheme_switcher_define_mappings = 0
" ignore built-in colorscheme when using :Prev/NextColorScheme
let g:colorscheme_switcher_exclude_builtins = 1
let g:colorscheme_switcher_exclude = ['hybrid_material']

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
" Dirvish {{{
" close Dirvish sidebar if it was opened as a second window and a file is visited
augroup dirvish
    autocmd!
    autocmd FileType dirvish nnoremap <buffer> <silent> <CR>
        \ :<C-U>call dirvish#visit("edit", 0)<CR>
        \ @=(winnr("$") > 1 && &ft !=# "dirvish" ?
        \ ':wincmd l \| close' : '')<CR><CR>
augroup END

" }}}
" Gundo {{{
augroup gundo
    autocmd!
    autocmd FileType gundo nnoremap <buffer> <silent> X
        \ :GundoToggle<CR>
augroup END

" }}}
" incsearch {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" n searches always forwards independent of using / or ?
let g:incsearch#consistent_n_direction = 1

" automatic :nohlsearch after searching
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zzzv
map N  <Plug>(incsearch-nohl-N)zzzv
map *  <Plug>(incsearch-nohl-*)zzzv
map #  <Plug>(incsearch-nohl-#)zzzv
map g* <Plug>(incsearch-nohl-g*)zzzv
map g# <Plug>(incsearch-nohl-g#)zzzv

" }}}
" Operator-Substitute {{{
map <silent> s <Plug>(operator-substitute)
map <silent> S <Plug>(operator-substitute)$
map <silent> & <Plug>(operator-substitute-repeat)
map <silent> g& <Plug>(operator-substitute-repeat-no-flags)
let g:operator#substitute#default_delimiter = "#"
let g:operator#substitute#default_flags = ""

" }}}
" Sneak {{{
" set up motion commands for sneaking
nmap <silent> ü <Plug>Sneak_s
nmap <silent> Ü <Plug>Sneak_S
xmap <silent> ü <Plug>Sneak_s
xmap <silent> Ü <Plug>Sneak_S
omap <silent> ü <Plug>Sneak_s
omap <silent> Ü <Plug>Sneak_S
nmap <silent> f <Plug>Sneak_f
nmap <silent> F <Plug>Sneak_F
xmap <silent> f <Plug>Sneak_f
xmap <silent> F <Plug>Sneak_F
omap <silent> f <Plug>Sneak_f
omap <silent> F <Plug>Sneak_F
nmap <silent> t <Plug>Sneak_t
nmap <silent> T <Plug>Sneak_T
xmap <silent> t <Plug>Sneak_t
xmap <silent> T <Plug>Sneak_T
omap <silent> t <Plug>Sneak_t
omap <silent> T <Plug>Sneak_T

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
let g:syntastic_check_on_open = 0
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
" vimtex {{{
let g:vimtex_quickfix_mode=2  " open qfix after compiling, do not jump to it
let g:vimtex_fold_envs=0      " do not fold environments

" }}}

" }}}
" Functions ------------------------------------------------------------ {{{

function! EclimSetup() " {{{
  " setup eclim daemon assuming that eclimd is found in \opt\eclipse\
  if exists("*eclim#EclimAvailable") && !(eclim#EclimAvailable())
    execute "!/opt/eclipse/eclimd &>/dev/null &"
  else
    echoerr "Eclim not available."
  endif
endfunction " }}}

function! FoldText() " {{{
  " get foldstart-line and amount of folded lines
  let l:line = getline(v:foldstart)
  let l:foldedlinecount = v:foldend - v:foldstart

  " get windowwidth
  let l:nucolwidth = &fdc + &number * &numberwidth
  let l:windowwidth = winwidth(0) - l:nucolwidth

  " get minimum of textwidth/windowwidth
  let l:totalcharcount = l:windowwidth < &textwidth ? l:windowwidth : &textwidth

  " expand tabs into spaces and remove last four chars
  let l:line = substitute(l:line, '\t', repeat(" ", &tabstop), 'g')
  let l:line = strpart(l:line, 0, l:totalcharcount - 4)

  " line + filler spaces + 4 fields for foldedlinecount
  let l:fillcount = l:totalcharcount - len(l:line) - len(l:foldedlinecount)
  return l:line . repeat(" ", l:fillcount) . l:foldedlinecount
endfunction " }}}

function! Preserve(command) "{{{
  let l:winview = winsaveview()   " save cursor and window position
  execute "silent!" . a:command | " execute the given command
  call winrestview(l:winview)     " restore cursor and window position
endfunction "}}}
" }}}
