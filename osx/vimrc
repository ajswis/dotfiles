" Use pathogen to load other plugins
execute pathogen#infect()
Helptags
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""
" Some Basics
" Note : vim-sensible does some of these
" settings already
"""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8

" Search settings
set incsearch
set ignorecase
set smartcase
set hlsearch

" Indentation and tab functionality
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smarttab
set smartindent

" Code Folding
set nofoldenable
set foldmethod=indent
set foldnestmax=10
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

" Line numbers
set number

" Line Wrapping
set nowrap

" Automatically update externally updated files
set autoread

" Command expiration
set timeout
set ttimeoutlen=15

" New window split settings
set splitright

" Remember buffer info on close
set viminfo^=%

" Set font for (m|g)vim
set guifont=Meslo\ LG\ S\ for\ Powerline:h11

"""""""""""""""""""""""""""""""""""""""""
" Keybinds
"""""""""""""""""""""""""""""""""""""""""

let mapleader="\<space>"

" Wrapped lines treated like normal ones
nnoremap j gj
nnoremap k gk

" Set CTRL+S to save becuase I smack that every 10 seconds on whatever application I use
" browse is only available in gvim
command -nargs=0 -bar Update if &modified
          \|  if empty(bufname('%'))
          \|    browse confirm write
          \|  else
          \|    confirm write
          \|  endif
          \|endif
nnoremap <silent> <C-s> :Update<CR>
inoremap <C-s> <C-o>:Update<CR>
vnoremap <C-s> <C-o>:Update<CR>

" CTRL+w to close the current buffer
nnoremap <silent> <C-w> :call CloseWindow()<CR>

" Buffer magic
nnoremap <leader>l :ls<CR>:b<space>

" Switch indentation settings
nnoremap <leader>y :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap <leader>Y :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nnoremap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nnoremap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

" To wrap or not to wrap
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" Window Switching and Resizing
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-J> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent>   +   :wincmd +<CR>
nnoremap <silent>   _   :wincmd -<CR>
nnoremap <silent> ) :wincmd ><CR>
nnoremap <silent> ( :wincmd <<CR>
nnoremap <silent> <leader>r :wincmd r<CR>
nnoremap <silent> <leader>R :wincmd R<CR>

" ALt+d to duplicate a line, vmode version is best for SHIFT+V, not the others
nnoremap <D-d> yyp
vnoremap <D-d> y<C-o>p
inoremap <D-d> <C-o>:yank<CR><C-o>:put<CR>

" Open new files in new buffer or new windows
nnoremap <C-o> :e<space>
nnoremap <C-p> :sp<space>
nnoremap <D-p> :vs<space>

" Move lines of text via Alt+[jk] (Like sublime!)
nnoremap <D-j> :m+1<CR>==
nnoremap <D-k> :m-2<CR>==
vnoremap <D-j> :m '>+1<CR>gv=gv
vnoremap <D-k> :m '<-2<CR>gv=gv

" Clear searches so there aren't underlined words.
nnoremap <silent> <C-i> :nohlsearch<CR>

" Set specific directories for swap, undo, and backups.
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//
set undofile

"""""""""""""""""""""""""""""""""""""""""
" Ctrl-P Settings
"""""""""""""""""""""""""""""""""""""""""

" Keybinding and functionality
let g:ctrlp_map = "<leader>o"
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['line']

" Move Ctrl-P to top of the screen
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

" Ignore some filetypes
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_switch_buffer = 'E'
"let g:ctrlp_by_filename = 1
let g:ctrlp_clear_cache_on_exit = 0

" Uncomment to show hidden directories.
"let g:ctrlp_show_hidden = 1

"""""""""""""""""""""""""""""""""""""""""
" Airline (Powerline replacement)
"""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""
" NerdTree
"""""""""""""""""""""""""""""""""""""""""

" Directory tree toggle
nnoremap <leader>e :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""
" NerdCommenter
"""""""""""""""""""""""""""""""""""""""""

map <leader>cc <plug>NERDCommenterToggle

" For some reason, CommentToggle doesn't work unless this is
" remapped, so remapping it to something I won't ever use.
map <leader><D-/><space> <plug>NERDCommenterComment

""""""""""""""""""""""""""""""""""""""""
" UltiSnips
""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger = "<D-C>"
let g:UltiSnipsJumpForwardTrigger = "<D-W>"
let g:UltiSnipsJumpBackwardTrigger = "<D-S>"

"""""""""""""""""""""""""""""""""""""""""
" Easytags
"""""""""""""""""""""""""""""""""""""""""

let g:easytags_updatetime_min = 2000

"""""""""""""""""""""""""""""""""""""""""
" Tex Settings
"""""""""""""""""""""""""""""""""""""""""

let g:tex_flavor = "latex"
let g:LatexBox_latexmk_options = "-pvc -pdfps"
autocmd FileType tex setlocal spell spelllang=en_us

"""""""""""""""""""""""""""""""""""""""""
" Colors and Themes
"""""""""""""""""""""""""""""""""""""""""

syntax enable
"Set 256 color mode (not always needed).
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "xfce4-terminal"
  set t_Co=256
endif

" Use a nice color scheme
colors Monokai

""""""""""""""""""""""""""""""""""""""""
" Useful Stuff
""""""""""""""""""""""""""""""""""""""""

" Delete trailing whitespaces on saving.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

" Allow the use of ALT as a function key.
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" Close current window or vim if no unsaved windows are open.
fun! CloseWindow()
  if &modified
    echo "Save first or manual exit."
  else
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      q
    else
      :bd
    endif
  endif
endfunction
