"=============================================================================
" Description: MY vimrc with dozens of scripts, for Linux/Windows, GUI/Console
"              Originally from MetaCosm's http://vi-improved.org/vimrc.php
"
" Last Change: 0 14/05/2006 23:36:39 Leal@RAINT:_vimrc
"
" Author:      Leal <linxiao.li AT gmail DOT com>
"              Get latest vimrc from http://www.leal.cn/
"
" Version:     1.0065
"
" Usage:       1. Prepare necessary dirs and files.
"
"              $VIMDATA         X:\Vim\vimdata on Win, ~/vimdata on Linux
"               |
"               |-- temp        to put swap files <DIR>
"               |-- backup      to put backup files <DIR>
"               |-- diary       to save calendar.vim's diaries <DIR>
"               |-- GetLatest   to save GetLatestVimScripts.vim's <DIR>
"               |      |
"               |      `-- GetLatestVimScripts.dat   to store GLVS's items
"               |
"               |-- _vim_fav_files   to store favmenu.vim's items
"               `-- _vim_mru_files   to store mru.vim's items
"
"              2. Get all scripts you favor on www.vim.org, better with GLVS.
"
"              3. Get all needed utilities, especially on Windows, e.g.
"              wget  -- WGET for Windows  http://users.ugent.be/~bpuype/wget/
"              ctags -- Exuberant Ctags   http://ctags.sf.net/
"
"              4. If have no idea of some option, just press K (<S-k>) on it.
"
"              5. HTML file is produced with :TOhtml, with colo default.
"
"=============================================================================
" one very useful setting for vim
" follow partially according to this:w
" 
"https://github.com/yangyangwithgnu/use_vim_as_ide
"-----------------------------------------------------------------------------
" general
"-----------------------------------------------------------------------------

" 定义快捷键的前缀，即 <Leader>, default is \
"let mapleader=";"

"   SO IMPORTANT!!!!!!!!
"https://github.com/yangyangwithgnu/use_vim_as_ide
"https://github.com/yangyangwithgnu/use_vim_as_ide
"https://github.com/yangyangwithgnu/use_vim_as_ide

"Use vundle!
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'derekwyatt/vim-fswitch'
call vundle#end()            " required
filetype plugin indent on    " required


set nocompatible        " use vim as vim, should be put at the very start
set history=100         " lines of Ex-mode commands, search history
set browsedir=buffer    " use directory of the related buffer for file browser
set clipboard+=unnamed  " use clipboard register '*' for all y, d, c, p ops
set viminfo+=!          " make sure it can save viminfo
set isk+=$,%,#,-,@,_    " none of these should be word dividers
set confirm             " raise a dialog confirm whether save changed buffer
set ffs=unix,dos,mac    " favor unix, which behaves good under Linux/Windows
set fenc=utf-8          " default fileencoding
set fencs=utf-8,ucs-bom,euc-jp,gb18030,gbk,gb2312,cp936
map Q gq
                        " do not use Ex-mode, use Q for formatting
filetype on             " enable file type detection
filetype plugin on      " enable loading the plugin for appropriate file type

" 插件管理
" 将 pathogen 自身也置于独立目录中，需指定其路径
runtime bundle/vim-pathogen/autoload/pathogen.vim
" 运行 pathogen
execute pathogen#infect()

"-----------------------------------------------------------------------------
" colors
"-----------------------------------------------------------------------------
"colorscheme evening
set background=dark     " use a dark background
"colorscheme desert 
colorscheme molokai 
"set background=darkblue     " use a dark background
syntax on               " syntax highlighting

"-----------------------------------------------------------------------------
" gui-only settings
"-----------------------------------------------------------------------------
if has("gui_running")
  set background=dark     " use a dark background
  "colorscheme darkblue 
  colorscheme molokai 
  "colorscheme solarized 

  set guifont=Monospace\ 14
"  colo inkpot           " colorscheme, inkpot.vim
  set lines=35         " window tall and wide, only if gui_running,
  set columns=100       " or vim under console behaves badly
endif

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
"set guioptions-=l
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
" 禁止显示菜单和工具条
"set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
	call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()


"-----------------------------------------------------------------------------
" Vim UI
"-----------------------------------------------------------------------------
set linespace=1         " space it out a little more (easier to read)
set wildmenu            " type :h and press <Tab> to look what happens
set ruler               " always show current position along the bottom
set cursorline
set cursorcolumn
set cmdheight=2         " use 2 screen lines for command-line
set lazyredraw          " do not redraw while executing macros (much faster)
set number              " don't print line number
set hid                 " allow to change buffer without saving
set backspace=2         " make backspace work normal
set whichwrap+=<,>,h,l  " allow backspace and cursor keys to wrap
"set mouse=a             " use mouse in all modes
set shortmess=atI       " shorten messages to avoid 'press a key' prompt
set report=0            " tell us when anything is changed via :...
set fillchars=vert:\ ,stl:\ ,stlnc:\
                        " make the splitters between windows be blank

"-----------------------------------------------------------------------------
" visual cues
"-----------------------------------------------------------------------------
set showmatch           " show matching paren
set matchtime=5         " 1/10 second to show the matching paren
set hlsearch            " do not highlight searched for phrases
set incsearch           " BUT do highlight where the typed pattern matches
set ignorecase           " unsensitive to cap/low while searching
set scrolloff=3         " minimal number of screen lines to keep above/below the cursor
set novisualbell        " use visual bell instead of beeping
set noerrorbells        " do not make noise
set laststatus=2        " always show the status line
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " how :set list show
"set statusline=%{VimBuddy()}\ %F%m%r%h%w\ [%{&ff}]\ [%Y]\ [\%03.3b\ \%02.2B]\ [%02v\ %03l\ %L\ %p%%]
                        " need vimbuddy.vim, dislike it? just remove it

"-----------------------------------------------------------------------------
" text formatting/layout
"-----------------------------------------------------------------------------
set ai                  " autoindent
set si                  " smartindent
set cindent             " do C-style indenting
set fo=tcrqn            " see help (complex)
set tabstop=2           " tab spacing
set softtabstop=2       " unify it
set shiftwidth=2        " unify it
set expandtab         " real tabs please!
set smarttab            " use tabs at the start of a line, spaces elsewhere
set wrap                " do not wrap lines
set formatoptions+=mM   " thus vim can reformat multibyte text (e.g. Chinese)

" When editing a file, always jump to the last known cursor position. 
" Don't do it when the position is invalid or when inside an event handler 
" (happens when dropping a file on gvim). 
autocmd BufReadPost * 
\ if line("'\"") > 0 && line("'\"") <= line("$") | 
\ exe "normal g`\"" | 
\ endif 

"-----------------------------------------------------------------------------
"  plugins
"------------------------------------------------------------------------------
""1. indent guides
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
"switch between cpp and h files
" *.cpp 和 *.h 间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示 *.cpp 或 *.h, use fswitch
nmap <Leader>sch :FSSplitRight<<CR> 
nmap <Leader>vch :FSSplitLeft<CR>
" clang
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>

"" tag bar set up
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <Leader>tl :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" step 4. YouCompleteMe
" YCM 补全菜单配色
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" 补全功能在注释中同样有效
"let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
"let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
"let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
"set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
"inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
"set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
"let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
"let g:ycm_cache_omnifunc=0
" 语法关键字补全         
"let g:ycm_seed_identifiers_with_syntax=1

"-----------------------------------------------------------------------------
" YCM Configuration
"-----------------------------------------------------------------------------


" code navigation
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>

" auto completion
"

highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
"set tags+=/data/misc/software/misc./vim/stdcpp.tags
inoremap <leader>; <C-x><C-o>
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
"-----------------------------------------------------------------------------
" folding
"-----------------------------------------------------------------------------
" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
"set foldenable          " turn on folding
"set foldmethod=indent   " make folding indent sensitive
"set foldlevel=100       " don't autofold anything, but can still fold manually
"set foldopen -=search   " don't open folds when you search into them
"set foldopen -=undo     " don't open folds when you undo stuff

set guifont=Monospace\ 14
"set guifont=Liberation_Mono:h12:cANSI
"set guifont=Arial_monospaced_for_SAP:h9:cANSI

"set tags=/home/tianheng/workspace/rtl_reachability/tags
"set tags=/home/tianheng/workspace/verific_lib_eval/examples/verilog/iterate_parse_tree_with_visitor_class/tags
"set tags=/home/tianheng/workspace/verific_lib_eval/tags
"set tags=/home/tianheng/workspace/virus/tags
"set tags=~/workspace/sis-1.3.6/tags
"set tags=~/workspace/fpga/tags
"set tags=~/Workspace/try/tags
"set tags=~/Workspace/work-fpga/tags
"set tags=~/Workspace/qpr/tags
"set tags=~/Workspace/work-fpga/tags
"set tags=~/Workspace/fpga_new/tags
set tags=/usr/include/c++/4.6.3/tags
set tags+=~/workspace/qpr/tags
set tags+=~/workspace/fpga_new/tags


let g:netrw_winsize=30
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

let g:winManagerWindowLayout="FileExplorer|TagList"
nmap wm :WMToggle<cr>
filetype plugin indent on


let g:alternateSearchPath = 'sfr:../../include/syn,sfr:../../include/ta,sfr:../../include/gui,sfr:../../include/device_model,sfr:../../include/place,sfr:../../include/route,sfr:../../include/tcl,sfr:../../include/util,sfr:../../include/data_model,sfr:../../include/device,sfr:../../include/geometry,sfr:../../include/sat'
