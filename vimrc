filetype plugin indent on
:packadd! matchit
syntax enable
if (has("termguicolors"))
    set termguicolors " Use true color in compatible terminals
endif
set number " Show line numbers
set cursorline " Highlight the current line
set hlsearch " Highlight current search
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'MatchParen'

set nobackup " Disable backup files
set noswapfile " Disable swap files
set autoread " Automatically reload files if changed externally
set background=dark
colorscheme codedark

