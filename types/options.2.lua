--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- boolean	(default on)
-- 			global
-- 	When on, a <Tab> in front of a line inserts blanks according to
-- 	'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
-- 	<BS> will delete a 'shiftwidth' worth of space at the start of the
-- 	line.
-- 	When off, a <Tab> always inserts blanks according to 'tabstop' or
-- 	'softtabstop'.  'shiftwidth' is only used for shifting text left or
-- 	right |shift-left-right|.
-- 	What gets inserted (a <Tab> or spaces) depends on the 'expandtab'
-- 	option.  Also see |ins-expandtab|.  When 'expandtab' is not set, the
-- 	number of spaces is minimized by using <Tab>s.
-- 	This option is reset when 'paste' is set and restored when 'paste' is
-- 	reset.
vim.o.smarttab = "true"
-- string (default:
-- 				Vim+Vi	Win32: "dos,unix",
-- 				Vim	Unix: "unix,dos",
-- 				Vi	others: "")
-- 			global
-- 	This gives the end-of-line (<EOL>) formats that will be tried when
-- 	starting to edit a new buffer and when reading a file into an existing
-- 	buffer:
-- 	- When empty, the format defined with 'fileformat' will be used
-- 	  always.  It is not set automatically.
-- 	- When set to one name, that format will be used whenever a new buffer
-- 	  is opened.  'fileformat' is set accordingly for that buffer.  The
-- 	  'fileformats' name will be used when a file is read into an existing
-- 	  buffer, no matter what 'fileformat' for that buffer is set to.
-- 	- When more than one name is present, separated by commas, automatic
-- 	  <EOL> detection will be done when reading a file.  When starting to
-- 	  edit a file, a check is done for the <EOL>:
-- 	  1. If all lines end in <CR><NL>, and 'fileformats' includes "dos",
-- 	     'fileformat' is set to "dos".
-- 	  2. If a <NL> is found and 'fileformats' includes "unix", 'fileformat'
-- 	     is set to "unix".  Note that when a <NL> is found without a
-- 	     preceding <CR>, "unix" is preferred over "dos".
-- 	  3. If 'fileformat' has not yet been set, and if a <CR> is found, and
-- 	     if 'fileformats' includes "mac", 'fileformat' is set to "mac".
-- 	     This means that "mac" is only chosen when:
-- 	      "unix" is not present or no <NL> is found in the file, and
-- 	      "dos" is not present or no <CR><NL> is found in the file.
-- 	     Except: if "unix" was chosen, but there is a <CR> before
-- 	     the first <NL>, and there appear to be more <CR>s than <NL>s in
-- 	     the first few lines, "mac" is used.
-- 	  4. If 'fileformat' is still not set, the first name from
-- 	     'fileformats' is used.
-- 	  When reading a file into an existing buffer, the same is done, but
-- 	  this happens like 'fileformat' has been set appropriately for that
-- 	  file only, the option is not changed.
-- 	When 'binary' is set, the value of 'fileformats' is not used.
vim.o.fileformats = "unix,dos"
-- boolean	(default on for systems where case in file
-- 				 names is normally ignored)
-- 			global
-- 	When set case is ignored when using file names and directories.
-- 	See 'wildignorecase' for only ignoring case when doing completion.
vim.o.fileignorecase = "true"
-- string (default "")
-- 			global
-- 	When set to "all", a fold is closed when the cursor isn't in it and
-- 	its level is higher than 'foldlevel'.  Useful if you want folds to
-- 	automatically close when moving out of them.
vim.o.foldclose = ""
-- string	(default "best")
-- 			global
-- 	Methods used for spelling suggestions.  Both for the |z=| command and
-- 	the |spellsuggest()| function.  This is a comma-separated list of
-- 	items:
vim.o.spellsuggest = "best"
-- string	(default on Unix: ".,/usr/include,,"
-- 				   other systems: ".,,")
-- 			global or local to buffer |global-local|
-- 	This is a list of directories which will be searched when using the
-- 	|gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
-- 	provided that the file being searched for has a relative path (not
-- 	starting with "/", "./" or "../").  The directories in the 'path'
-- 	option may be relative or absolute.
-- 	- Use commas to separate directory names: >
-- 		:set path=.,/usr/local/include,/usr/include
-- <	- Spaces can also be used to separate directory names (for backwards
-- 	  compatibility with version 3.0).  To have a space in a directory
-- 	  name, precede it with an extra backslash, and escape the space: >
-- 		:set path=.,/dir/with\\\ space
-- <	- To include a comma in a directory name precede it with an extra
-- 	  backslash: >
-- 		:set path=.,/dir/with\\,comma
-- <	- To search relative to the directory of the current file, use: >
-- 		:set path=.
-- <	- To search in the current directory use an empty string between two
-- 	  commas: >
-- 		:set path=,,
-- <	- A directory name may end in a ':' or '/'.
-- 	- Environment variables are expanded |:set_env|.
-- 	- When using |netrw.vim| URLs can be used.  For example, adding
-- 	  "http://www.vim.org" will make ":find index.html" work.
-- 	- Search upwards and downwards in a directory tree using "*", "**" and
-- 	  ";".  See |file-searching| for info and syntax.
-- 	- Careful with '\' characters, type two to get one in the option: >
-- 		:set path=.,c:\\include
-- <	  Or just use '/' instead: >
-- 		:set path=.,c:/include
-- <	Don't forget "." or files won't even be found in the same directory as
-- 	the file!
-- 	The maximum length is limited.  How much depends on the system, mostly
-- 	it is something like 256 or 1024 characters.
-- 	You can check if all the include files are found, using the value of
-- 	'path', see |:checkpath|.
-- 	The use of |:set+=| and |:set-=| is preferred when adding or removing
-- 	directories from the list.  This avoids problems when a future version
-- 	uses another default.  To remove the current directory use: >
-- 		:set path-=
-- <	To add the current directory use: >
-- 		:set path+=
-- <	To use an environment variable, you probably need to replace the
-- 	separator.  Here is an example to append $INCL, in which directory
-- 	names are separated with a semi-colon: >
-- 		:let &path = &path . "," . substitute($INCL, ';', ',', 'g')
-- <	Replace the ';' with a ':' or whatever separator is used.  Note that
-- 	this doesn't work when $INCL contains a comma or white space.
vim.o.path = ".,/usr/include,,"
-- boolean	(default off)
-- 			global
-- 	When on, splitting a window will put the new window below the current
-- 	one. |:split|
vim.o.splitbelow = "false"
-- boolean	(default off)
-- 			global
-- 	When on, splitting a window will put the new window right of the
-- 	current one. |:vsplit|
vim.o.splitright = "false"
-- boolean	(default off)
-- 			global
-- 	When "on" the commands listed below move the cursor to the first
-- 	non-blank of the line.  When off the cursor is kept in the same column
-- 	(if possible).  This applies to the commands: CTRL-D, CTRL-U, CTRL-B,
-- 	CTRL-F, "G", "H", "M", "L", gg, and to the commands "d", "<<" and ">>"
-- 	with a linewise operator, with "%" with a count and to buffer changing
-- 	commands (CTRL-^, :bnext, :bNext, etc.).  Also for an Ex command that
-- 	only has a line number, e.g., ":25" or ":+".
-- 	In case of buffer changing commands the cursor is placed at the column
-- 	where it was the last time the buffer was edited.
vim.o.startofline = "false"
-- string	(default empty)
-- 			global or local to window |global-local|
-- 	When nonempty, this option determines the content of the status line.
-- 	Also see |status-line|.
vim.o.statusline = ""
-- number (default: -1)
-- 			global
-- 	Sets 'foldlevel' when starting to edit another buffer in a window.
-- 	Useful to always start editing with all folds closed (value zero),
-- 	some folds closed (one) or no folds closed (99).
-- 	This is done before reading any modeline, thus a setting in a modeline
-- 	overrules this option.  Starting to edit a file for |diff-mode| also
-- 	ignores this option and closes all folds.
-- 	It is also done before BufReadPre autocommands, to allow an autocmd to
-- 	overrule the 'foldlevel' value for specific files.
-- 	When the value is negative, it is not used.
vim.o.foldlevelstart = "-1"
-- string	(default ".bak,~,.o,.h,.info,.swp,.obj")
-- 			global
-- 	Files with these suffixes get a lower priority when multiple files
-- 	match a wildcard.  See |suffixes|.  Commas can be used to separate the
-- 	suffixes.  Spaces after the comma are ignored.  A dot is also seen as
-- 	the start of a suffix.  To avoid a dot or comma being recognized as a
-- 	separator, precede it with a backslash (see |option-backslash| about
-- 	including spaces and backslashes).
-- 	See 'wildignore' for completely ignoring files.
-- 	The use of |:set+=| and |:set-=| is preferred when adding or removing
-- 	suffixes from the list.  This avoids problems when a future version
-- 	uses another default.
vim.o.suffixes = ".bak,~,.o,.h,.info,.swp,.obj"
-- string	(default "")
-- 			global
-- 	This option controls the behavior when switching between buffers.
-- 	Possible values (comma separated list):
-- 	   useopen	If included, jump to the first open window that
-- 			contains the specified buffer (if there is one).
-- 			Otherwise: Do not examine other windows.
-- 			This setting is checked with |quickfix| commands, when
-- 			jumping to errors (":cc", ":cn", "cp", etc.).  It is
-- 			also used in all buffer related split commands, for
-- 			example ":sbuffer", ":sbnext", or ":sbrewind".
-- 	   usetab	Like "useopen", but also consider windows in other tab
-- 			pages.
-- 	   split	If included, split the current window before loading
-- 			a buffer for a |quickfix| command that display errors.
-- 			Otherwise: do not split, use current window (when used
-- 			in the quickfix window: the previously used window or
-- 			split if there is no other window).
-- 	   vsplit	Just like "split" but split vertically.
-- 	   newtab	Like "split", but open a new tab page.  Overrules
-- 			"split" when both are present.
-- 	   uselast	If included, jump to the previously used window when
-- 			jumping to errors with |quickfix| commands.
vim.o.switchbuf = "uselast"
-- string (default: "block,hor,mark,percent,quickfix,
-- 							     search,tag,undo")
-- 			global
-- 	Specifies for which type of commands folds will be opened, if the
-- 	command moves the cursor into a closed fold.  It is a comma separated
-- 	list of items.
-- 	NOTE: When the command is part of a mapping this option is not used.
-- 	Add the |zv| command to the mapping to get the same effect.
-- 	(rationale: the mapping may want to control opening folds itself)
vim.o.foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"
-- string	(default empty)
-- 			global
-- 	When nonempty, this option determines the content of the tab pages
-- 	line at the top of the Vim window.  When empty Vim will use a default
-- 	tab pages line.  See |setting-tabline| for more info.
vim.o.tabline = ""
-- number	(default 50)
-- 			global
-- 	Maximum number of tab pages to be opened by the |-p| command line
-- 	argument or the ":tab all" command. |tabpage|
vim.o.tabpagemax = "50"
-- boolean	(default on)
-- 			global
-- 	When searching for a tag (e.g., for the |:ta| command), Vim can either
-- 	use a binary search or a linear search in a tags file.  Binary
-- 	searching makes searching for a tag a LOT faster, but a linear search
-- 	will find more tags if the tags file wasn't properly sorted.
-- 	Vim normally assumes that your tags files are sorted, or indicate that
-- 	they are not sorted.  Only when this is not the case does the
-- 	'tagbsearch' option need to be switched off.
vim.o.tagbsearch = "true"
-- string	(default "followic")
-- 			global or local to buffer |global-local|
-- 	This option specifies how case is handled when searching the tags
-- 	file:
-- 	   followic	Follow the 'ignorecase' option
-- 	   followscs    Follow the 'smartcase' and 'ignorecase' options
-- 	   ignore	Ignore case
-- 	   match	Match case
-- 	   smart	Ignore case unless an upper case letter is used
vim.o.tagcase = "followic"
-- string (default "")
-- 			global or local to buffer |global-local|
-- 	The name of an external program that will be used to format the lines
-- 	selected with the |gq| operator.  The program must take the input on
-- 	stdin and produce the output on stdout.  The Unix program "fmt" is
-- 	such a program.
-- 	If the 'formatexpr' option is not empty it will be used instead.
-- 	Otherwise, if 'formatprg' option is an empty string, the internal
-- 	format function will be used |C-indenting|.
-- 	Environment variables are expanded |:set_env|.  See |option-backslash|
-- 	about including spaces and backslashes.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.formatprg = ""
-- boolean (default off, set in |defaults.vim|)
-- 			global
-- 			{only available when compiled with the |+langmap|
-- 			feature}
-- 	This is just like 'langremap' but with the value inverted.  It only
-- 	exists for backwards compatibility.  When setting 'langremap' then
-- 	'langnoremap' is set to the inverted value, and the other way around.
vim.o.langnoremap = "true"
-- boolean	(default off)
-- 			global
-- 	When on, the OS function fsync() will be called after saving a file
-- 	(|:write|, |writefile()|, …), |swap-file| and |shada-file|. This
-- 	flushes the file to disk, ensuring that it is safely written.
-- 	Slow on some systems: writing buffers, quitting Nvim, and other
-- 	operations may sometimes take a few seconds.
vim.o.fsync = "false"
-- boolean (default off)
-- 			global
-- 	When off, setting 'langmap' does not apply to characters resulting from
-- 	a mapping.  If setting 'langmap' disables some of your mappings, make
-- 	sure this option is off.
vim.o.langremap = "false"
-- boolean	(default off)
-- 			global
-- 	When on, the ":substitute" flag 'g' is default on.  This means that
-- 	all matches in a line are substituted instead of one.  When a 'g' flag
-- 	is given to a ":substitute" command, this will toggle the substitution
-- 	of all or one match.  See |complex-change|.
vim.o.gdefault = "false"
-- number	(default 2)
-- 			global
-- 	The value of this option influences when the last window will have a
-- 	status line:
-- 		0: never
-- 		1: only if there are at least two windows
-- 		2: always
-- 	The screen looks nicer with a status line if you have several
-- 	windows, but it takes another screen line. |status-line|
vim.o.laststatus = "2"
-- string	(default "%f:%l:%m,%f:%l%m,%f  %l%m")
-- 			global
-- 	Format to recognize for the ":grep" command output.
-- 	This is a scanf-like string that uses the same format as the
-- 	'errorformat' option: see |errorformat|.
vim.o.grepformat = "%f:%l:%m,%f:%l%m,%f  %l%m"
-- boolean	(default off)
-- 			global
-- 	When this option is set, the screen will not be redrawn while
-- 	executing macros, registers and other commands that have not been
-- 	typed.  Also, updating the window title is postponed.  To force an
-- 	update use |:redraw|.
vim.o.lazyredraw = "false"
-- string	(default "grep -n ",
-- 				 Unix: "grep -n $* /dev/null")
-- 			global or local to buffer |global-local|
-- 	Program to use for the |:grep| command.  This option may contain '%'
-- 	and '#' characters, which are expanded like when used in a command-
-- 	line.  The placeholder "$*" is allowed to specify where the arguments
-- 	will be included.  Environment variables are expanded |:set_env|.  See
-- 	|option-backslash| about including spaces and backslashes.
-- 	When your "grep" accepts the "-H" argument, use this to make ":grep"
-- 	also work well with a single file: >
-- 		:set grepprg=grep\ -nH
-- <	Special value: When 'grepprg' is set to "internal" the |:grep| command
-- 	works like |:vimgrep|, |:lgrep| like |:lvimgrep|, |:grepadd| like
-- 	|:vimgrepadd| and |:lgrepadd| like |:lvimgrepadd|.
-- 	See also the section |:make_makeprg|, since most of the comments there
-- 	apply equally to 'grepprg'.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.grepprg = "grep -n $* /dev/null"
-- number	(default 0)
-- 			global
-- 			{only in the GUI}
-- 	Number of pixel lines inserted between characters.  Useful if the font
-- 	uses the full character cell height, making lines touch each other.
-- 	When non-zero there is room for underlining.
-- 	With some fonts there can be too much room between lines (to have
-- 	space for ascents and descents).  Then it makes sense to set
-- 	'linespace' to a negative value.  This may cause display problems
-- 	though!
vim.o.linespace = "0"
-- string	(default "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")
-- 			global
-- 	Configures the cursor style for each mode. Works in the GUI and many
-- 	terminals.  See |tui-cursor-shape|.
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- string	(default is very long)
-- 			global or local to buffer |global-local|
-- 	Comma separated list of words that influence the Lisp indenting.
-- 	|'lisp'|
vim.o.lispwords = "defun,define,defmacro,set!,lambda,if,case,let,flet,let*,letrec,do,do*,define-syntax,let-syntax,letrec-syntax,destructuring-bind,defpackage,defparameter,defstruct,deftype,defvar,do-all-symbols,do-external-symbols,do-symbols,dolist,dotimes,ecase,etypecase,eval-when,labels,macrolet,multiple-value-bind,multiple-value-call,multiple-value-prog1,multiple-value-setq,prog1,progv,typecase,unless,unwind-protect,when,with-input-from-string,with-open-file,with-open-stream,with-output-to-string,with-package-iterator,define-condition,handler-bind,handler-case,restart-bind,restart-case,with-simple-restart,store-value,use-value,muffle-warning,abort,continue,with-slots,with-slots*,with-accessors,with-accessors*,defclass,defmethod,print-unreadable-object"
-- string	(default "")
-- 			global
-- 	This is a list of fonts which will be used for the GUI version of Vim.
-- 	In its simplest form the value is just one font name.  When
-- 	the font cannot be found you will get an error message.  To try other
-- 	font names a list can be specified, font names separated with commas.
-- 	The first valid font is used.
vim.o.guifont = ""
-- string	(default "")
-- 			global
-- 	When not empty, specifies a comma-separated list of fonts to be used
-- 	for double-width characters.  The first font that can be loaded is
-- 	used.
-- 	Note: The size of these fonts must be exactly twice as wide as the one
-- 	specified with 'guifont' and the same height.
vim.o.guifontwide = ""
-- string	(default "egmrLT"   (MS-Windows))
-- 			global
-- 	This option only has an effect in the GUI version of Vim.  It is a
-- 	sequence of letters which describes what components and options of the
-- 	GUI should be used.
-- 	To avoid problems with flags that are added in the future, use the
-- 	"+=" and "-=" feature of ":set" |add-option-flags|.
vim.o.guioptions = ""
-- string	(default empty)
-- 			global
-- 	When nonempty describes the text to use in a label of the GUI tab
-- 	pages line.  When empty and when the result is empty Vim will use a
-- 	default label.  See |setting-guitablabel| for more info.
vim.o.guitablabel = ""
-- boolean	(default on)
-- 			global
-- 	Changes the special characters that can be used in search patterns.
-- 	See |pattern|.
-- 	WARNING: Switching this option off most likely breaks plugins!  That
-- 	is because many patterns assume it's on and will fail when it's off.
-- 	Only switch it off when working with old Vi scripts.  In any other
-- 	situation write patterns that work when 'magic' is on.  Include "\M"
-- 	when you want to |/\M|.
vim.o.magic = "true"
-- string	(default: "")
-- 			global
-- 	Name of the errorfile for the |:make| command (see |:make_makeprg|)
-- 	and the |:grep| command.
-- 	When it is empty, an internally generated temp file will be used.
-- 	When "##" is included, it is replaced by a number to make the name
-- 	unique.  This makes sure that the ":make" command doesn't overwrite an
-- 	existing file.
-- 	NOT used for the ":cf" command.  See 'errorfile' for that.
-- 	Environment variables are expanded |:set_env|.
-- 	See |option-backslash| about including spaces and backslashes.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.makeef = ""
-- string	(default "")
-- 			global or local to buffer |global-local|
-- 	List of file names, separated by commas, that are used to lookup words
-- 	for thesaurus completion commands |i_CTRL-X_CTRL-T|.
vim.o.thesaurus = ""
-- string	(default (MSDOS)  "$VIMRUNTIME\doc\help.txt"
-- 					 (others) "$VIMRUNTIME/doc/help.txt")
-- 			global
-- 	Name of the main help file.  All distributed help files should be
-- 	placed together in one directory.  Additionally, all "doc" directories
-- 	in 'runtimepath' will be used.
-- 	Environment variables are expanded |:set_env|.  For example:
-- 	"$VIMRUNTIME/doc/help.txt".  If $VIMRUNTIME is not set, $VIM is also
-- 	tried.  Also see |$VIMRUNTIME| and |option-backslash| about including
-- 	spaces and backslashes.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.helpfile = "/usr/local/Cellar/neovim/HEAD-0344736/share/nvim/runtime/doc/help.txt"
vim.o.thesaurusfunc = ""
-- string	(default "make")
-- 			global or local to buffer |global-local|
-- 	Program to use for the ":make" command.  See |:make_makeprg|.
-- 	This option may contain '%' and '#' characters (see  |:_%| and |:_#|),
-- 	which are expanded to the current and alternate file name.  Use |::S|
-- 	to escape file names in case they contain special characters.
-- 	Environment variables are expanded |:set_env|.  See |option-backslash|
-- 	about including spaces and backslashes.
-- 	Note that a '|' must be escaped twice: once for ":set" and once for
-- 	the interpretation of a command.  When you use a filter called
-- 	"myfilter" do it like this: >
-- 	    :set makeprg=gmake\ \\\|\ myfilter
-- <	The placeholder "$*" can be given (even multiple times) to specify
-- 	where the arguments will be included, for example: >
-- 	    :set makeprg=latex\ \\\\nonstopmode\ \\\\input\\{$*}
-- <	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.makeprg = "make"
-- number	(default 20)
-- 			global
-- 	Minimal initial height of the help window when it is opened with the
-- 	":help" command.  The initial height of the help window is half of the
-- 	current window, or (when the 'ea' option is on) the same as other
-- 	windows.  When the height is less than 'helpheight', the height is
-- 	set to 'helpheight'.  Set to zero to disable.
vim.o.helpheight = "20"
-- string	(default: messages language or empty)
-- 			global
-- 	Comma separated list of languages.  Vim will use the first language
-- 	for which the desired help can be found.  The English help will always
-- 	be used as a last resort.  You can add "en" to prefer English over
-- 	another language, but that will only find tags that exist in that
-- 	language and not in the English help.
-- 	Example: >
-- 		:set helplang=de,it
-- <	This will first search German, then Italian and finally English help
-- 	files.
-- 	When using |CTRL-]| and ":help!" in a non-English help file Vim will
-- 	try to find the tag in the current language before using this option.
-- 	See |help-translated|.
vim.o.helplang = ""
-- boolean	(default off)
-- 			global
-- 	When off a buffer is unloaded when it is |abandon|ed.  When on a
-- 	buffer becomes hidden when it is |abandon|ed.  If the buffer is still
-- 	displayed in another window, it does not become hidden, of course.
-- 	The commands that move through the buffer list sometimes make a buffer
-- 	hidden although the 'hidden' option is off: When the buffer is
-- 	modified, 'autowrite' is off or writing is not possible, and the '!'
-- 	flag was used.  See also |windows.txt|.
-- 	To only make one buffer hidden use the 'bufhidden' option.
-- 	This option is set for one command with ":hide {command}" |:hide|.
-- 	WARNING: It's easy to forget that you have changes in hidden buffers.
-- 	Think twice when using ":q!" or ":qa!".
vim.o.hidden = "true"
-- number	(default 5)
-- 			global
-- 	Tenths of a second to show the matching paren, when 'showmatch' is
-- 	set.  Note that this is not in milliseconds, like other options that
-- 	set a time.  This is to be compatible with Nvi.
vim.o.matchtime = "5"
-- Removed. |vim-differences|
-- 	Nvim always displays up to 6 combining characters.  You can still edit
--     text with more than 6 combining characters, you just can't see them.
--     Use |g8| or |ga|.  See |mbyte-combining|.
vim.o.maxcombine = "6"
-- number	(Vim default: 10000, Vi default: 0)
-- 			global
-- 	A history of ":" commands, and a history of previous search patterns
-- 	is remembered.  This option decides how many entries may be stored in
-- 	each of these histories (see |cmdline-editing|).
-- 	The maximum value is 10000.
vim.o.history = "10000"
-- number	(default 100)
-- 			global
-- 	Maximum depth of function calls for user functions.  This normally
-- 	catches endless recursion.  When using a recursive function with
-- 	more depth, set 'maxfuncdepth' to a bigger number.  But this will use
-- 	more memory, there is the danger of failing when memory is exhausted.
-- 	Increasing this limit above 200 also changes the maximum for Ex
-- 	command recursion, see |E169|.
-- 	See also |:function|.
vim.o.maxfuncdepth = "100"
-- boolean (default off)
-- 			global
-- 	When on, the keyboard is mapped for the Hebrew character set.
-- 	Normally you would set 'allowrevins' and use CTRL-_ in insert mode to
-- 	toggle this option.  See |rileft.txt|.
vim.o.hkmap = "false"
-- number	(default 1000)
-- 			global
-- 	Maximum number of times a mapping is done without resulting in a
-- 	character to be used.  This normally catches endless mappings, like
-- 	":map x y" with ":map y x".  It still does not catch ":map g wg",
-- 	because the 'w' is used before the next mapping is done.  See also
-- 	|key-mapping|.
vim.o.maxmapdepth = "1000"
-- boolean (default off)
-- 			global
-- 	When on, phonetic keyboard mapping is used.  'hkmap' must also be on.
-- 	This is useful if you have a non-Hebrew keyboard.
-- 	See |rileft.txt|.
vim.o.hkmapp = "false"
-- number	(default 1000)
-- 			global
-- 	Maximum amount of memory (in Kbyte) to use for pattern matching.
-- 	The maximum value is about 2000000.  Use this to work without a limit.
-- 							*E363*
-- 	When Vim runs into the limit it gives an error message and mostly
-- 	behaves like CTRL-C was typed.
-- 	Running into the limit often means that the pattern is very
-- 	inefficient or too complex.  This may already happen with the pattern
-- 	"\(.\)*" on a very long line.  ".*" works much better.
-- 	Might also happen on redraw, when syntax rules try to match a complex
-- 	text structure.
-- 	Vim may run out of memory before hitting the 'maxmempattern' limit, in
-- 	which case you get an "Out of memory" error instead.
vim.o.maxmempattern = "1000"
-- boolean	(default on)
-- 			global
-- 	When there is a previous search pattern, highlight all its matches.
-- 	The |hl-Search| highlight group determines the highlighting. Note that
-- 	only the matching text is highlighted, any offsets are not applied.
-- 	See also: 'incsearch' and |:match|.
-- 	When you get bored looking at the highlighted matches, you can turn it
-- 	off with |:nohlsearch|.  This does not change the option value, as
-- 	soon as you use a search command, the highlighting comes back.
-- 	'redrawtime' specifies the maximum time spent on finding matches.
-- 	When the search pattern can match an end-of-line, Vim will try to
-- 	highlight all of the matched text.  However, this depends on where the
-- 	search starts.  This will be the first line in the window or the first
-- 	line below a closed fold.  A match in a previous line which is not
-- 	drawn may not continue in a newly drawn line.
-- 	You can specify whether the highlight status is restored on startup
-- 	with the 'h' flag in 'shada' |shada-h|.
vim.o.hlsearch = "true"
-- number	(default 25)
-- 			global
-- 	Maximum number of items to use in a menu.  Used for menus that are
-- 	generated from a list of items, e.g., the Buffers menu.  Changing this
-- 	option has no direct effect, the menu must be refreshed first.
vim.o.menuitems = "25"
-- boolean	(default off, on when title can be restored)
-- 			global
-- 	When on, the icon text of the window will be set to the value of
-- 	'iconstring' (if it is not empty), or to the name of the file
-- 	currently being edited.  Only the last part of the name is used.
-- 	Overridden by the 'iconstring' option.
-- 	Only works if the terminal supports setting window icons.
vim.o.icon = "false"
-- string	(default "460000,2000,500")
-- 			global
-- 	Parameters for |:mkspell|.  This tunes when to start compressing the
-- 	word tree.  Compression can be slow when there are many words, but
-- 	it's needed to avoid running out of memory.  The amount of memory used
-- 	per word depends very much on how similar the words are, that's why
-- 	this tuning is complicated.
vim.o.mkspellmem = "460000,2000,500"
-- boolean	(default off)
-- 			global
-- 	Ignore case in search patterns.  Also used when searching in the tags
-- 	file.
-- 	Also see 'smartcase' and 'tagcase'.
-- 	Can be overruled by using "\c" or "\C" in the pattern, see
-- 	|/ignorecase|.
vim.o.ignorecase = "false"
-- boolean (default off)
-- 			global
-- 	When set the Input Method is always on when starting to edit a command
-- 	line, unless entering a search pattern (see 'imsearch' for that).
-- 	Setting this option is useful when your input method allows entering
-- 	English characters directly, e.g., when it's used to type accented
-- 	characters with dead keys.
vim.o.imcmdline = "false"
-- boolean (default: off)
-- 			global
-- 	When on allow some options that are an expression to be set in the
-- 	modeline.  Check the option for whether it is affected by
-- 	'modelineexpr'.  Also see |modeline|.
vim.o.modelineexpr = "false"
-- number	(default 5)
-- 			global
-- 	If 'modeline' is on 'modelines' gives the number of lines that is
-- 	checked for set commands.  If 'modeline' is off or 'modelines' is zero
-- 	no lines are checked.  See |modeline|.
vim.o.modelines = "5"
-- string	(default "")
-- 			global
vim.o.inccommand = "nosplit"
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	When on, listings pause when the whole screen is filled.  You will get
-- 	the |more-prompt|.  When this option is off there are no pauses, the
-- 	listing continues until finished.
vim.o.more = "true"
-- string	(default "^\s*#\s*include")
-- 			global or local to buffer |global-local|
-- 	Pattern to be used to find an include command.  It is a search
-- 	pattern, just like for the "/" command (See |pattern|).  The default
-- 	value is for C programs.  This option is used for the commands "[i",
-- 	"]I", "[d", etc.
-- 	Normally the 'isfname' option is used to recognize the file name that
-- 	comes after the matched pattern.  But if "\zs" appears in the pattern
-- 	then the text matched from "\zs" to the end, or until "\ze" if it
-- 	appears, is used as the file name.  Use this to include characters
-- 	that are not in 'isfname', such as a space.  You can then use
-- 	'includeexpr' to process the matched text.
-- 	See |option-backslash| about including spaces and backslashes.
vim.o.include = "^\\s*#\\s*include"
-- boolean	(default off)
-- 			global
-- 			{only works in the GUI}
-- 	The window that the mouse pointer is on is automatically activated.
-- 	When changing the window layout or window focus in another way, the
-- 	mouse pointer is moved to the window with keyboard focus.  Off is the
-- 	default because it makes using the pull down menus a little goofy, as
-- 	a pointer transit may activate a window unintentionally.
vim.o.mousefocus = "false"
-- boolean	(default on)
-- 			global
-- 	While typing a search command, show where the pattern, as it was typed
-- 	so far, matches.  The matched string is highlighted.  If the pattern
-- 	is invalid or not found, nothing is shown.  The screen will be updated
-- 	often, this is only useful on fast terminals.
-- 	Note that the match will be shown, but the cursor will return to its
-- 	original position when no match is found and when pressing <Esc>.  You
-- 	still need to finish the search command with <Enter> to move the
-- 	cursor to the match.
-- 	You can use the CTRL-G and CTRL-T keys to move to the next and
-- 	previous match. |c_CTRL-G| |c_CTRL-T|
-- 	Vim only searches for about half a second.  With a complicated
-- 	pattern and/or a lot of text the match may not be found.  This is to
-- 	avoid that Vim hangs while you are typing the pattern.
-- 	The |hl-IncSearch| highlight group determines the highlighting.
-- 	When 'hlsearch' is on, all matched strings are highlighted too while
-- 	typing a search command. See also: 'hlsearch'.
-- 	If you don't want to turn 'hlsearch' on, but want to highlight all
-- 	matches while searching, you can turn on and off 'hlsearch' with
-- 	autocmd.  Example: >
-- 		augroup vimrc-incsearch-highlight
-- 		  autocmd!
-- 		  autocmd CmdlineEnter /,\? :set hlsearch
-- 		  autocmd CmdlineLeave /,\? :set nohlsearch
-- 		augroup END
-- <
-- 	CTRL-L can be used to add one character from after the current match
-- 	to the command line.  If 'ignorecase' and 'smartcase' are set and the
-- 	command line has no uppercase characters, the added character is
-- 	converted to lowercase.
-- 	CTRL-R CTRL-W can be used to add the word at the end of the current
-- 	match, excluding the characters that were already typed.
vim.o.incsearch = "true"
-- boolean	(default on)
-- 			global
-- 			{only works in the GUI}
-- 	When on, the mouse pointer is hidden when characters are typed.
-- 	The mouse pointer is restored when the mouse is moved.
vim.o.mousehide = "true"
-- string	(default "extend")
-- 			global
-- 	Sets the model to use for the mouse.  The name mostly specifies what
-- 	the right mouse button is used for:
-- 	   extend	Right mouse button extends a selection.  This works
-- 			like in an xterm.
-- 	   popup	Right mouse button pops up a menu.  The shifted left
-- 			mouse button extends a selection.  This works like
-- 			with Microsoft Windows.
-- 	   popup_setpos Like "popup", but the cursor will be moved to the
-- 			position where the mouse was clicked, and thus the
-- 			selected operation will act upon the clicked object.
-- 			If clicking inside a selection, that selection will
-- 			be acted upon, i.e. no cursor move.  This implies of
-- 			course, that right clicking outside a selection will
-- 			end Visual mode.
-- 	Overview of what button does what for each model:
-- 	mouse		    extend		popup(_setpos) ~
-- 	left click	    place cursor	place cursor
-- 	left drag	    start selection	start selection
-- 	shift-left	    search word		extend selection
-- 	right click	    extend selection	popup menu (place cursor)
-- 	right drag	    extend selection	-
-- 	middle click	    paste		paste
vim.o.mousemodel = "extend"
-- string	(default "i:beam,r:beam,s:updown,sd:cross,
-- 					m:no,ml:up-arrow,v:rightup-arrow")
-- 			global
-- 	This option tells Vim what the mouse pointer should look like in
-- 	different modes.  The option is a comma separated list of parts, much
-- 	like used for 'guicursor'.  Each part consist of a mode/location-list
-- 	and an argument-list:
-- 		mode-list:shape,mode-list:shape,..
-- 	The mode-list is a dash separated list of these modes/locations:
-- 			In a normal window: ~
-- 		n	Normal mode
-- 		v	Visual mode
-- 		ve	Visual mode with 'selection' "exclusive" (same as 'v',
-- 			if not specified)
-- 		o	Operator-pending mode
-- 		i	Insert mode
-- 		r	Replace mode
vim.o.mouseshape = ""
-- number	(default 500)
-- 			global
-- 	Defines the maximum time in msec between two mouse clicks for the
-- 	second click to be recognized as a multi click.
vim.o.mousetime = "500"
-- string	(default for Windows:
-- 			     "@,48-57,/,\,.,-,_,+,,,#,$,%,{,},[,],:,@-@,!,~,="
-- 			    otherwise: "@,48-57,/,.,-,_,+,,,#,$,%,~,=")
-- 			global
-- 	The characters specified by this option are included in file names and
-- 	path names.  Filenames are used for commands like "gf", "[i" and in
-- 	the tags file.  It is also used for "\f" in a |pattern|.
-- 	Multi-byte characters 256 and above are always included, only the
-- 	characters up to 255 are specified with this option.
-- 	For UTF-8 the characters 0xa0 to 0xff are included as well.
-- 	Think twice before adding white space to this option.  Although a
-- 	space may appear inside a file name, the effect will be that Vim
-- 	doesn't know where a file name starts or ends when doing completion.
-- 	It most likely works better without a space in 'isfname'.
vim.o.isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,="
-- number	(default 24 or terminal height)
-- 			global
-- 	Number of lines of the Vim window.
-- 	Normally you don't need to set this.  It is done automatically by the
-- 	terminal initialization code.
-- 	When Vim is running in the GUI or in a resizable window, setting this
-- 	option will cause the window size to be changed.  When you only want
-- 	to use the size for the GUI, put the command in your |gvimrc| file.
-- 	Vim limits the number of lines to what fits on the screen.  You can
-- 	use this command to get the tallest window possible: >
-- 		:set lines=999
-- <	Minimum value is 2, maximum value is 1000.
vim.o.lines = "24"
-- string	(default for Windows:
-- 					   "@,48-57,_,128-167,224-235"
-- 				otherwise: "@,48-57,_,192-255")
-- 			global
-- 	The characters given by this option are included in identifiers.
-- 	Identifiers are used in recognizing environment variables and after a
-- 	match of the 'define' option.  It is also used for "\i" in a
-- 	|pattern|.  See 'isfname' for a description of the format of this
-- 	option.  For '@' only characters up to 255 are used.
-- 	Careful: If you change this option, it might break expanding
-- 	environment variables.  E.g., when '/' is included and Vim tries to
-- 	expand "$HOME/.local/share/nvim/shada/main.shada".  Maybe you should
-- 	change 'iskeyword' instead.
vim.o.isident = "@,48-57,_,192-255"
-- boolean	(default off)
-- 			global
-- 			{only for Windows}
-- 	Enable reading and writing from devices.  This may get Vim stuck on a
-- 	device that can be opened but doesn't actually do the I/O.  Therefore
-- 	it is off by default.
-- 	Note that on Windows editing "aux.h", "lpt1.txt" and the like also
-- 	result in editing a device.
vim.o.opendevice = "false"
-- string	(default: empty)
-- 			global
-- 	This option specifies a function to be called by the |g@| operator.
-- 	See |:map-operator| for more info and an example.
vim.o.operatorfunc = ""
-- boolean	(default on)
-- 			global
-- 	Insert two spaces after a '.', '?' and '!' with a join command.
-- 	Otherwise only one space is inserted.
vim.o.joinspaces = "false"
-- string	(default: see 'runtimepath')
-- 	Directories used to find packages.  See |packages|.
vim.o.packpath = "/Users/andri/.config/nvim,/etc/xdg/nvim,/Users/andri/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/HEAD-0344736/share/nvim/runtime,/usr/local/Cellar/neovim/HEAD-0344736/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/andri/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/andri/.config/nvim/after"
-- string	(default "")
-- 			global
-- 	List of words that change the behavior of the |jumplist|.
-- 	  stack         Make the jumplist behave like the tagstack or like a
-- 	                web browser.  Relative location of entries in the
-- 			jumplist is preserved at the cost of discarding
-- 			subsequent entries when navigating backwards in the
-- 			jumplist and then jumping to a location.
-- 			|jumplist-stack|
vim.o.jumpoptions = ""
-- string	(default "IPLPPPQPP TPHPLIPpLpItpplpipbp")
-- 			global
-- 	Specifies the nroff macros that separate paragraphs.  These are pairs
-- 	of two letters (see |object-motions|).
vim.o.paragraphs = "IPLPPPQPP TPHPLIPpLpItpplpipbp"
-- string	(default "")
-- 			global
-- 	List of comma separated words, which enable special things that keys
-- 	can do.  These values can be used:
-- 	   startsel	Using a shifted special key starts selection (either
-- 			Select mode or Visual mode, depending on "key" being
-- 			present in 'selectmode').
-- 	   stopsel	Using a not-shifted special key stops selection.
-- 	Special keys in this context are the cursor keys, <End>, <Home>,
-- 	<PageUp> and <PageDown>.
-- 	The 'keymodel' option is set by the |:behave| command.
vim.o.keymodel = ""
-- string	(default "")
-- 			global
-- 	When non-empty, specifies the key sequence that toggles the 'paste'
-- 	option.  This is like specifying a mapping: >
-- 	    :map {keys} :set invpaste<CR>
-- <	Where {keys} is the value of 'pastetoggle'.
-- 	The difference is that it will work even when 'paste' is set.
-- 	'pastetoggle' works in Insert mode and Normal mode, but not in
-- 	Command-line mode.
-- 	Mappings are checked first, thus overrule 'pastetoggle'.  However,
-- 	when 'paste' is on mappings are ignored in Insert mode, thus you can do
-- 	this: >
-- 	    :map <F10> :set paste<CR>
-- 	    :map <F11> :set nopaste<CR>
-- 	    :imap <F10> <C-O>:set paste<CR>
-- 	    :imap <F11> <nop>
-- 	    :set pastetoggle=<F11>
-- <	This will make <F10> start paste mode and <F11> stop paste mode.
-- 	Note that typing <F10> in paste mode inserts "<F10>", since in paste
-- 	mode everything is inserted literally, except the 'pastetoggle' key
-- 	sequence.
-- 	No timeout is used, this means that a multi-key 'pastetoggle' can not
-- 	be triggered manually.
vim.o.pastetoggle = ""
-- string	(default "")
-- 			global
-- 	Expression which is evaluated to apply a patch to a file and generate
-- 	the resulting new version of the file.  See |diff-patchexpr|.
vim.o.patchexpr = ""
-- string	(default "")
-- 			global
-- 	This option allows switching your keyboard into a special language
-- 	mode.  When you are typing text in Insert mode the characters are
-- 	inserted directly.  When in Normal mode the 'langmap' option takes
-- 	care of translating these special characters to the original meaning
-- 	of the key.  This means you don't have to change the keyboard mode to
-- 	be able to execute Normal mode commands.
-- 	This is the opposite of the 'keymap' option, where characters are
-- 	mapped in Insert mode.
-- 	Also consider resetting 'langremap' to avoid 'langmap' applies to
-- 	characters resulting from a mapping.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.langmap = ""
-- string	(default "")
-- 			global
-- 	When non-empty the oldest version of a file is kept.  This can be used
-- 	to keep the original version of a file if you are changing files in a
-- 	source distribution.  Only the first time that a file is written a
-- 	copy of the original file will be kept.  The name of the copy is the
-- 	name of the original file with the string in the 'patchmode' option
-- 	appended.  This option should start with a dot.  Use a string like
-- 	".orig" or ".org".  'backupdir' must not be empty for this to work
-- 	(Detail: The backup file is renamed to the patchmode file after the
-- 	new file has been successfully written, that's why it must be possible
-- 	to write a backup file).  If there was no file to be backed up, an
-- 	empty file is created.
-- 	When the 'backupskip' pattern matches, a patchmode file is not made.
-- 	Using 'patchmode' for compressed files appends the extension at the
-- 	end (e.g., "file.gz.orig"), thus the resulting name isn't always
-- 	recognized as a compressed file.
-- 	Only normal file name characters can be used, "/\*?[|<>" are illegal.
vim.o.patchmode = ""
-- string	(default "")
-- 			global
-- 	Language to use for menu translation.  Tells which file is loaded
-- 	from the "lang" directory in 'runtimepath': >
-- 		"lang/menu_" . &langmenu . ".vim"
-- <	(without the spaces).  For example, to always use the Dutch menus, no
-- 	matter what $LANG is set to: >
-- 		:set langmenu=nl_NL.ISO_8859-1
-- <	When 'langmenu' is empty, |v:lang| is used.
-- 	Only normal file name characters can be used, "/\*?[|<>" are illegal.
-- 	If your $LANG is set to a non-English language but you do want to use
-- 	the English menus: >
-- 		:set langmenu=none
-- <	This option must be set before loading menus, switching on filetype
-- 	detection or syntax highlighting.  Once the menus are defined setting
-- 	this option has no effect.  But you could do this: >
-- 		:source $VIMRUNTIME/delmenu.vim
-- 		:set langmenu=de_DE.ISO_8859-1
-- 		:source $VIMRUNTIME/menu.vim
-- <	Warning: This deletes all menus that you defined yourself!
vim.o.langmenu = ""
-- number (default 12)
-- 			global
-- 	Default height for a preview window.  Used for |:ptag| and associated
-- 	commands.  Used for |CTRL-W_}| when no count is given.
vim.o.previewheight = "12"
-- string	(default empty)
-- 			global
-- 	The name of the printer to be used for |:hardcopy|.
-- 	See |pdev-option|.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.printdevice = ""
-- string	(default empty, except for some systems)
-- 			global
-- 	Sets the character encoding used when printing.
-- 	See |penc-option|.
vim.o.printencoding = ""
-- string	(default: see below)
-- 			global
-- 	Expression used to print the PostScript produced with |:hardcopy|.
-- 	See |pexpr-option|.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.printexpr = "system(['lpr'] + (empty(&printdevice)?[]:['-P', &printdevice]) + [v:fname_in]). delete(v:fname_in)+ v:shell_error"
-- string	(default "courier")
-- 			global
-- 	The name of the font that will be used for |:hardcopy|.
-- 	See |pfn-option|.
vim.o.printfont = "courier"
-- string  (default "%<%f%h%m%=Page %N")
-- 			global
-- 	The format of the header produced in |:hardcopy| output.
-- 	See |pheader-option|.
vim.o.printheader = "%<%f%h%m%=Page %N"
-- string (default "")
-- 			global
-- 	The CJK character set to be used for CJK output from |:hardcopy|.
-- 	See |pmbcs-option|.
vim.o.printmbcharset = ""
-- string (default "")
-- 			global
-- 	List of font names to be used for CJK output from |:hardcopy|.
-- 	See |pmbfn-option|.
vim.o.printmbfont = ""
-- string (default "")
-- 			global
-- 	List of items that control the format of the output of |:hardcopy|.
-- 	See |popt-option|.
vim.o.printoptions = ""
-- boolean	(default on)
-- 			global
-- 	When on a ":" prompt is used in Ex mode.
vim.o.prompt = "true"
-- number	(default 0)
-- 			global
-- 	Enables pseudo-transparency for the |popup-menu|. Valid values are in
-- 	the range of 0 for fully opaque popupmenu (disabled) to 100 for fully
-- 	transparent background. Values between 0-30 are typically most useful.
vim.o.pumblend = "0"
-- number	(default 0)
-- 			global
-- 	Maximum number of items to show in the popup menu
-- 	(|ins-completion-menu|). Zero means "use available screen space".
vim.o.pumheight = "0"
-- number	(default 15)
-- 			global
-- 	Minimum width for the popup menu (|ins-completion-menu|).  If the
-- 	cursor column + 'pumwidth' exceeds screen width, the popup menu is
-- 	nudged to fit on the screen.
vim.o.pumwidth = "15"
-- number	(default depends on the build)
-- 			global
-- 	Specifies the python version used for pyx* functions and commands
-- 	|python_x|.  The default value is as follows:
vim.o.pyxversion = "3"
vim.o.quickfixtextfunc = ""
-- boolean (default off, on for some systems (SGI))
-- 			global
-- 	When set the Input Method is never used.  This is useful to disable
-- 	the IM when it doesn't work properly.
-- 	Currently this option is on by default for SGI/IRIX machines.  This
-- 	may change in later releases.
vim.o.imdisable = "false"
-- string	(default: "@,161-255")
-- 			global
-- 	The characters given by this option are displayed directly on the
-- 	screen.  It is also used for "\p" in a |pattern|.  The characters from
-- 	space (ASCII 32) to '~' (ASCII 126) are always displayed directly,
-- 	even when they are not included in 'isprint' or excluded.  See
-- 	'isfname' for a description of the format of this option.
vim.o.isprint = "@,161-255"
-- number	(default 80 or terminal width)
-- 			global
-- 	Number of columns of the screen.  Normally this is set by the terminal
-- 	initialization and does not have to be set by hand.
-- 	When Vim is running in the GUI or in a resizable window, setting this
-- 	option will cause the window size to be changed.  When you only want
-- 	to use the size for the GUI, put the command in your |ginit.vim| file.
-- 	When you set this option and Vim is unable to change the physical
-- 	number of columns of the display, the display may be messed up.  For
-- 	the GUI it is always possible and Vim limits the number of columns to
-- 	what fits on the screen.  You can use this command to get the widest
-- 	window possible: >
-- 		:set columns=9999
-- <	Minimum value is 12, maximum value is 10000.
vim.o.columns = "80"
-- boolean	(default on)
-- 			global
-- 	When on the plugin scripts are loaded when starting up |load-plugins|.
-- 	This option can be reset in your |vimrc| file to disable the loading
-- 	of plugins.
-- 	Note that using the "-u NONE" and "--noplugin" command line arguments
-- 	reset this option. |-u| |--noplugin|
vim.o.loadplugins = "true"
-- string	(default "")
-- 			global or local to buffer |global-local|
-- 	Encoding used for reading the output of external commands.  When empty,
-- 	encoding is not converted.
-- 	This is used for `:make`, `:lmake`, `:grep`, `:lgrep`, `:grepadd`,
-- 	`:lgrepadd`, `:cfile`, `:cgetfile`, `:caddfile`, `:lfile`, `:lgetfile`,
-- 	and `:laddfile`.
vim.o.makeencoding = ""
-- string	(default empty)
-- 			global
-- 	When nonempty describes the text to use in a tooltip for the GUI tab
-- 	pages line.  When empty Vim will use a default tooltip.
-- 	This option is otherwise just like 'guitablabel' above.
-- 	You can include a line break.  Simplest method is to use |:let|: >
-- 		:let &guitabtooltip = "line one\nline two"
-- <
vim.o.guitabtooltip = ""
-- string	(default '')
-- 			global
-- 	Flags to change the way redrawing works, for debugging purposes.
-- 	Most useful with 'writedelay' set to some reasonable value.
-- 	Supports the following flags:
-- 	    compositor	Indicate what redraws come from the compositor
-- 			by briefly flashing the redrawn regions in colors
-- 			indicating the redraw type. These are the highlight
-- 			groups used (and their default colors):
-- 		RedrawDebugNormal   gui=reverse   normal redraw passed through
-- 		RedrawDebugClear    guibg=Yellow  clear event passed through
-- 		RedrawDebugComposed guibg=Green   redraw event modified by the
-- 						  compositor (due to
-- 						  overlapping grids, etc)
-- 		RedrawDebugRecompose guibg=Red    redraw generated by the
-- 						  compositor itself, due to a
-- 						  grid being moved or deleted.
-- 	    nothrottle	Turn off throttling of the message grid. This is an
-- 			optimization that joins many small scrolls to one
-- 			larger scroll when drawing the message area (with
-- 			'display' msgsep flag active).
-- 	    invalid	Enable stricter checking (abort) of inconsistencies
-- 			of the internal screen state. This is mostly
-- 			useful when running nvim inside a debugger (and
-- 			the test suite).
-- 	    nodelta	Send all internally redrawn cells to the UI, even if
-- 	                they are unchanged from the already displayed state.
vim.o.redrawdebug = ""
