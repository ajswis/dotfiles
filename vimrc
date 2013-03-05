" Use pathogen to load other plugins
execute pathogen#infect()
Helptags
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""
" Some Basics
"""""""""""""""""""""""""""""""""""""""""
"Note : vim-sensible does some of these settings already

set encoding=utf-8

" Search settings
set incsearch
set ignorecase
set smartcase
set hlsearch

" Indentation and tab functionality
set tabstop=4 
set shiftwidth=4
set softtabstop=4
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
set ttimeoutlen=50

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
                           \|     if empty(bufname('%'))
                           \|         browse confirm write
                           \|     else
                           \|         confirm write
                           \|     endif
                           \| endif
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
nnoremap <silent> <F10> :wincmd +<CR>
nnoremap <silent> <F9>  :wincmd -<CR>
nnoremap <silent> <A-F10> :wincmd ><CR>
nnoremap <silent> <A-F9>  :wincmd <<CR>
nnoremap <silent> <leader>r :wincmd r<CR>
nnoremap <silent> <leader>R :wincmd R<CR>

" Ctrl+d to duplicate a line, vmode versions is best for SHIFT+V, not the others
nnoremap <C-d> yyp 
vnoremap <C-d> y<C-o>p
inoremap <C-d> <C-o>:yank<CR><C-o>:put<CR>

" Open new files in new buffer or new windows
nnoremap <C-o> :e<space>
nnoremap <C-p> :sp<space>
nnoremap <A-p> :rightb vs<space>

" Move lines of text via Alt+[jk] (Like sublime!)
nnoremap <A-j> :m+1<CR>==
nnoremap <A-k> :m-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Clear searches so there aren't underlined words.
nnoremap <silent> <C-i> :nohlsearch<CR>

" Mapped keys for plugins, these are listed in respective plugin sections
"<leader>e => Nerd Tree Toggle
"<Leader>/ => NerdCommenterToggle
"<leader>T => Tag List Toggle
"<leader>o => CtrlP Toggle

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
map <leader><A-/><space> <plug>NERDCommenterComment

" Not sure if I want default c prefix or a different one.
" Note : Insert is disabled by default
"map <leader>/c\<space> <plug>NERDCommenterComment
"map <leader>/n <plug>NERDCommenterNested
"map <leader>/\<space> <plug>NERDCommenterToggle
"map <leader>/m <plug>NERDCommenterMinimal 
"map <leader>/i <plug>NERDCommenterInvert
"map <leader>/s <plug>NERDCommenterSexy
"map <leader>/y <plug>NERDCommenterYank
"map <leader>/$ <plug>NERDCommenterToEOL
"map <leader>/A <plug>NERDCommenterAppend
""map <leader>/ <plug>NERDCommenterInsert
"map <leader>/a <plug>NERDCommenterAltDelims
"map <leader>/b <plug>NERDCommenterAlignLeft
"map <leader>/l <plug>NERDCommenterAlignBoth
"map <leader>/u <plug>NERDCommenterUncomment

"""""""""""""""""""""""""""""""""""""""" 
" Useful Stuff
""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""" 
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""

" Unbind tab so as not to interfere with Ultisnips
let g:ycm_key_list_select_completion = ['<Enter>']

"""""""""""""""""""""""""""""""""""""""""
" TagList
"""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>t :TlistToggle<CR>

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
"if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
"	set t_Co=256
"endif

" Use a nice color scheme
colors Monokai

"""""""""""""""""""""""""""""""""""""""" 
" Useful Stuff
""""""""""""""""""""""""""""""""""""""""

" Return to last edit position on reopen
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
" Remember buffer info on close
set viminfo^=%

" For Python/Coffeescript, delete trailing white space
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

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
