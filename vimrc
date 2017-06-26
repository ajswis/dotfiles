" Use pathogen to load other plugins
execute pathogen#infect()
Helptags
filetype plugin indent on

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

" Command expiration
set timeout
set ttimeoutlen=15

" Set font for (m|g)vim
set guifont=Meslo\ LG\ S\ for\ Powerline:h11
set guioptions=ce
set mouse=a

set number      " Line numbers
set nowrap      " Line Wrapping
set hidden      " Just hide buffer when :bd'ing
set autoread    " Automatically update externally updated files
set cc=80       " Which line is the 80th column?
set splitright  " New window split settings
set splitbelow  " New window split settings
set viminfo^=%  " Remember buffer info on close

set completeopt=menu

set maxmempattern=8171906 " Because some files are big

""""""""""""""""""""""""""""
" Keybinds
""""""""""""""""""""""""""""

let mapleader="\<space>"

" Wrapped lines treated like normal ones
nnoremap j gj
nnoremap k gk

" Set CTRL+S to save becuase I smack that every 10 seconds on whatever application I use
command! -nargs=0 Save if &modified | confirm write | endif
nnoremap <silent> <C-s> :Save<CR>
inoremap <C-s> <C-o>:Save<CR>
vnoremap <C-s> <C-o>:Save<CR>

" CTRL+w to close the current buffer
nnoremap <silent> <C-w> :Sayonara<CR>
nnoremap <silent> <S-w> :hide<CR>

" Buffer magic
nnoremap <leader>l :ls<CR>:b<space>
nnoremap <leader>; :tabs<CR>:tabn<space>

" Switch indentation settings
nnoremap <leader>y :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nnoremap <leader>Y :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nnoremap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nnoremap <leader>M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>

" To wrap or not to wrap
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" Window Switching and Resizing
nnoremap <silent>   <C-k>   :wincmd k<CR>
nnoremap <silent>   <C-j>   :wincmd j<CR>
nnoremap <silent>   <C-h>   :wincmd h<CR>
nnoremap <silent>   <C-l>   :wincmd l<CR>
if has("nvim")
  nnoremap <silent>   <A-K>   :wincmd K<CR>
  nnoremap <silent>   <A-J>   :wincmd J<CR>
  nnoremap <silent>   <A-H>   :wincmd H<CR>
  nnoremap <silent>   <A-L>   :wincmd L<CR>
  nnoremap <silent>   <A-T>   :wincmd T<CR>
else
  nnoremap <silent>    K    :wincmd K<CR>
  nnoremap <silent>    J    :wincmd J<CR>
  nnoremap <silent>    H    :wincmd H<CR>
  nnoremap <silent>    L    :wincmd L<CR>
  nnoremap <silent>    T    :wincmd T<CR>
endif
nnoremap <silent>     +     :wincmd +<CR>
nnoremap <silent>     _     :wincmd -<CR>
nnoremap <silent>     )     :wincmd ><CR>
nnoremap <silent>     (     :wincmd <<CR>
nnoremap <silent> <leader>r :wincmd r<CR>
nnoremap <silent> <leader>R :wincmd R<CR>


" ALt+d to duplicate a line, vmode version is best for SHIFT+V, not the others
nmap Y y$
nnoremap <A-d> yyp
vnoremap <A-d> y<C-o>p
inoremap <A-d> <C-o>:yank<CR><C-o>:put<CR>

" Open new files in new buffer or new windows
nnoremap <C-p> :sp<space>
nnoremap <A-p> :vs<space>

" Move lines of text via alt+[jk]
nnoremap <silent> <A-j> :m+1<CR>==
nnoremap <silent> <A-k> :m-2<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Clear searches so there aren't underlined words.
nnoremap <silent> <C-i> :nohlsearch<CR>

" JSON formatting
nmap <silent> =j :FormatJSON<CR>

" Set specific directories for swap, undo, and backups.
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//
set viewdir=~/.vim/tmp/view//
set undofile

map <S-k> <nop>
map <S-q> <nop>

""""""""""""""""""""""""""""
" vim-rspec
""""""""""""""""""""""""""""

map <silent> <leader>t :call RunCurrentSpecFile()<CR>
map <silent> <leader>a :call RunAllSpecs()<CR>
map <silent> <leader>s :call RunNearestSpec()<CR>
map <silent> <leader>k :call RunLastSpec()<CR>
let g:rspec_command = "!if command -v rspec >/dev/null 2>&1; then rspec {spec}; else; bundle exec spec {spec}; fi"

""""""""""""""""""""""""""""
" Ctrl-P Settings
""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""
" Airline (Powerline replacement)
""""""""""""""""""""""""""""
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""
" NerdTree
""""""""""""""""""""""""""""

" Directory tree toggle
nnoremap <leader>e :NERDTreeToggle<CR>

""""""""""""""""""""""""""""
" NerdCommenter
""""""""""""""""""""""""""""

map <leader>cc <plug>NERDCommenterToggle

" For some reason, CommentToggle doesn't work unless this is
" remapped, so remapping it to something I won't ever use.
map <leader><A-/><space> <plug>NERDCommenterComment

""""""""""""""""""""""""""""
" Easytags
""""""""""""""""""""""""""""

set regexpengine=1
let g:easytags_updatetime_min = 4000

""""""""""""""""""""""""""""
" Tex Settings
""""""""""""""""""""""""""""

let g:tex_flavor = "latex"
let g:LatexBox_latexmk_options = "-pvc -pdfps"
au FileType tex setlocal spell spelllang=en_us

""""""""""""""""""""""""""""
" Rails.vim
""""""""""""""""""""""""""""

let g:rails_gem_projections = {
      \   "fabrication": {
      \     "spec/fabricators/*_fabricator.rb": {
      \       "command": "fabricator",
      \       "affinity": "model",
      \       "alternate": "app/models/%s.rb",
      \       "related": "db/schema.rb#%p",
      \       "test": "spec/models/%s_spec.rb",
      \       "template": "Fabricator :%s do\nend",
      \       "keywords": "Fabricate Fabricator sequence"
      \     }
      \   },
      \   "factory_girl_rails": {
      \     "spec/factories/*_factory.rb": {
      \       "command": "factory",
      \       "affinity": "collection",
      \       "alternate": "app/models/%i.rb",
      \       "related": "db/schema.rb#%s",
      \       "test": "spec/models/%i_spec.rb",
      \       "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \       "keywords": "factory sequence"
      \     }
      \   },
      \   "factory_girl": {
      \     "spec/factories/*_factory.rb": {
      \       "command": "factory",
      \       "affinity": "collection",
      \       "alternate": "app/models/%i.rb",
      \       "related": "db/schema.rb#%s",
      \       "test": "spec/models/%i_spec.rb",
      \       "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \       "keywords": "factory sequence"
      \     }
      \   },
      \   "jasmine": {
      \     "spec/javascripts/*_spec.coffee": {
      \       "command": "rice",
      \       "template": "describe %S, ->\n  ",
      \       "keywords": "describe it beforeEach expect loadFixtures xit"
      \     },
      \     "spec/javascripts/*_spec.js": {
      \       "command": "rice",
      \       "template": "describe(%S, function() {\n  \n})",
      \       "keywords": "describe it beforeEach expect loadFixtures xit"
      \     }
      \   },
      \   "interactor-rails": {
      \     "app/interactors/*.rb": {
      \       "command": "interactor",
      \       "template": "class %S\n\nend"
      \     },
      \   },
      \   "cucumber-rails": {
      \     "features/*.feature": {
      \       "command": "feature",
      \       "template": "Feature: %h\n\n  Scenario: " ,
      \     },
      \     "features/step_definitions/*_steps.rb": {
      \       "command": "steps",
      \       "affinity": "collection"
      \     }
      \   },
      \   "draper": {
      \     "app/decorators/*_decorator.rb": {
      \       "command": "decorator",
      \       "affinity": "model",
      \       "alternate": "app/models/%s.rb",
      \       "related": "db/schema.rb#%p",
      \       "test": "spec/decorators/%s_decorator_spec.rb",
      \       "template": "class %SDecorator < Draper::Decorator\n\nend",
      \       "keywords": "delegate_all"
      \     }
      \   }
      \ }

let g:rails_projections = {
      \   "app/services/*.rb": {"command": "service"}
      \ }
""""""""""""""""""""""""""""
" delimitMate
""""""""""""""""""""""""""""

let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

""""""""""""""""""""""""""""
" YCM Settings
""""""""""""""""""""""""""""

let g:ycm_register_as_syntastic_checker = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_log_level = 'error'

""""""""""""""""""""""""""""
" Colors and Themes
""""""""""""""""""""""""""""

syntax enable
"Set 256 color mode (not always needed).
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "xfce4-terminal"
  set t_Co=256
endif

" Use a nice color scheme
colors monokai

""""""""""""""""""""""""""""""""""""""""
" Useful Stuff
""""""""""""""""""""""""""""""""""""""""

" Delete trailing whitespaces on saving.
function! DeleteTrailingWS()
  if !exists('b:noStrip')
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
  endif
endfunction
au BufWrite * :call DeleteTrailingWS()
au FileType go let b:noStrip=1

if !has("nvim")
  " Allow the use of ALT as a function key.
  let c='a'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
endif

" For auto-aligning '|' delimited tables
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Set tabline at the top
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let bufnr = tabpagebuflist(tab)[tabpagewinnr(tab) - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab . (bufmodified ? '+' : '') . ': '
    let s .= (bufname != '' ? fnamemodify(bufname, ':t') . ' ' : '--- ')
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()

" Go settings
au BufRead,BufNewFile *.go set filetype=go
au BufWrite *.go :GoImports
au FileType go map <buffer> <silent> <leader>t :GoTest<CR>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_generate_tags = 1
let g:syntastic_go_checkers = ['go', 'gofmt', 'golint', 'govet', 'errcheck']
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

" JSON things
let g:vim_json_syntax_conceal = 1
com! FormatJSON %!python -m json.tool

" Operator highlighting
let g:ophigh_highlight_link_group = "Operator"

" Filetypes
au BufRead,BufNewFile *.Dockerfile set filetype=dockerfile
au BufRead,BufNewFile *.xsd set filetype=xml
au BufRead,BufNewFile *.wsdl set filetype=xml

