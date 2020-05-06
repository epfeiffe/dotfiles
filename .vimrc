" First portion of script pulled from https://missing.csail.mit.edu/2020/editors/
" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
" set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Highlight lines longer than 80 characters in red.
" hi OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" Two different ways to highlight misspelled words.
" set spell
" hi SpellBad ctermbg=160

" Set tab length to 4 spaces.
set tabstop=4
set shiftwidth=4
set expandtab

" Highlight search characters.
set hlsearch

" When scrolling, leave 5 lines of buffer.
set scrolloff=5

" Colorschemes
" colorscheme elflord
set background=dark

" ------------
" ---Pugins---
" ------------


" ---Pathogen---
" Package manager for vim plugins such as Syntastic.
" NOTE: For the Pathogen command below to work, you must install
" it with the following commands:
"   mkdir -p ~/.vim/autoload ~/.vim/bundle && \
"   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()


" ---NERDTree---
" NERDTree is a file directory explorer, found here:
" https://github.com/preservim/nerdtree
" NOTE: For the NERDTree commands below to work, you must install
" it with the following commands:
"   git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
"   vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

" Some linux systems need this command to auto open NERDTree
set rtp+=~/.vim/pack/vendor/start/nerdtree

" Auto open NERDTree on start
autocmd vimenter * NERDTree

" Move the cursor to working file on startup
autocmd vimenter * wincmd p

" NOTE: The following command opens NERDTree and moves the cursor in one line
" autocmd vimenter * NERDTree | wincmd p

" Auto close the NERDTree if it is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ---Syntastic---
" Syntastic is a syntax checker, found here:
" https://vimawesome.com/plugin/syntastic
" NOTE: For the Syntastic commands below to work, you must install
" it with the following commands:
"   cd ~/.vim/bundle && \
"   git clone --depth=1 https://github.com/vim-syntastic/syntastic.git 
" Quit vim and start it back up, then type:
"   :Helptags

" Sets statuslines to show in a window at the bottom of the screen
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Always populate and automatically activate local list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" Check file syntax when open but avoid when closed
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Sets python specific checkers
let g:syntastic_python_checkers = ['pylint', 'pep8']
