if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)

set bs=indent,eol,start		" allow backspacing over everything in insert mode

if &term=="xterm"
	set t_Co=256
	set t_Sb=[4%dm
	set t_Sf=[3%dm
endif

setlocal indentexpr=GetShIndent()
setlocal indentkeys+==then,=do,=else,=elif,=esac,=fi,=fin,=fil,=done
setlocal indentkeys-=:,0#


if has("syntax")
	syntax on
endif

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
	filetype plugin indent on
endif

set showmatch           " Show matching brackets.

"if filereadable("/etc/vim/vimrc.local")
"       source /etc/vim/vimrc.local
"endif

color ron

if exists("*GetShIndent")
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

function GetShIndent()
	let lnum = prevnonblank(v:lnum - 1)
	if lnum == 0
		return 0
	endif

	" Add a 'shiftwidth' after if, while, else, case, until, for, function()
	" Skip if the line also contains the closure for the above

	let ind = indent(lnum)
	let line = getline(lnum)
	if line =~ '^\s*\(if\|then\|do\|else\|elif\|while\|until\|for\)\>'
				\ || (line =~ '^\s*case\>' && g:sh_indent_case_labels)
				\ || line =~ '^\s*\<\k\+\>\s*()\s*{'
				\ || line =~ '^\s*[^(]\+\s*)'
				\ || line =~ '^\s*{'
		if line !~ '\(esac\|fi\|done\)\>\s*$' && line !~ '}\s*$'
			let ind = ind + &sw
		endif
	endif

	if line =~ ';;'
		let ind = ind - &sw
	endif

	" Subtract a 'shiftwidth' on a then, do, else, esac, fi, done
	" Retain the indentation level if line matches fin (for find)
	let line = getline(v:lnum)
	if (line =~ '^\s*\(then\|do\|else\|elif\|fi\|done\)\>'
				\ || (line =~ '^\s*esac\>' && g:sh_indent_case_labels)
				\ || line =~ '^\s*}'
				\ )
				\ && line !~ '^\s*fi[ln]\>'
		let ind = ind - &sw
	endif

	return ind
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save

color ron
set nowrap
set nopaste
set ignorecase

color ron
:runtime! ftplugin/man.vim
set nobackup                            "не создавать файлы с резервной копией (filename.txt~)"
set history=50                          "сохранять 50 строк в истории командной строки
set ruler                               "постоянно показывать позицию курсора
set incsearch                           "показывать первое совпадение при наборе шаблона
set nohlsearch                          "подсветка найденного
set mouse=a                             "используем мышку
set autoindent                          "включаем умные отступы
set smartindent
set ai                                  "при начале новой строки, отступ копируется из предыдущей
set ignorecase                          "игнорируем регистр символов при поиске
"set background=dark                     "фон терминала - темный
"set ttyfast                             "коннект с терминалом быстрый
set visualbell                          "мигаем вместо пищания
set showmatch                           "показываем открывающие и закрывающие скобки
set shortmess+=tToOI                    "убираем заставку при старте
set rulerformat=%(%l,%c\ %p%%%)         "формат строки состояния строка х столбец, сколько прочитано файла в %
set wrap                                "не разрывать строку при подходе к краю экрана
set linebreak                           "переносы между видимыми на экране строками только между словами
set t_Co=256                            "включаем поддержку 256 цветов
set wildmenu                            "красивое автодополнение
set wcm=<Tab>                           "WTF? but all work
set autowrite                           "автоматом записывать изменения в файл при переходе к другому файлу
set encoding=utf8                       "кодировка по дефолту
set termencoding=utf8                   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r     "Возможные кодировки файлов (автоматическая перекодировка)
set showcmd showmode                    "показывать незавершенные команды и текущий режим
set autochdir                           "текущий каталог всегда совпадает с содержимым активного окна
"set stal=2                              "постоянно выводим строку с табами
"set tpm=100                             "максимальное количество открытых табов
set wak=yes                             "используем ALT как обычно, а не для вызова пункта мени
set noex                                "не читаем файл конфигурации из текущей директории
set ssop+=resize                        "сохраняем в сессии размер окон Vim'а
"set list                                "Отображаем табуляции и конечные пробелы...
set listchars=tab:→→,trail:⋅
