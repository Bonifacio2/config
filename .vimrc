set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
	let c = get(g:, 'vim_addon_manager', {})
	let g:vim_addon_manager = c
	let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
	" most used options you may want to use:
	" let c.log_to_buf = 1
	" let c.auto_install = 0
	let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
	if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
		execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '
					\       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
	endif
	call vam#ActivateAddons([], {'auto_install' : 0})
endfun

let g:vim_addon_manager = {'scms': {'git': {}}}
fun! MyGitCheckout(repository, targetDir)
	let a:repository.url = substitute(a:repository.url, '^git://github', 'http://github', '')
	return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun
let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']

call SetupVAM()
VAMActivate The_NERD_tree jellybeans vim-addon-commenting vim-autoformat github:sickill/vim-monokai tlib vim-snippets snipmate matchit.zip github:airblade/vim-gitgutter Tagbar fugitive github:editorconfig/editorconfig-vim github:tpope/vim-cucumber github:digitaltoad/vim-jade github:kristijanhusak/vim-multiple-cursors vim-ruby github:ctrlpvim/ctrlp.vim github:geekjuice/vim-spec vim-airline github:digitaltoad/vim-pug github:rakr/vim-two-firewatch github:rakr/vim-one github:lifepillar/vim-solarized8 github:isRuslan/vim-es6 restore_view github:othree/html5-syntax.vim github:othree/html5.vim github:othree/javascript-libraries-syntax.vim github:ternjs/tern_for_vim github:scrooloose/syntastic github:SirVer/ultisnips github:honza/vim-snippets github:leafgarland/typescript-vim github:HerringtonDarkholme/yats.vim github:digitaltoad/vim-pug.git

let g:used_javascript_libs = 'underscore,chai,jquery'


"colorscheme solarized8_dark

"colorscheme two-firewatch
"let g:two_firewatch_italics=1
let g:airline_theme='bubblegum' " if you have Airline installed and want the associated theme
" let g:airline#extensions#tabline#enabled = 1

colorscheme jellybeans
let g:jellybeans_use_term_italics = 1

set background=dark

set viewoptions=cursor,folds,slash,unix 
" let g:skipview_files = ['*\.vim'] 

set backspace=indent,eol,start
set t_ut=
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set paste

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
set runtimepath^=~/.vim/vim-addons/github-ctrlpvim-ctrlp.vim

let mapleader=","
let g:NERDTreeDirArrows=0
let g:multi_cursor_exit_from_insert_mode=0
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v.*(git|hg|svn|node_modules|sass-cache|coverage|dist).*$',
			\ 'file': '\v\.(exe|so|dll|zip|swp|tmp)$',
			\ }
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!bundle exec rspec -I . -f d -c $PWD/{spec}"

let g:mocha_js_command = "!mocha --recursive {spec}"

syntax on
filetype plugin indent on

noremap <F7> :Autoformat<CR><CR>
noremap <F8> :CtrlP<CR><CR>

nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-E> :TagbarToggle<CR>

map <Leader>r :TernRename<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

au FileType jade setl sw=2 sts=2 et
au FileType styl setl sw=2 sts=2 et

" Custom syntastic settings:
" use jshint
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_args = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

" Util Snips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Setup tabbing
map [ :tabp<CR>
map ] :tabn<CR>

