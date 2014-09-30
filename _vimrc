" vim: set ft=vim ts=4 sw=4 sts=4  foldmethod=marker :
" 
" VIM seting file
"
" Author : Hajime MATSUMOTO <mail@hazime.org>
" 

" setting {{{
set nocompatible               " disable compatible with vim
set autoread                   " autoread when other process rewrites
set backspace=start,eol,indent " backspace to delete everything

set swapfile       " enable swapfile
"set directory=/tmp " where swapfile store
set backup         " enable backup
set backupdir=/tmp " where backupfile store
set viminfo='50,\"1000,n"~/.vim/info " recent 50files info, 1000registers store in ~/.vim/info

set ignorecase " ignore capital or not
set smartcase  " do not ignore capital when search words includs both
"set splitright
"set splitbelow
set wrap
set textwidth=0


" restore last edited position
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

set clipboard=unnamed,autoselect
" }}}

" display {{{
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932

"set hlsearch   " enable highlight when search words hit
set nohlsearch   
set ruler
set title
set modeline                   " use mode-line
set modelines=5                " mode-line efective lins are until 5
set showmode                   " show current mode
set showcmd                    " show current command
set wildmenu                   " place of menu
set number                     " show line number
set scrolloff=8
syntax on
set t_Co=256
set lcs=tab:>-,trail:-,nbsp:%
set list
highlight SpecialKey cterm=NONE ctermfg=7 guifg=7
highlight JpSpace cterm=underline ctermfg=7 guifg=7
highlight FirstSpace cterm=underline ctermfg=7 guifg=7
au BufRead,BufNew * match JpSpace /　/
au BufRead,BufNew * match FirstSpace /^\s/
" }}}

" mouse {{{
set mouse=a " enable mouse
set ttymouse=xterm2 " mouse can drag
" }}}

" indent {{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent
set noexpandtab
set nosmarttab
filetype plugin indent on
" }}}

" keybind {{{
nnoremap ZZ :wq
nnoremap ZQ <Nop>
nnoremap Q <Nop>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap jj <ESC>


set pastetoggle=<F2>
nnoremap <Space>m :<C-u>marks
nnoremap <Space>r :<C-u>register

nnoremap <Leader>v <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <ESC><ESC> :nohlsearch<CR><ESC> 

nnoremap ; :
"let mapleader = ","
"noremap \ ,
" }}}

" Programming {{{
set showmatch
"set foldmethod=marker
set grepprg=internal
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType sass       setlocal sw=2 sts=2 ts=2 et
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
autocmd FileType php       setlocal sw=4 sts=4 ts=4 et
" }}}

" status line {{{
set showcmd
set laststatus=2
" }}}

" NeoBundle {{{
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
filetype plugin indent on
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
filetype on


NeoBundle 'othree/html5.vim.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'h1mesuke/vim-alignta.git' 
NeoBundle 'tpope/vim-fugitive' 
NeoBundle 'taglist.vim'
NeoBundle 'kchmck/vim-coffee-script'

" testing
"NeoBundle 'claco/jasmine.vim'
"NeoBundle 'osyo-manga/vim-gift'
"NeoBundle 'osyo-manga/vim-automatic'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/shabadou.vim'
"NeoBundle 'mattn/emmet-vim'
"NeoBundle 'lunaru/vim-twig'
"NeoBundle 'evidens/vim-twig'
NeoBundle "basyura/TweetVim"
NeoBundle "basyura/twibill.vim"

" quick run
NeoBundle 'thinca/vim-quickrun' 

" Shougo Series
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc',{'build': 
\	{
\		'windows': 'make -f make_windows.mak',
\		'cygwin': 'make -f make_cygwin.mak',
\		'mac': 'make -f make_mac.mak',
\		'unix': 'make -f make_unix.mak',
\	}
\}
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neosnippet' 
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'szw/vim-tags'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'kannokanno/unite-dwm'
" }}}

" neocomple {{{
function! s:meet_neocomplete_requirements()
	return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundleFetch 'Shougo/neocomplcache.vim'
else
	NeoBundleFetch 'Shougo/neocomplete.vim'
	NeoBundle 'Shougo/neocomplcache.vim'
endif


" }}}

" plugin setting {{{

if neobundle#is_installed('neocomplete')
	let g:neocomplcate#enable_at_startup=1
endif
if neobundle#is_installed('neocomplcache')
	let g:neocomplcache#enable_at_startup=1
endif

" vimfiler " {{{
nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default= 0
autocmd FileType vimfiler call unite#custom_default_action('directory','cd')
nnoremap <silent> [vimfiler]i :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" }}}

nnoremap [vimshell] <Nop> " {{{
nmap <Leader>s [vimshell]
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "
nnoremap <silent> [vimshell]s :<C-u>VimShell<CR>
nnoremap <silent> [vimshell]p :<C-u>VimShellPop<CR>
nnoremap <silent> [vimshell]b :<C-u>VimShellBufferDir -popup<CR>
nnoremap <silent> [vimshell]t :<C-u>VimShellTab<CR>
nnoremap <silent> [vimshell]rb :<C-u>VimShellInteractive irb<CR>
nnoremap <silent> [vimshell]py :<C-u>VimShellInteractive python<CR>
nnoremap <silent> [vimshell]ph :<C-u>VimShellInteractive php -a<CR>
nnoremap <silent> [vimshell]my :<C-u>VimShellInteractive mysql -u root -p<CR>
" }}}

" unite {{{
nnoremap [unite] <Nop> 
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'osyo-manga/unite-fold'
NeoBundle 'taka84u9/unite-git'
NeoBundle 'thinca/vim-unite-history'

nnoremap <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <C-b> :<C-u>Unite buffer file dwm file_mru directory_mru<CR>
nnoremap <C-d> :<C-u>Unite dwm outline fold <CR>
nnoremap <C-y> :<C-u>Unite history/yank<CR>

nmap <Leader>f [unite]
let g:unite_source_history_yank_enable=1
let g:unite_enable_start_insert=1

nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]d :<C-u>Unite dwm<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]c :<C-u>Unite colorschame<CR>
nnoremap <silent> [unite]r :<C-u>Unite mark<CR>
nnoremap <silent> [unite]h :<C-u>Unite fold<CR>
nnoremap <silent> [unite]g :<C-u>Unite git_cached<CR>
nnoremap <silent> [unite]gm :<C-u>Unite git_modified<CR>
nnoremap <silent> [unite]gu :<C-u>Unite git_unstaged<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " タブで開く
    nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
    " vimfiler で開く
    "nnoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    "inoremap <silent> <buffer> <expr> <C-O> unite#do_action('vimfiler')
    " dwm.vim で開く
    nnoremap <silent> <buffer> <expr> <C-O> unite#do_action('dwm_new')
    inoremap <silent> <buffer> <expr> <C-O> unite#do_action('dwm_new')
    " 終了
    nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
endfunction
" }}}

" dwm {{{
" let g:dwm_master_pane_width=80
let g:dwm_map_keys=0

nnoremap <c-j> <c-w>w
nnoremap <c-k> <c-w>W
"nmap <m-r> <Plug>DWMRotateCounterclockwise
"nmap <m-t> <Plug>DWMRotateClockwise
"nmap <c-n> <Plug>DWMNew
nmap <c-c> <Plug>DWMClose
nmap <c-@> <Plug>DWMFocus
nmap <c-Space> <Plug>DWMFocus
nmap <c-l> <Plug>DWMGrowMaster
nmap <c-h> <Plug>DWMShrinkMaster
" }}}

" neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'

nmap <Leader>se :<C-u>NeoSnippetEdit<CR>
" }}}

" neocomplete {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
if s:meet_neocomplete_requirements()
	" 新しく追加した neocomplete の設定
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  return neocomplete#close_popup() . "\<CR>"
	  " For no inserting <CR> key.
	  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplete#close_popup()
	inoremap <expr><C-e>  neocomplete#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplete#enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplete#enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
else
	" 今までの neocomplcache の設定
endif
" }}}

" coffee scriot {{{
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
" }}}

" quick run {{{
let g:quickrun_config={
\ "_": {
\	"hook/close_unite_quickfix/enable_hook_loaded": 1,
\	"hook/unite_quickfix/enable_failure": 1,
\	"hook/close_quickfix/enable_exit": 1,
\	"hook/close_buffer/enable_failure": 1,
\	"hook/close_buffer/enable_empty_data": 1,
\	"outputter" : "multi:buffer:quickfix",
\	"hook/shabadoubi_touch_henshin/enable" : 1,
\	"hook/shabadoubi_touch_henshin/wait" : 20,
\	"outputter/buffer/split" : ":botright 8sp",
\	"runner" : "vimproc",
\	"runner/vimproc/updatetime" : 40
\ }
\}
" }}}

" automatic {{{
" }}}
"
"

" }}} 

"color scheme
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'

NeoBundle 'sudo.vim'
NeoBundle 'nginx.vim'
au BufRead,BufNewFile nginx.conf set ft=nginx

"set background=light
set background=dark
colorscheme jellybeans
"colorscheme hybrid
"colorscheme hybrid-light
"colorscheme railscasts
"colorscheme solarized
"colorscheme molokai
"colorscheme lucius
"colorscheme zenburn
"colorscheme mrkn256

" use power line
NeoBundle 'Lokaltog/vim-powerline'
"let g:Powerline_symbols ='fancy'


" filetype {{{
augroup filetypedetect
"	au BufRead,BufNewFile *.twig set filetype=htmljinja
augroup END

"autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
"autocmd BufWritePost *.php silent make!<CR>:cwindow<CR>

" php {{{
augroup PHP
	autocmd!
	autocmd FileType php set makeprg=php\ -l\ %
	autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
	" autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
augroup END
" }}}
" }}}

" startup {{{
let g:unite_source_alias_aliases = {
\"startup_file" : {
\	"source" : "file",
\},
\"startup_file_mru" : {
\	"source" : "file_mru",
\},
\"startup_directory_mru" : {
\	"source" : "directory_mru",
\}
\}

call unite#custom_max_candidates("startup_file", 10)
call unite#custom_max_candidates("startup_file_mru", 5)
call unite#custom_max_candidates("startup_directory_mru", 5)

if !exists("g:unite_source_menu_menus")
	let g:unite_source_menu_menus = {}
endif
let g:unite_source_menu_menus.startup = {
\   "description" : "startup menu",
\   "command_candidates" : [
\       [ "vimrc",  "edit " . $MYVIMRC ],
\       [ "vimshell",  "VimShell" ],
\       [ "unite-file", "Unite file" ],
\       [ "unite-file_mru", "Unite file_mru" ],
\       [ "unite-directory_mru", "Unite directory_mru" ],
\   ]
\}

command! UniteStartup
 \	Unite
 \	output:echo\ "====\ menu\ ====" menu:startup
 \	output:echo\ "\ "
 \	output:echo\ "====\ file\ ====" startup_file
 \	output:echo\ "\ "
 \	output:echo\ "====\ file\ mru\ ====" startup_file_mru
 \	output:echo\ "\ "
 \	output:echo\ "====\ directory\ mru\ ====" startup_directory_mru
 \	output:echo\ "\ "
 \	-hide-source-names
 \	-no-split
 
 augroup startup
 	autocmd!
 	autocmd VimEnter * nested if @% == '' | UniteStartup 
 augroup END
" }}}
