"""
""" .vimrc - MBlanc, 2013
"""

set nocompatible " be iMproved
filetype off
filetype plugin indent on
syntax on
set nomodeline

"===========
" GENERAL
"===========
set t_Co=256
set background=dark
colorscheme peachpuff
set encoding=utf-8

set autoindent         " Indentacion automatica (misma altura)
"set cindent            " Indentacion a lo C
set visualbell         " Silencioso
set mouse=a            " Activa el raton en todos los modos
set number             " Numeros de linea
set showcmd            " Mostrar comandos parciales
set hlsearch           " Marcar los resultados de busquedas
set incsearch          " Busca mientras escribes
set noexpandtab        " Nunca convertir tabs en espacios
set tabstop=8          " Tamaño de los tabuladores
set softtabstop=8      " Tabular mete mezcla de espacios y tabs
set scrolloff=5        " Distancia minima entre la pantalla y el cursor
set scrolljump=1       " Cuanto salta el cursor cuando se sale de la pantalla
set list listchars=tab:\ \ ,trail:·,extends:#,nbsp:. ",eol:$ " Marca la indentacion con palotes


"===========
" MAPPINGS
"===========
" Arregla el IM INSERT de '^'
" :imi ? :lmap ?
" Repintar pantalla borra los highlights
nnoremap <C-L> :nohl<CR><C-L>
" Comportamiento consistente de 'Y'
nnoremap Y y$
" Cambiar orden de lineas con ctrl+j/k
nnoremap <C-j>      :m .+1<CR>==
nnoremap <C-k>      :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j>      :m '>+1<CR>gv=gv
vnoremap <C-k>      :m '<-2<CR>gv=gv
" Insertar newlines
noremap <CR> o<Esc>
" Cambio de buffer
nnoremap - :bn<CR>
" Pestañas
nnoremap <C-S-tab>      :tabprevious<CR>
nnoremap <C-tab>        :tabnext<CR>
nnoremap <C-t>          :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
