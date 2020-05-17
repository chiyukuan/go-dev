
call plug#begin('~/.config/nvim/bundle')
" golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'majutsushi/tagbar'
Plug 'shougo/neocomplete.vim'
"Dark power of neocomplete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mbbill/undotree'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter'

" denite file, C-g and C-t to move up/down,
" Color scheme
"Plug 'trevordmiller/nova-vim'
Plug 'mhartington/oceanic-next'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'joshdick/onedark.vim'
"Plug 'fatih/molokai'

" Synatx highlight
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'aklt/plantuml-syntax'

" tools
Plug 'vimwiki/vimwiki'
Plug 'SirVer/ultisnips'
" call PlugInstall to install new plugins
call plug#end()

" basics
filetype plugin indent on
syntax on
set number
set relativenumber
set noincsearch
set ignorecase
set smartcase
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set scrolloff=999
set encoding=utf-8
"set nobackup
"set noswapfile
"set nowrap
set mouse-=a
set hlsearch
set foldenable
set foldmethod=marker
set splitbelow
set splitright
set ruler

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" plugin customizations
" neocomplete
let g:neocomplete#enable_at_startup = 1

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" vim-go
" disable open browser after posting snippet
let g:go_play_open_browser = 0
" enable goimports
let g:go_fmt_command = "goimports"
"let g:go_autodetect_gopath = 1
"let g:go_list_type = "quickfix"
" enable additional highlighting
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" vim-airline
set laststatus=2
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'

" tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" shortcuts remap
nmap <F2> :tabnew<CR>
nmap <F3> :tabclose<CR>
nmap <F5> :UndotreeToggle<CR>
nmap <F7> :NERDTreeTabsToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>

" exit from terminal mode
tnoremap <Esc> <C-\><C-n>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " show a list of interfaces which is implemented by the type under your cursor
  autocmd FileType go nmap <Leader>s <Plug>(go-implements)
  " open the relevant Godoc for the word under the cursor
  autocmd FileType go nmap <Leader>gi <Plug>(go-info)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  " run Go commands
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>i <Plug>(go-install)
  " open the definition/declaration in a new vertical, horizontal or tab for the
  " word under your cursor
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  " :GoCoverageToggle
  " :GoMetaLinter
  " rename the identifier under the cursor to a new name
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef but opens in a horizontal split
  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

augroup dockerfile
  au!
  autocmd BufNewFile,BufRead Dockerfile.*   set syntax=dockerfile
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" End of vim-go plugin

" shortcut to open a specified file
nmap <leader>w :e ~/vimwiki/index.wiki<CR>
nmap <leader>v :e ~/.config/nvim/init.vim<CR>
" for log file hide 
nmap <leader>c :syn match Concealed '^... .. ..:..:.. [^ ]* ' conceal cchar=!<CR>:set conceallevel=2<CR>
nmap <leader>C :syn clear Concealed<CR>:set conceallevel=1<CR>

" change spacing for language specific
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype java       setlocal ts=2 sts=2 sw=2

" remember last location
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 

" plugin settings

" deoplete
"let g:deoplete#enable_at_startup = 1
"autocmd FileType c,cpp,objc let g:deoplete#sources#clang#libclang_path = '/usr/lib64/llvm/libclang.so' 

" javacomplete2
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Theme
syntax enable
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
" OceanicNext scheme
if (has("termguicolors"))
 set termguicolors
endif
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
set background=dark
"colorscheme palenight
colorscheme OceanicNext
"colorscheme nova
"colorscheme onedark
autocmd Syntax {cpp,c,idl} runtime syntax/doxygen.vim 

"yaml
autocmd FileType yaml setlocal ai ts=2 sw=2 et

"spell
autocmd FileType markdown setlocal spell

" vimwiki and md
au BufRead,BufNewFile \(*.wiki\|*.md\) setlocal spell spelllang=en_us
let g:vimwiki_list = [{'path': '~/vimwiki', 'path_html': '~/vimwiki/export/html/'}, {'path': '~/md-wiki/', 'syntax': 'markdown', 'ext': '.md'}, {'path': '~/gitwork/', 'syntax': 'markdown', 'ext': '.md'}]

" jsx
let g:jsx_ext_required = 0

" Syntax hilight
function! MySyntax()
    syntax region MyCPoint start="^[ \t]*CPOINT_" end=")\n\|) \\"
    syntax region MySection start="^// Section -" end="-- \?\n"
    syntax region MyGsiCmgrStat start="^[ \t]*GSI_CMGR_STAT_[a-zA-Z0-9_]*(\|^[ \t]*GSI_CMGR_SLCM_[a-zA-Z0-9_]*(" end=";\n"
    syntax match  MyKeyWord "\<forEach"
    syntax match  MyKeyWord "_forEach_"
    syntax match  MyKeyWord "\<walk_"
    syntax match  MyKeyWord "\<safewalk_"
    syntax match  MyKeyWord "_walk_"
    syntax match  MyKeyWord "\<SLCM_CMSG_TYPE_[a-zA-Z0-9_]*"
    syntax match  MyKeyWord "CP-CHG-MPAIR"
    syntax match  MyKeyWord "TRUST"
    syntax match  MyKeyWord "CP-FC-LUN"
    syntax match  MyHi      "-N-DOWN"
    syntax match  MyHi      "CP-RMT-DONW"
    hi link MyCPoint      Comment
    hi link MySection     WildMenu
    hi link MyGsiCmgrStat Macro
    hi link MyKeyWord     Keyword
    hi link MyHi          Keyword
endfunction

autocmd Syntax * call MySyntax()
