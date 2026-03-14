filetype plugin indent on
:packadd! matchit
syntax enable
if (has("termguicolors"))
    set termguicolors " Use true color in compatible terminals
endif
set number " Show line numbers
set cursorline " Highlight the current line
set hlsearch " Highlight current search
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'MatchParen'

set wildignore+=*/tags

set mouse=a

set nobackup " Disable backup files
set noswapfile " Disable swap files
set autoread " Automatically reload files if changed externally
set background=dark
colorscheme codedark
"
" Ensure this is AFTER colorscheme codedark
let g:airline_theme='solarized'
"let g:airline_solarized_bg='light'

" Fallback: If the theme fails to load, force high contrast colors
if !exists('g:airline_theme')
    let g:airline_theme='dark'
endif

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" High-contrast setting for your GUI (gvimrc context)
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif

set noequalalways

