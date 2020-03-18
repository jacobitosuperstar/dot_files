
"----------------CONFIGURACION UNIVERSAL EN VIM-------------------"

"Tildez 
set encoding=utf-8
set fileencoding=utf-8

"Haciendo que Vim no busque ser compatible con Vi
set nocompatible             
filetype plugin on

"Corte de linea
set wrap linebreak nolist 



"---------cambios en las teclas de navegación-----------------------

"Hacer que la tecla de borrado funcione como en los otros programas
set backspace=indent,eol,start

" Press i to enter insert mode, and ii to exit.
imap ii <Esc>

"-------------------------------------------------------------------


"--------------Cambios en la presentación de VIM--------------

" enable syntax highlighting
syntax enable
syntax on

"Show line numbers
set number "Este saca el numero total
set relativenumber "Este saca el numero relativo

"Set tab and autoindent
set expandtab
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set bg=dark
set ruler
set nohlsearch
color default

"siempre mostrar la línea de status"
set laststatus=2
"-----------------------------------------------------

"----------------Cierre automático de símbolos--------------------

"---paréntesis---------
:inoremap ( ()<Esc>i
"---llaves-----------
:inoremap { {}<Esc>i
"---corchetes--------
:inoremap [ []<Esc>i
"---citaciones-------
:inoremap " ""<Esc>i

"---------------Búsqueda de Archivos------------------

"También da completador de archivos cuando undo la tecla de tabulador
set path+=**

"Mostrar todos los archivos que corresponden con la búsqueda cuando undo tabulador (completar)
set wildmenu

"------------------------------------------------------------------

"--------------Vim netrw (Nerd tree no plugin)----------------------"
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open files in the previous window

"we can use the followin commands to change behaviour
"=0 using the same window
"=1 horizontal split the window
"=2 Vertical split the window
"=3 Open in a new tab
"=4 Open in a previouw window

let g:netrw_winsize=25      " set the width of the director explorer
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"Para que netrw se abra automáticamente con vim"
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" NOW WE CAN:
" - :edit <nombre del folder>
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
"abre los archivos en un panel lateral con v"
"abre los archivos en una nueva pestaña con t
"--------------------------SWAPFILES-------------------------

"Haciendo que los swapfiles se encuentren en un sálo lugar
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
"No swap files
"set noswapfile
"-----------------------------------------------------------


"------Configuraciones Propias para Ciertos Archivos------------

"------Markdown----------

"Para que los diferentes formatos queden como markdown
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown

"Solo para Markdown
autocmd Filetype markdown set syntax=markdown colorcolumn=0

"-------Python----------

"Enable all Python syntax highlighting features
let python_highlight_all = 1

"-----------------------------------------------------

"Configuración de los Plugins con Vundle"

"Comandos simples:
":PluginList
":PluginInstall
":PluginUpdate
":PluginClean!

set nocompatible              " be iMproved, required
""filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Auto complete
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

".......Autocompletador Virtual Enviroment.............."

" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('pipenv --venv')
" The above system() call produces a non zero exit code whenever a proper virtual environment has not been found. So, second, we only point YCM to the virtual environment when the call to 'pipenv --venv' was successful.
"
" Remember, that 'pipenv --venv' only points to the root directory of the virtual environment, so we have to append a full path to the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
else
  let g:ycm_python_binary_path = 'python'
endif
