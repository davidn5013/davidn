vim9script	       
set nocompatible
set autoread					# auto re-read fle on change
set noautochdir					# Made cd manual note work.. cd on openfile
set backspace=indent,eol,start	# make backspace work as you would expect
set belloff=all					# the bell will be silenced
set completeopt=longest,menuone	# wildmenu settings
set display+=lastline			# When included, as much as possible of the last line in a window will be displayed.  When not included, a last line that doesn't fit is replaced with "@" lines. 
set encoding=utf-8				# windows encoding
set fileencoding=utf-8			# Sets the character encoding for the file of this buffer.
set fileformat=unix				# default is windows format
set fileformats=unix,dos		# onlu dos as a test
set fo+=w						# wrap without breaking words
set foldmethod=syntax
set foldnestmax=3
set nofoldenable
set hidden						# switch between buffers without having to save first.
set history=2000				# increase command history
set listchars=tab:→\ ,eol:↓,nbsp:﮲,trail:•,extends:⟩,precedes:⟨,space:· #	set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< 
set nomore					# no pause if output longer them screen
set mouse=a	   				# mouse scroll and paste only normal and visual mode 
set noswapfile nowrap          
# Mysettings before try complete from https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set omnifunc=syntaxcomplete#Complete
set path=.,**,$home\dropbox\**
set shiftround					# >> indents to next multiple of 'shiftwidth'.
set shiftwidth=4				# >> indents by 2 spaces.
set shm+=I						# shortmess Turn of intro screen
set breakindent
set breakindentopt=sbr
set sidescroll=1
set showbreak=↪>				# Warp char another one is:↘ 
set ignorecase					# ignorecase in search
set smartcase					# don't ignore case if search word start with uppercase
set nosmarttab					# tab like the like the rest of the file
set softtabstop=4				# tab key indents by 2 spaces.
set spelllang=sv				# swedish spell check
set splitbelow		
set tabstop=4					
set textwidth=0 wrapmargin=0	# do note save line broken in wrap
set backup
set number rnu

if has('nvim') || has('gvim') 
	set backupdir=~/appdata/local/nvim/backup
	set undodir=~/appdata/local/nvim/undo		# persisten undo windows
elseif has('win32')
	set backupdir=$HOME\vimfiles\backup
	set undodir=$HOME\vimfiles\undo				# persisten undo windows
else 
	set backupdir=~/.vim/backup
	set undodir=~/.vim/undo			# persisten undo windows
endif

set undofile
set undolevels=5000				# 2 times bigger undo check catalog size...
# set virtualedit=all
set wildmode=longest,list:lastused

if has('vimwin32')
	set wildoptions=pum
endif

set autoindent
# set fillchars='vert: ,fold:-,eob: '
set tw=80

set sessionoptions=blank,buffers,curdir,folds,tabpages,winpos,winsize,terminal	# Stop from saving mapping in session file

# 256 Color
set t_Co=256        

#if has('win32')
#      set shellcmdflag=/d/c			# Don't run extra shell as clink, turn echo off, use unicode
#      # set shellcmdflag=/d/q/u/c		# Don't run extra shell as clink, turn echo off, use unicode
#endif

g:mapleader = " "
#let mapleader = ' '
filetype plugin indent on      			# load plugins according to detected filetype.
syntax on								# enable syntax highlighting.

# Fix swedish keyboard map å $ map ö { map ä } map Ö ( map Ä )
# settings swedish keyboard command at the same place as us keyboard
set langremap			# default on 
set langmap=ö{Ö(ä}Ä)å$
map ö {
map ä }
map <m-ö> (
map <m-ä> )
map <c-ö> [
map <c-ä> ]

# Extra highlighted words
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo


#      _         _         
#  ___| |_ _ ___|_|___ ___ 
# | . | | | | . | |   |_ -|
# |  _|_|___|_  |_|_|_|___|
# |_|       |___|          
# The order need to be preserved or the plugging stop working
# Show on error on missing plug.vim
#if match(&runtimepath, 'MY-PLUGIN') != -1
if has('win32')
	plug#begin('$home\vimfiles\plugged')
else 
	plug#begin('~/.vim/plugged')
endif
	Plug 'vim-scripts/zoom.vim'				# Mouse wheel zoom. Testing if it work in gvim and nvim	
	# Plug 'itchyny/lightline.vim'				# A light and configurable statusline/tabline plugin for Vim
		
	Plug 'morhetz/gruvbox'					# Color scheme gruvbox

	Plug 'junegunn/fzf.vim'					# tool searcher
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	# tool search command
		
	Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }	# easy when creating catalogs

	Plug 'svermeulen/vim-yoink'				# Add yank history of 100 and paste does not clear
	Plug 'tpope/vim-commentary'				# Tool comment any language
		
	# Go module 
	Plug 'fatih/vim-go'
		
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'}	# branched undotree
	Plug 'preservim/tagbar'

	# , { 'on': 'TagbarToggle' }	# tool source code naviation in sidebar
	# Plug 'mg979/vim-visual-multi', { 'branch': 'master'}	# multi cursor that works!
	# Plug 'vim-scripts/camelcasemotion'			# camelCase motion
	# Easy motion solutions
	# Plug 'justinmk/vim-sneak'
			
	if hostname() != 'Surface'
		Plug 'w0rp/ale'							# Asyncron linting multi languages including go
		Plug 'frazrepo/vim-rainbow'				# Colorize parenthesis []{} 
		g:rainbow_active = 1
		Plug 'vim-scripts/AutoComplPop'
	endif

call plug#end()
#else
#	echo "Missing plug.vim"
#endif

if hostname() != 'Surface'
	g:acp_enableAtStartup = 1
	# > ALE CONFIG
	# Enable completion where available.
	g:ale_completion_enabled = 1
	g:ale_sign_error = '>'
	g:ale_sign_warning = '.'
	g:acp_enableAtStartup = 0
	# set laststatus=2					# Always show status line
endif

#okey schemes desert evening habamax pablo slate lunaperchegruvbox
# This if on work on plugin coloscheme
# if !empty(globpath(&rtp, 'gruvbox'))
colorscheme gruvbox 
# endif

set background=dark

# open omni completion menu closing previous if open and opening new menu without changing the text
 inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
 	 \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

# normal autocommand move upp 
# from comflict
augroup generalautocmd
	autocmd!
	# autocmd BufEnter * silent! lcd %:p:h
	autocmd Filetype text setlocal textwidth=80 wrap 
	autocmd FileType qf silent! setlocal wrap 
	autocmd FileType qf call AdjustWindowHeight(3, 10)
	autocmd FileType python silent! setlocal expandtab 

	# if match(&runtimepath, 'tagbar') != -1
	# 	let g:tagbar_width = 18
	# 	autocmd FileType c,cpp,objc,objcpp,python,go,vim,lua,bas,init call tagbar#OpenWindow()  
	# endif
	
	if match(&runtimepath, 'vim-rainbox') != -1
		autocmd FileType c,cpp,objc,objcpp,python,go,vim,lua,bas,init call rainbow#active()
	endif

augroup end 

# Zoom.vim uses +- for zoom but I used to ctrl+-
nnoremap <c-0> :ZoomReset<CR>
nnoremap <C-ScrollWheelUp> :ZoomIn<CR>
nnoremap <C-+> :ZoomIn<CR>
nnoremap <C-ScrollWheelDown> :ZoomOut<CR>
nnoremap <C-_> :ZoomOut<CR>					# Ctrl and minus did not work ctrl underscore does the same???

# yoink settings
# On run if yank exist so we don't end up not having paste in any situation 
if match(&runtimepath, 'yoink') != -1
	# let g:yoinkMaxItems = 100

 	nmap p <plug>(YoinkPaste_p)
 	nmap P <plug>(YoinkPaste_P)
 	# Also replace the default gp with yoink paste so we can toggle paste 
 	# in this case too
 	nmap gp <plug>(YoinkPaste_gp)
 	nmap gP <plug>(YoinkPaste_gP)

 	nmap [y <plug>(YoinkRotateBack)
 	nmap ]y <plug>(YoinkRotateForward)

 	nnoremap <m-P> <plug>(YoinkRotateBack)
 	nnoremap <m-p> <plug>(YoinkRotateForward)
	nnoremap <silent> <leader>v :Yanks<cr>

endif

#  ░▒█░░▒█░░▀░░█▀▄▀█░░░░▒█▀▀█░▄▀▀▄░░░▒█▀▀▄░▄▀▀▄░█▀▀▄░█▀▀░░▀░░█▀▀▀
#  ░░▒█▒█░░░█▀░█░▀░█░▀▀░▒█░▄▄░█░░█░░░▒█░░░░█░░█░█░▒█░█▀░░░█▀░█░▀▄
#  ░░░▀▄▀░░▀▀▀░▀░░▒▀░░░░▒█▄▄▀░░▀▀░░░░▒█▄▄▀░░▀▀░░▀░░▀░▀░░░▀▀▀░▀▀▀▀
# #GO GoLang config
if match(&runtimepath, 'vim-go') != -1

	g:go_addtags_transform = "camelcase"
	g:go_code_completion_enabled = 0		# I do not think I need this when using vim-lsp
	g:go_fmt_command = 'goimports'			# default gopls
	g:go_fmt_fail_silently = 0 
	g:go_gopls_enabled = 1
	g:go_info_mode = 'gopls'
	g:go_auto_type_info = 1
	g:go_def_mode = 1

	if hostname() != 'Surface'
		g:go_auto_type_info = 0	
		g:go_code_completion_enabled = 0		# I do not think I need this when using vim-lsp
		g:ale_completion_enabled = 0
		
		# g:go_highlight_functions = 1
		# g:go_highlight_types = 1
		# g:go_highlight_function_calls = 1
		# g:go_highlight_build_constraints = 1
		# g:go_highlight_chan_whitespace_error = 1
		# g:go_highlight_extra_types = 1
		# g:go_highlight_fields = 1
		# g:go_highlight_format_strings = 1
		# g:go_highlight_function_parameters = 1
		# g:go_highlight_operators = 1
		# g:go_highlight_variable_assignments = 1
		# g:go_highlight_variable_declarations = 1
		
	endif

	augroup gofilehandeling
		autocmd!
		autocmd filetype go command! LspRestart :call go#lsp#Restart()
		# autocmd filetype go setlocal number rnu 
		autocmd filetype go setlocal omnifunc=go#complete#Complete
		# autocmd filetype go :AutoComplPopEnable
    
		# TODO: different key if ale is not load on slower machines
		# Extra commands
		autocmd filetype go nmap <silent> <buffer> <leader>gr <plug>(go-run)
		autocmd filetype go nmap <silent> <buffer> <f8> :Run Go run .<cr>
		autocmd filetype go nmap <silent> <buffer> <leader>gb <plug>(go-build)
		autocmd filetype go nmap <silent> <buffer> <f5> <plug>(go-build)
		autocmd filetype go nmap <buffer> <leader>gc <plug>(go-callers)
		
		if hostname() != 'Surface'
			autocmd filetype go nmap <silent> <buffer> <leader>gn :ALERename<cr>
			autocmd filetype go nmap <silent> <buffer> <leader>gd :ALEGoToDefinition<cr>
			autocmd filetype go nmap <silent> <buffer> <leader>gD :ALEGoToImplementation<cr>
		endif

		autocmd filetype go nmap <buffer> <leader>gi <plug>(go-info)
		autocmd filetype go nmap <silent> <buffer> <leader>gt <plug>(go-test)
		autocmd filetype go nmap <silent> <buffer> <f7> <plug>(go-test)
		autocmd filetype go nmap <silent> <buffer> <leader>gtt :GoTestCompile<cr>
		autocmd filetype go nmap <silent> <buffer> <f6> <bar> :GoTestCompile<cr>
		autocmd filetype go nmap <buffer> <leader>ge <plug>(go-iferr)
		autocmd filetype go nmap <buffer> <leader>gf <plug>(go-referrers)
		autocmd filetype go nmap <buffer> <leader>gj <plug>(go-alternate-edit)
      
		if hostname() != 'Surface'
			autocmd filetype go nmap <buffer> <leader>gn <plug>(go-rename)
			autocmd filetype go nmap <buffer> <buffer> <leader>gS <plug>(go-implements)
			autocmd filetype go nmap <silent> <buffer> <leader>gd <plug>(go-def)
		endif

		# navigate quicklist
		autocmd filetype go nnoremap <buffer> <silent> <leader>ä :GoDecls<CR>

		if has('win32')
			autocmd filetype go nnoremap <buffer> <silent> <leader>7 :e $dev/go/src/snippets.md<cr>
			autocmd filetype go nnoremap <buffer> <silent> <leader>6 :e $pgo/gonotes.md<cr>
			autocmd filetype go nnoremap <buffer> <silent> <leader>5 :e $dev/vim/abrev/goAbre.vim<cr>
			autocmd filetype,BufWritePost go redraw! | source $dev/vim/abrev/goAbre.vim 
		endif
      
		autocmd filetype go inoremap <buffer> ö {
		autocmd filetype go inoremap <buffer> ä }
		autocmd filetype go inoremap <buffer> <m-ö> (
		autocmd filetype go inoremap <buffer> <m-ä> )
		autocmd filetype go inoremap <buffer> <c-ö> [
		autocmd filetype go inoremap <buffer> <c-ä> ]
      	
		# Source Go abrevation

	augroup end

endif

# Load Go-Lang Abrevation from Dropbox

# test from https://github.com/ncm2/ncm2

# When the <Enter> key is pressed while the popup menu is visible, it only
# hides the menu. Use this mapping to close the menu and also start a new
# line.
# inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

# Use <TAB> to select the popup menu:
# inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
# inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

# #autocomplete -- Has to be after vim-go config
# This will change the behavior of the <Enter> key when the popup menu is visible. In that case the Enter key will simply select the highlighted  menu item, just as <C-Y> does.  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" These two mappings further improve the completion popup menu: In the above mappings, the first will make <C-N> work the way it  normally does; however, when the menu appears, the <Down> key will be  simulated. What this accomplishes is it keeps a menu item always highlighted. " This way you can keep typing characters to narrow the matches, and the nearest  match will be selected so that you can hit Enter at any time to insert it.  In the above mappings, the second one is a little more exotic: it simulates  <C-X><C-O> to bring up the omni completion menu,  then it simulates <C-N><C-P> to remove the longest common text, and finally  it simulates <Down> again to keep a match highlighted. 
# inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
# 	\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
              
# inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
# 	\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

# com! -nargs=1 CD :cd "<args>"<cr><bar>NERDTreeCWD "<args>"<cr>
## Fast esc
inoremap kj <esc>

## Q nope
nnoremap Q <nop>

## Muscle memory adatioons
behave mswin 
## vnoremap <c-c> "*<plug>(YoinkYankPreserveCursorPosition)
vnoremap <c-c> "*y
inoremap <c-c> "*y
nnoremap <c-v> "*P
vnoremap <c-v> "*P
inoremap <c-v> <esc>"*pi
nnoremap <silent> <c-p> <esc>"*P
# line to line move in 
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
# Move to middle of line
map gm :call cursor(0, virtcol('$')/2)<CR>
# Search next space
# nnoremap g<space> /<space><cr>
# vnoremap g<space> /<space><cr>
# cnoremap g<space> /<space><cr>
# Arrow home/end/page keys in visual mode
vnoremap <left> h
vnoremap <right> l
vnoremap <up> k 
vnoremap <down> j
vnoremap <home> 0
vnoremap <end> $
vnoremap <pageup> <c-u>
vnoremap <pagedown> <c-d>

# indent Do not overrite <tab> because that overwrite ctr-i (insert tas tab in 
# and normal mode ctrl-i is back and that good to have
nnoremap <tab> >>
nnoremap <S-tab> <<
vnoremap <tab> >gv
vnoremap <S-tab> <gv
vnoremap < <gv
vnoremap > >gv

# commentary vscode like
xnoremap <C-'> <Plug>Commentary
inoremap <C-'> <esc><Plug>Commentary<cr>i
onoremap <C-'> <Plug>Commentary
nnoremap <C-'> <Plug>CommentaryLine

# c-del backspace word delete
inoremap <c-bs> <esc>bdwi
inoremap <s-c-bs> <esc>ddA
nnoremap <c-bs> dbw
nnoremap <s-c-bs> dd
# stamping - overwrite with paste
nnoremap <c-s> "_diWP
xnoremap <c-s> "_d"0P
vnoremap <c-s> "_d"0P 
# Swith buffer
nnoremap <silent> <leader>, <c-^>

# create cd command to file path in system clipboard
nnoremap cp :let @* = "cd \"" . expand("%:p:h") . "\""<cr>

# Leader remapping in qwerty order
if has('win32')
	# Show undo tree 
	nnoremap <silent> <leader>8 :e + $db\Davids fritids dokument\Clipboard archive\nottoself.txt<cr>
	nnoremap <silent> <leader>9 :e + $db\Davids fritids dokument\Clipboard archive\clipboard.txt<cr>
endif
nnoremap <silent> <leader>+ :BLines<cr>
nnoremap <silent> <leader>0 :Lines<cr>
nnoremap <silent> <leader>q :Wt<cr>
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>s :setlocal spell! spelllang=sv<cr>
nnoremap <silent> <leader>e :setlocal spell! spelllang=en_us<cr>
nnoremap <silent> <leader>r :setlocal wrap! linebreak!<cr>
nnoremap <silent> <leader>, :setlocal number! rnu!<cr>
nnoremap <silent> <leader>u :source $MYVIMRC<cr>
nnoremap <silent> <leader>i :cd $pgo<cr>
nnoremap <silent> <leader>o :NERDTreeToggle<cr>
nnoremap <silent> <leader>p :FZF<cr>
nnoremap <silent> <leader>d :edit $MYVIMRC<cr>
nnoremap <silent> <leader>gg :call fzf#vim#history()<cr>
nnoremap <silent> <leader>h :split<cr>
nnoremap <silent> <leader>j :bp<cr>
nnoremap <silent> <leader>k :bn<cr>
nnoremap <silent> <leader>l :vsplit<cr>

# no realy leader keys but it fits here
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>
nnoremap <silent> <c-l> :wincmd l<cr>

# terminal keys
tnoremap <silent> <c-h> <cmd>wincmd h<cr>
tnoremap <silent> <c-j> <cmd>wincmd j<cr>
tnoremap <silent> <c-k> <cmd>wincmd k<cr>
tnoremap <silent> <c-l> <cmd>wincmd l<cr>
tnoremap <silent> <c-b> <cmd>bp<cr>
tnoremap <silent> <c-n> <cmd>bn<cr>

# buffer list for vim
nnoremap <silent> <leader>ö :call fzf#vim#buffers('', {'options': '--no-preview'})<cr>
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>C :bw<cr>
nnoremap <silent> <leader>n :enew!<cr>

nnoremap <silent> <f3> :UndotreeToggle<cr>
nnoremap <silent> <f4> :TagbarToggle<cr>

# abbreviations and #commands
# ####################################################################
# Size for all preview windows
set previewheight=8

if has('Win32') 
	command! Wt :silent !wt -d .<cr>

	fun Run(cmd)
		silent exe "write"
		silent exe "noautocmd botright pedit ".a:cmd
		noautocmd wincmd P
		silent exe "normal ggVGD"
		set buftype=nofile
		silent exe "noautocmd r! ".a:cmd
		silent exe "normal ggdd"			
		noautocmd wincmd p
	endfun
	com! -nargs=1 Run :call Run("<args>")

	fun Runarg(cmd)
		silent exe "write"
		silent exe "noautocmd botright pedit ".a:cmd
		noautocmd wincmd P
		silent exe "normal ggVGD"
		set buftype=nofile
		silent exe "noautocmd r! ".a:cmd." ".input('Command argument:')
		silent exe "normal ggdd"			
		noautocmd wincmd p
	endfun
	com! -nargs=1 Runarg :call Runarg("<args>")
endif

var hidden_all = 0

def ToggleHiddenAll()
    if hidden_all  == 0
        hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
enddef

nnoremap <silent> <leader>. :call ToggleHiddenAll()<CR>

def AdjustWindowHeight(minheight: string, maxheight: string)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
enddef

def Listmappinginbuffer()
	redir @m
	map
	redir END
	vnew
	put m
enddef

if has('win32')
	# This will copy the path in 8.3 short format, for DOS and Windows 9x
	nmap <silent> ,cd exe 'let @=expand("%p:8")
endif

# Convert slashes to backslashes for Windows. 
if has('Win32')
	#com! -nargs=0 Filenameput redir @" | silent echo expand("%:p:8") | redir END | put! 
	# %% on the command line to expand to the path of the current file
	cabbr <expr> %% expand('%:p:8')
	cabbr <expr> %%p expand('%:p:h')
endif

#command! Home cd $userprofile
# Remove ^M newline \r from file
command! Rmm %s/\r//g
# Delete empty lines (and blank lines ie whitespace)
command! Rmemptylines v/\S/d
# Remove trailing spaces
#%retab! Retabulte the whole file
command! Rmtrailspace :%s/\s\+$//e

# For local replace
#nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>        :

# For global replace
#nnoremap gR gD:%s/<C-R>///gc<left><left><left>

# Not running gvim but runing windows
# In cli
set background=dark

if has("gui_running") == 0 && has("windows") == 1
	# Only in windows shell not gvim or unix
endif

#def- Toggle terminal
var toggle_term = "<leader>b"
# let s:term_buf_nr = -1
def ToggleTerminal()
    " if s:term_buf_nr == -1 
        execute "bot term"
        let s:term_buf_nr = bufnr("$")
    # else
        " execute "bd! " .s:term_buf_nr
        # let s:term_buf_nr = -1
    # endif
enddef

execute "nnoremap " toggle_term " :call ToggleTerminal()<CR>"
execute "tnoremap " toggle_term " <C-w>N :call ToggleTerminal()<CR>"
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>> G V I M >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		#utocmd FileType go autocmd BufWritePre <buffer> source 
		#$dev/vim/abrev/goAbre.vim
		##gvim IN GUI AND ON WINDOWS

if has("gui_running")  
	execute 'set guifont=Iosevka_NFM:h14:W400:cANSI:qDRAFT'
	#Fonts font need to installed on user lever for gvim to see them
	#let g:newfont='Monoid_NFM'
	#let g:newfont='Source_Code_Pro'
	#let g:newfont='VictorMono_NFM'
	var newfont = "Iosevka_NFM"
	var newfontsetting = ":W400:cANSI:qDRAFT"
	# Fontsize
	def Initfont() 
		var font_size = '14'
		var font_string = newfont .. ':h' .. font_size .. newfontsetting
		execute 'set guifont=' .. font_string
	enddef

	if !exists("s:set_font_size_onetime") 
		var set_font_size_onetime = 1
		Initfont()
	endif
	com! -nargs=0 ResetFontZoom :call Initfont() 
	# turn off menubar
	# set guioptions -=m
	# turn off toolbar 
	# set guioptions -=T
	# turn off gui tabs
	# set guioptions -=e
	# turn off scrollbar
	# set guioptions -=r
	# set guioptions -=R
	# dark theme
	# set guioptions +=d
	# set guioptions +=!
	# set termguicolors=true     
	# Keep windows size when changing font size	
	# set guioptions+=k"
	
	set guioptions=Ace 
	# Maximise screen
	# augroup guisize
	# au!
	# au GUIEnter * simalt ~x
	# augroup end
	# Maximize and restore window size 
	com! -nargs=0  MaximizeWindow :simalt ~x
	com! -nargs=0  RestoreWindow :simalt ~r 
	# Normal windows use of alt-windows
	nnoremap <silent> <M-space> :simalt ~<cr> 
	
	# Zoom


	# Instead this homemade ctrl-zoom does not working nvim-qt so I t trying vim-scripts/zoom.vim.
	# David Nilsson 2023-01-31
	# function! AdjustFontSize(amount)
		# let s:font_size = s:font_size + a:amount
		# let s:font_string=g:newfont.':h' . s:font_size . g:newfontsetting
		# execute "set guifont=".s:font_string
	# enddef
	
	# nnoremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
	# nnoremap <C-+> :call AdjustFontSize(1)<CR>
	# nnoremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
	# nnoremap <C--> :call AdjustFontSize(-1)<CR>
	# Font setting window
	nnoremap <leader>f :call Initfont()<CR>
	nnoremap <leader>F :set guifont=*<CR>	

endif

# / *ctrl-r* to insert from register in cmd and when saving makros:
# *Search for two empty line
#nnoremap <leader>z :/^\n\{2}<cr>
#
# Convert text to 80 char hard wrap
#set tw=80	 Set default, know if that work thou
#gq {motion}
# First open a preview window, and set it to autoread a file:
#:botr pedit +:setl\  oautoread $temp\~out.log
#
#:!xxxx >$temp\~out.log 2>&1
# RENAME VARIABLE EASY
#* cw NEWNAME <esc> n. n. n.
# search replace 
#select and s/FIND/REPLACE
#s/FIND/REPLACE/g corrent line then .
#%s/FIND/REPLACE/gc whole file with confirmation
# List och for exampel strings 
#vimgrep todo %|fopen
# vim calculator in insert mode press ctrl-r =
# <c-r>= 10+20 print 30
#show ever buffer as a tab
#bufdo tab split
# read input writing over different from r
#.!go run .
#
# The . matches any character, and the ^ specifies start at the beginning 
# of the line. For higher column numbers, there's a helpful shorthand notation 
# using braces #{n}".. For example, to search for the string "abc" 
# starting at column 75:
# 
#  /^.\{74\}abc
# 
#  The braces match the preceding character #n" times. In this case, match the 
#  first n=74 characters, followed by "abc". The braces need to be escaped \{ \}
#  so they won't be included as the search string.
#
#  When replacing a string at a specific column position, you need to save the 
#  pattern up to the search string. The pattern can be saved using parentheses, 
#  which is thereafter referenced as #\1#. So to replace #abc" at column 75 
#  with "xyz", the syntax would be:
#
#  s/\(^.\{74\}\)abc/\1xyz/
#
# Command-line window 
#normal q: command
#normalq/ search
#
# Rediret last command out 
#Redir @"
#normal ""p
#
# Rename av varible in a {} scope 
#viwyvi{ :s/[<c-r>"]retnum/{newname}/g

# # set nocompatible	# NOT NEED default on 
# This option has the effect of making Vim either more Vi-compatible
# , or make Vim behave in a more useful way.

