--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- boolean	(default on for systems where case in file
-- 				 names is normally ignored)
-- 			global
-- 	When set case is ignored when using file names and directories.
-- 	See 'wildignorecase' for only ignoring case when doing completion.
vim.o.fileignorecase = "true"
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
-- string (default "")
-- 			global
-- 	When set to "all", a fold is closed when the cursor isn't in it and
-- 	its level is higher than 'foldlevel'.  Useful if you want folds to
-- 	automatically close when moving out of them.
vim.o.foldclose = ""
-- boolean (default off, set in |defaults.vim|)
-- 			global
-- 			{only available when compiled with the |+langmap|
-- 			feature}
-- 	This is just like 'langremap' but with the value inverted.  It only
-- 	exists for backwards compatibility.  When setting 'langremap' then
-- 	'langnoremap' is set to the inverted value, and the other way around.
vim.o.langnoremap = "true"
-- boolean (default off)
-- 			global
-- 	When off, setting 'langmap' does not apply to characters resulting from
-- 	a mapping.  If setting 'langmap' disables some of your mappings, make
-- 	sure this option is off.
vim.o.langremap = "false"
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
-- boolean	(default off)
-- 			global
-- 	When this option is set, the screen will not be redrawn while
-- 	executing macros, registers and other commands that have not been
-- 	typed.  Also, updating the window title is postponed.  To force an
-- 	update use |:redraw|.
vim.o.lazyredraw = "false"
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
-- boolean	(default on)
-- 			global
-- 	When on the plugin scripts are loaded when starting up |load-plugins|.
-- 	This option can be reset in your |vimrc| file to disable the loading
-- 	of plugins.
-- 	Note that using the "-u NONE" and "--noplugin" command line arguments
-- 	reset this option. |-u| |--noplugin|
vim.o.loadplugins = "true"
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
-- 	Encoding used for reading the output of external commands.  When empty,
-- 	encoding is not converted.
-- 	This is used for `:make`, `:lmake`, `:grep`, `:lgrep`, `:grepadd`,
-- 	`:lgrepadd`, `:cfile`, `:cgetfile`, `:caddfile`, `:lfile`, `:lgetfile`,
-- 	and `:laddfile`.
vim.o.makeencoding = ""
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
-- boolean	(default off)
-- 			global
-- 	This option is obsolete; |bracketed-paste-mode| is built-in.
vim.o.paste = "false"
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
-- number	(default 1000)
-- 			global
-- 	Maximum number of times a mapping is done without resulting in a
-- 	character to be used.  This normally catches endless mappings, like
-- 	":map x y" with ":map y x".  It still does not catch ":map g wg",
-- 	because the 'w' is used before the next mapping is done.  See also
-- 	|key-mapping|.
vim.o.maxmapdepth = "1000"
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
-- boolean	(default off)
-- 			global
-- 	When on, the OS function fsync() will be called after saving a file
-- 	(|:write|, |writefile()|, …), |swap-file| and |shada-file|. This
-- 	flushes the file to disk, ensuring that it is safely written.
-- 	Slow on some systems: writing buffers, quitting Nvim, and other
-- 	operations may sometimes take a few seconds.
vim.o.fsync = "false"
-- number	(default 25)
-- 			global
-- 	Maximum number of items to use in a menu.  Used for menus that are
-- 	generated from a list of items, e.g., the Buffers menu.  Changing this
-- 	option has no direct effect, the menu must be refreshed first.
vim.o.menuitems = "25"
-- boolean	(default off)
-- 			global
-- 	When on, the ":substitute" flag 'g' is default on.  This means that
-- 	all matches in a line are substituted instead of one.  When a 'g' flag
-- 	is given to a ":substitute" command, this will toggle the substitution
-- 	of all or one match.  See |complex-change|.
vim.o.gdefault = "false"
-- string	(default "460000,2000,500")
-- 			global
-- 	Parameters for |:mkspell|.  This tunes when to start compressing the
-- 	word tree.  Compression can be slow when there are many words, but
-- 	it's needed to avoid running out of memory.  The amount of memory used
-- 	per word depends very much on how similar the words are, that's why
-- 	this tuning is complicated.
vim.o.mkspellmem = "460000,2000,500"
-- string	(default "%f:%l:%m,%f:%l%m,%f  %l%m")
-- 			global
-- 	Format to recognize for the ":grep" command output.
-- 	This is a scanf-like string that uses the same format as the
-- 	'errorformat' option: see |errorformat|.
vim.o.grepformat = "%f:%l:%m,%f:%l%m,%f  %l%m"
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
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	When on, listings pause when the whole screen is filled.  You will get
-- 	the |more-prompt|.  When this option is off there are no pauses, the
-- 	listing continues until finished.
vim.o.more = "true"
-- string	(default "")
-- 			global
vim.o.mouse = ""
-- boolean	(default off)
-- 			global
-- 			{only works in the GUI}
-- 	The window that the mouse pointer is on is automatically activated.
-- 	When changing the window layout or window focus in another way, the
-- 	mouse pointer is moved to the window with keyboard focus.  Off is the
-- 	default because it makes using the pull down menus a little goofy, as
-- 	a pointer transit may activate a window unintentionally.
vim.o.mousefocus = "false"
-- string	(default "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20")
-- 			global
-- 	Configures the cursor style for each mode. Works in the GUI and many
-- 	terminals.  See |tui-cursor-shape|.
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- boolean	(default on)
-- 			global
-- 			{only works in the GUI}
-- 	When on, the mouse pointer is hidden when characters are typed.
-- 	The mouse pointer is restored when the mouse is moved.
vim.o.mousehide = "true"
-- boolean	(default off, on when title can be restored)
-- 			global
-- 	When on, the icon text of the window will be set to the value of
-- 	'iconstring' (if it is not empty), or to the name of the file
-- 	currently being edited.  Only the last part of the name is used.
-- 	Overridden by the 'iconstring' option.
-- 	Only works if the terminal supports setting window icons.
vim.o.icon = "false"
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
-- boolean	(default off)
-- 			global
-- 	Ignore case in search patterns.  Also used when searching in the tags
-- 	file.
-- 	Also see 'smartcase' and 'tagcase'.
-- 	Can be overruled by using "\c" or "\C" in the pattern, see
-- 	|/ignorecase|.
vim.o.ignorecase = "false"
-- string	(default ":Man", Windows: ":help")
-- 			global or local to buffer |global-local|
-- 	Program to use for the |K| command.  Environment variables are
-- 	expanded |:set_env|.  ":help" may be used to access the Vim internal
-- 	help.  (Note that previously setting the global option to the empty
-- 	value did this, which is now deprecated.)
-- 	When the first character is ":", the command is invoked as a Vim
-- 	command prefixed with [count].
-- 	When "man" or "man -s" is used, Vim will automatically translate
-- 	a [count] for the "K" command to a section number.
-- 	See |option-backslash| about including spaces and backslashes.
-- 	Example: >
-- 		:set keywordprg=man\ -s
-- 		:set keywordprg=:Man
-- <	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.keywordprg = ":Man"
-- number	(default 20)
-- 			global
-- 	Minimal initial height of the help window when it is opened with the
-- 	":help" command.  The initial height of the help window is half of the
-- 	current window, or (when the 'ea' option is on) the same as other
-- 	windows.  When the height is less than 'helpheight', the height is
-- 	set to 'helpheight'.  Set to zero to disable.
vim.o.helpheight = "20"
-- string	(default "")
-- 			global
vim.o.inccommand = "nosplit"
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
-- string	(default "all")
-- 			global
-- 	Specifies for which events the bell will not be rung. It is a comma
-- 	separated list of items. For each item that is present, the bell
-- 	will be silenced. This is most useful to specify specific events in
-- 	insert mode to be silenced.
vim.o.belloff = "all"
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
-- boolean	(default off)
-- 			global
-- 	When on, splitting a window will put the new window right of the
-- 	current one. |:vsplit|
vim.o.splitright = "false"
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
-- number	(default: 200)
-- 			global
-- 	After typing this many characters the swap file will be written to
-- 	disk.  When zero, no swap file will be created at all (see chapter on
-- 	recovery |crash-recovery|).  'updatecount' is set to zero by starting
-- 	Vim with the "-n" option, see |startup|.  When editing in readonly
-- 	mode this option will be initialized to 10000.
-- 	The swapfile can be disabled per buffer with |'swapfile'|.
-- 	When 'updatecount' is set from zero to non-zero, swap files are
-- 	created for all buffers that have 'swapfile' set.  When 'updatecount'
-- 	is set to zero, existing swap files are not deleted.
-- 	This option has no meaning in buffers where |'buftype'| is "nofile"
-- 	or "nowrite".
vim.o.updatecount = "200"
-- number	(Vim default: 10000, Vi default: 0)
-- 			global
-- 	A history of ":" commands, and a history of previous search patterns
-- 	is remembered.  This option decides how many entries may be stored in
-- 	each of these histories (see |cmdline-editing|).
-- 	The maximum value is 10000.
vim.o.history = "10000"
-- number	(default 0)
-- 			global
-- 	When bigger than zero, Vim will give messages about what it is doing.
-- 	Currently, these messages are given:
-- 	>= 1	When the shada file is read or written.
-- 	>= 2	When a file is ":source"'ed.
-- 	>= 3	UI info, terminal capabilities
-- 	>= 5	Every searched tags file and include file.
-- 	>= 8	Files for which a group of autocommands is executed.
-- 	>= 9	Every executed autocommand.
-- 	>= 12	Every executed function.
-- 	>= 13	When an exception is thrown, caught, finished, or discarded.
-- 	>= 14	Anything pending in a ":finally" clause.
-- 	>= 15	Every executed Ex command (truncated at 200 characters).
vim.o.verbose = "0"
-- boolean (default off)
-- 			global
-- 	When on, the keyboard is mapped for the Hebrew character set.
-- 	Normally you would set 'allowrevins' and use CTRL-_ in insert mode to
-- 	toggle this option.  See |rileft.txt|.
vim.o.hkmap = "false"
-- number	(default 500)
-- 			global
-- 	Defines the maximum time in msec between two mouse clicks for the
-- 	second click to be recognized as a multi click.
vim.o.mousetime = "500"
-- boolean	(default off)
-- 			global
-- 			{only for Windows}
-- 	Enable reading and writing from devices.  This may get Vim stuck on a
-- 	device that can be opened but doesn't actually do the I/O.  Therefore
-- 	it is off by default.
-- 	Note that on Windows editing "aux.h", "lpt1.txt" and the like also
-- 	result in editing a device.
vim.o.opendevice = "false"
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
-- string	(default: empty)
-- 			global
-- 	This option specifies a function to be called by the |g@| operator.
-- 	See |:map-operator| for more info and an example.
vim.o.operatorfunc = ""
-- boolean	(default off)
-- 			global
-- 	Allows writing to any file with no need for "!" override.
vim.o.writeany = "false"
-- string	(default: see 'runtimepath')
-- 	Directories used to find packages.  See |packages|.
vim.o.packpath = "/Users/andri/.config/nvim,/etc/xdg/nvim,/Users/andri/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/HEAD-0344736/share/nvim/runtime,/usr/local/Cellar/neovim/HEAD-0344736/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/andri/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/andri/.config/nvim/after"
-- number	(default 1)
-- 			global
-- 	Number of screen lines to use for the command-line.  Helps avoiding
-- 	|hit-enter| prompts.
-- 	The value of this option is stored with the tab page, so that each tab
-- 	page can have a different value.
vim.o.cmdheight = "1"
-- number	(default 15)
-- 			global
-- 	Minimum width for the popup menu (|ins-completion-menu|).  If the
-- 	cursor column + 'pumwidth' exceeds screen width, the popup menu is
-- 	nudged to fit on the screen.
vim.o.pumwidth = "15"
-- string	(default "IPLPPPQPP TPHPLIPpLpItpplpipbp")
-- 			global
-- 	Specifies the nroff macros that separate paragraphs.  These are pairs
-- 	of two letters (see |object-motions|).
vim.o.paragraphs = "IPLPPPQPP TPHPLIPpLpItpplpipbp"
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
-- string	(default is very long)
-- 			global or local to buffer |global-local|
-- 	Scanf-like description of the format for the lines in the error file
-- 	(see |errorformat|).
vim.o.errorformat = "%*[^\"]\"%f\"%*\\D%l: %m,\"%f\"%*\\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,\"%f\"\\, line %l%*\\D%c%*[^ ] %m,%D%*\\a[%*\\d]: Entering directory %*[`']%f',%X%*\\a[%*\\d]: Leaving directory %*[`']%f',%D%*\\a: Entering directory %*[`']%f',%X%*\\a: Leaving directory %*[`']%f',%DMaking %*\\a in %f,%f|%l| %m"
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
-- number	(default 50)
-- 			global
-- 	Maximum number of tab pages to be opened by the |-p| command line
-- 	argument or the ":tab all" command. |tabpage|
vim.o.tabpagemax = "50"
-- string	(default "")
-- 			global
-- 	Expression which is evaluated to apply a patch to a file and generate
-- 	the resulting new version of the file.  See |diff-patchexpr|.
vim.o.patchexpr = ""
-- boolean	(default off)
-- 			global
-- 	Inserting characters in Insert mode will work backwards.  See "typing
-- 	backwards" |ins-reverse|.  This option can be toggled with the CTRL-_
-- 	command in Insert mode, when 'allowrevins' is set.
-- 	This option is reset when 'paste' is set and restored when 'paste' is
-- 	reset.
vim.o.revins = "false"
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
vim.o.cdhome = "false"
-- string	(default "./tags;,tags")
-- 			global or local to buffer |global-local|
-- 	Filenames for the tag command, separated by spaces or commas.  To
-- 	include a space or comma in a file name, precede it with a backslash
-- 	(see |option-backslash| about including spaces and backslashes).
-- 	When a file name starts with "./", the '.' is replaced with the path
-- 	of the current file.  But only when the 'd' flag is not included in
-- 	'cpoptions'.  Environment variables are expanded |:set_env|.  Also see
-- 	|tags-option|.
-- 	"*", "**" and other wildcards can be used to search for tags files in
-- 	a directory tree.  See |file-searching|.  E.g., "/lib/**/tags" will
-- 	find all files named "tags" below "/lib".  The filename itself cannot
-- 	contain wildcards, it is used as-is.  E.g., "/lib/**/tags?" will find
-- 	files called "tags?".
-- 	The |tagfiles()| function can be used to get a list of the file names
-- 	actually used.
-- 	The use of |:set+=| and |:set-=| is preferred when adding or removing
-- 	file names from the list.  This avoids problems when a future version
-- 	uses another default.
vim.o.tags = "./tags;,tags"
-- string	(default: equivalent to $CDPATH or ",,")
-- 			global
-- 	This is a list of directories which will be searched when using the
-- 	|:cd| and |:lcd| commands, provided that the directory being searched
-- 	for has a relative path, not an absolute part starting with "/", "./"
-- 	or "../", the 'cdpath' option is not used then.
-- 	The 'cdpath' option's value has the same form and semantics as
-- 	|'path'|.  Also see |file-searching|.
-- 	The default value is taken from $CDPATH, with a "," prepended to look
-- 	in the current directory first.
-- 	If the default value taken from $CDPATH is not what you want, include
-- 	a modified version of the following command in your vimrc file to
-- 	override it: >
-- 	  :let &cdpath = ',' . substitute(substitute($CDPATH, '[, ]', '\\\0', 'g'), ':', ',', 'g')
-- <	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
-- 	(parts of 'cdpath' can be passed to the shell to expand file names).
vim.o.cdpath = ",,"
-- string	(default "")
-- 			global or local to window |global-local|
-- 	Characters to fill the statuslines and vertical separators.
-- 	It is a comma separated list of items:
vim.o.fillchars = ""
-- number (default 12)
-- 			global
-- 	Default height for a preview window.  Used for |:ptag| and associated
-- 	commands.  Used for |CTRL-W_}| when no count is given.
vim.o.previewheight = "12"
-- string	(Vim default: CTRL-F, Vi default: "")
-- 			global
-- 	The key used in Command-line Mode to open the command-line window.
-- 	Only non-printable keys are allowed.
-- 	The key can be specified as a single character, but it is difficult to
-- 	type.  The preferred way is to use the <> notation.  Examples: >
-- 		:exe "set cedit=\<C-Y>"
-- 		:exe "set cedit=\<Esc>"
-- <	|Nvi| also has this option, but it only uses the first character.
-- 	See |cmdwin|.
vim.o.cedit = "\6"
-- string	(default empty)
-- 			global
-- 	When nonempty, this option determines the content of the tab pages
-- 	line at the top of the Vim window.  When empty Vim will use a default
-- 	tab pages line.  See |setting-tabline| for more info.
vim.o.tabline = ""
-- string (default "")
-- 			global
-- 	List of items that control the format of the output of |:hardcopy|.
-- 	See |popt-option|.
vim.o.printoptions = ""
-- string	(default empty)
-- 			global
-- 	The name of the printer to be used for |:hardcopy|.
-- 	See |pdev-option|.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.printdevice = ""
-- boolean	(default on)
-- 			global
-- 	When on a ":" prompt is used in Ex mode.
vim.o.prompt = "true"
-- string	(default empty, except for some systems)
-- 			global
-- 	Sets the character encoding used when printing.
-- 	See |penc-option|.
vim.o.printencoding = ""
-- boolean	(default off)
-- 			global
-- 	When on, the title of the window will be set to the value of
-- 	'titlestring' (if it is not empty), or to:
-- 		filename [+=-] (path) - NVIM
-- 	Where:
-- 		filename	the name of the file being edited
-- 		-		indicates the file cannot be modified, 'ma' off
-- 		+		indicates the file was modified
-- 		=		indicates the file is read-only
-- 		=+		indicates the file is read-only and modified
-- 		(path)		is the path of the file being edited
-- 		- NVIM		the server name |v:servername| or "NVIM"
vim.o.title = "false"
-- string	(default: see below)
-- 			global
-- 	Expression used to print the PostScript produced with |:hardcopy|.
-- 	See |pexpr-option|.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.printexpr = "system(['lpr'] + (empty(&printdevice)?[]:['-P', &printdevice]) + [v:fname_in]). delete(v:fname_in)+ v:shell_error"
-- string	(default ""; with GTK+ GUI: "utf-8"; with
-- 						    Macintosh GUI: "macroman")
-- 			global
-- 	Encoding used for the terminal.  This specifies what character
-- 	encoding the keyboard produces and the display will understand.  For
-- 	the GUI it only applies to the keyboard ('encoding' is used for the
-- 	display).  Except for the Mac when 'macatsui' is off, then
-- 	'termencoding' should be "macroman".
-- 								*E617*
-- 	Note: This does not apply to the GTK+ GUI.  After the GUI has been
-- 	successfully initialized, 'termencoding' is forcibly set to "utf-8".
-- 	Any attempts to set a different value will be rejected, and an error
-- 	message is shown.
-- 	For the Win32 GUI and console versions 'termencoding' is not used,
-- 	because the Win32 system always passes Unicode characters.
-- 	When empty, the same encoding is used as for the 'encoding' option.
-- 	This is the normal value.
-- 	Not all combinations for 'termencoding' and 'encoding' are valid.  See
-- 	|encoding-table|.
-- 	The value for this option must be supported by internal conversions or
-- 	iconv().  When this is not possible no conversion will be done and you
-- 	will probably experience problems with non-ASCII characters.
-- 	Example: You are working with the locale set to euc-jp (Japanese) and
-- 	want to edit a UTF-8 file: >
-- 		:let &termencoding = &encoding
-- 		:set encoding=utf-8
-- <	You need to do this when your system has no locale support for UTF-8.
vim.o.termencoding = ""
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
-- number	(default 224)
-- 			global
-- 	The ASCII code for the first letter of the Hebrew alphabet.  The
-- 	routine that maps the keyboard in Hebrew mode, both in Insert mode
-- 	(when hkmap is set) and on the command-line (when hitting CTRL-_)
-- 	outputs the Hebrew characters in the range [aleph..aleph+26].
-- 	aleph=128 applies to PC code, and aleph=224 applies to ISO 8859-8.
-- 	See |rileft.txt|.
vim.o.aleph = "224"
-- boolean (default off)
-- 			global
-- 	Enables 24-bit RGB color in the |TUI|.  Uses "gui" |:highlight|
-- 	attributes instead of "cterm" attributes. |highlight-guifg|
-- 	Requires an ISO-8613-3 compatible terminal.
vim.o.termguicolors = "false"
-- number	(default 0)
-- 			global
-- 	If non-zero, tags are significant up to this number of characters.
vim.o.taglength = "0"
-- string  (default "%<%f%h%m%=Page %N")
-- 			global
-- 	The format of the header produced in |:hardcopy| output.
-- 	See |pheader-option|.
vim.o.printheader = "%<%f%h%m%=Page %N"
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	If on and using a tags file in another directory, file names in that
-- 	tags file are relative to the directory where the tags file is.
vim.o.tagrelative = "true"
-- number	(default 2000)
-- 			global
-- 	Time in milliseconds for redrawing the display.  Applies to
-- 	'hlsearch', 'inccommand', |:match| highlighting and syntax
-- 	highlighting.
-- 	When redrawing takes more than this many milliseconds no further
-- 	matches will be highlighted.
-- 	For syntax highlighting the time applies per window.  When over the
-- 	limit syntax highlighting is disabled until |CTRL-L| is used.
-- 	This is used to avoid that Vim hangs when using a very complicated
-- 	pattern.
vim.o.redrawtime = "2000"
-- string (default "")
-- 			global
-- 	The CJK character set to be used for CJK output from |:hardcopy|.
-- 	See |pmbcs-option|.
vim.o.printmbcharset = ""
vim.o.termpastefilter = "BS,HT,ESC,DEL"
-- string (default "")
-- 			global
-- 	List of font names to be used for CJK output from |:hardcopy|.
-- 	See |pmbfn-option|.
vim.o.printmbfont = ""
-- boolean	(default on)
-- 			global
-- 	When on, the |tagstack| is used normally.  When off, a ":tag" or
-- 	":tselect" command with an argument will not push the tag onto the
-- 	tagstack.  A following ":tag" without an argument, a ":pop" command or
-- 	any other command that uses the tagstack will use the unmodified
-- 	tagstack, but does change the pointer to the active entry.
-- 	Resetting this option is useful when using a ":tag" command in a
-- 	mapping which should not change the tagstack.
vim.o.tagstack = "true"
-- boolean (default on)
-- 			global
-- 	When on and 'termbidi' is off, the required visual character
-- 	corrections that need to take place for displaying the Arabic language
-- 	take effect.  Shaping, in essence, gets enabled; the term is a broad
-- 	one which encompasses:
-- 	  a) the changing/morphing of characters based on their location
-- 	     within a word (initial, medial, final and stand-alone).
-- 	  b) the enabling of the ability to compose characters
-- 	  c) the enabling of the required combining of some characters
-- 	When disabled the display shows each character's true stand-alone
-- 	form.
-- 	Arabic is a complex language which requires other settings, for
-- 	further details see |arabic.txt|.
vim.o.arabicshape = "true"
-- boolean (default off)
-- 			global
-- 	The terminal is in charge of Bi-directionality of text (as specified
-- 	by Unicode).  The terminal is also expected to do the required shaping
-- 	that some languages (such as Arabic) require.
-- 	Setting this option implies that 'rightleft' will not be set when
-- 	'arabic' is set and the value of 'arabicshape' will be ignored.
-- 	Note that setting 'termbidi' has the immediate effect that
-- 	'arabicshape' is ignored, but 'rightleft' isn't changed automatically.
-- 	For further details see |arabic.txt|.
vim.o.termbidi = "false"
-- boolean	(default off)
-- 			global
-- 	Allow CTRL-_ in Insert and Command-line mode.  This is default off, to
-- 	avoid that users that accidentally type CTRL-_ instead of SHIFT-_ get
-- 	into reverse Insert mode, and don't know how to get out.  See
-- 	'revins'.
vim.o.allowrevins = "false"
-- number	(default 0)
-- 			global
-- 	Enables pseudo-transparency for the |popup-menu|. Valid values are in
-- 	the range of 0 for fully opaque popupmenu (disabled) to 100 for fully
-- 	transparent background. Values between 0-30 are typically most useful.
vim.o.pumblend = "0"
-- string (default: "single")
-- 			global
-- 	Tells Vim what to do with characters with East Asian Width Class
-- 	Ambiguous (such as Euro, Registered Sign, Copyright Sign, Greek
-- 	letters, Cyrillic letters).
vim.o.ambiwidth = "single"
-- string	(default "")
-- 			global
-- 	These values can be used:
-- 	msg	Error messages that would otherwise be omitted will be given
-- 		anyway.
-- 	throw	Error messages that would otherwise be omitted will be given
-- 		anyway and also throw an exception and set |v:errmsg|.
-- 	beep	A message will be given when otherwise only a beep would be
-- 		produced.
-- 	The values can be combined, separated by a comma.
-- 	"msg" and "throw" are useful for debugging 'foldexpr', 'formatexpr' or
-- 	'indentexpr'.
vim.o.debug = ""
-- number	(default 0)
-- 			global
-- 	The number of milliseconds to wait for each character sent to the
-- 	screen.  When positive, characters are sent to the UI one by one.
-- 	See 'redrawdebug' for more options.  For debugging purposes.
vim.o.writedelay = "0"
-- boolean (default off)
-- 			global
-- 	When on, Vim will change the current working directory whenever you
-- 	open a file, switch buffers, delete a buffer or open/close a window.
-- 	It will change to the directory containing the file which was opened
-- 	or selected.
-- 	Note: When this option is on some plugins may not work.
vim.o.autochdir = "false"
-- boolean	(default off)
-- 			global
-- 	When on: The tilde command "~" behaves like an operator.
vim.o.tildeop = "false"
-- number	(default depends on the build)
-- 			global
-- 	Specifies the python version used for pyx* functions and commands
-- 	|python_x|.  The default value is as follows:
vim.o.pyxversion = "3"
-- boolean	(default off)
-- 			global
-- 	When set: Add 's' flag to 'shortmess' option (this makes the message
-- 	for a search that hits the start or end of the file not being
-- 	displayed).  When reset: Remove 's' flag from 'shortmess' option.
vim.o.terse = "false"
-- boolean	(default on)
-- 			global or local to buffer |global-local|
-- 	When a file has been detected to have been changed outside of Vim and
-- 	it has not been changed inside of Vim, automatically read it again.
-- 	When the file has been deleted this is not done, so you have the text
-- 	from before it was deleted.  When it appears again then it is read.
-- 	|timestamp|
-- 	If this option has a local value, use this command to switch back to
-- 	using the global value: >
-- 		:set autoread<
-- <
-- 				 *'autowrite'* *'aw'* *'noautowrite'* *'noaw'*
vim.o.autoread = "true"
vim.o.thesaurusfunc = ""
-- boolean	(default off)
-- 			global
-- 	Write the contents of the file, if it has been modified, on each
-- 	:next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
-- 	:make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
-- 	'{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
-- 	Note that for some commands the 'autowrite' option is not used, see
-- 	'autowriteall' for that.
-- 	Some buffers will not be written, specifically when 'buftype' is
-- 	"nowrite", "nofile", "terminal" or "prompt".
vim.o.autowrite = "false"
-- string	(default "")
-- 			global or local to buffer |global-local|
-- 	List of file names, separated by commas, that are used to lookup words
-- 	for thesaurus completion commands |i_CTRL-X_CTRL-T|.
vim.o.thesaurus = ""
-- boolean	(default off)
-- 			global
-- 	Like 'autowrite', but also used for commands ":edit", ":enew", ":quit",
-- 	":qall", ":exit", ":xit", ":recover" and closing the Vim window.
-- 	Setting this option also implies that Vim behaves like 'autowrite' has
-- 	been set.
vim.o.autowriteall = "false"
vim.o.quickfixtextfunc = ""
-- string	(default "dark")
-- 			global
-- 	When set to "dark" or "light", adjusts the default color groups for
-- 	that background type.  The |TUI| or other UI sets this on startup
-- 	(triggering |OptionSet|) if it can detect the background color.
vim.o.background = "dark"
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
-- boolean (default on)
-- 			global
-- 	This option and 'timeoutlen' determine the behavior when part of a
-- 	mapped key sequence has been received. For example, if <c-f> is
-- 	pressed and 'timeout' is set, Nvim will wait 'timeoutlen' milliseconds
-- 	for any key that can follow <c-f> in a mapping.
vim.o.timeout = "true"
-- string	(default "indent,eol,start")
-- 			global
-- 	Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert
-- 	mode.  This is a list of items, separated by commas.  Each item allows
-- 	a way to backspace over something:
-- 	value	effect	~
-- 	indent	allow backspacing over autoindent
-- 	eol	allow backspacing over line breaks (join lines)
-- 	start	allow backspacing over the start of insert; CTRL-W and CTRL-U
-- 		stop once at the start of insert.
vim.o.backspace = "indent,eol,start"
-- number	(default 1000)
-- 			global
-- 	Time in milliseconds to wait for a mapped sequence to complete.
vim.o.timeoutlen = "1000"
-- number	(default 0)
-- 			global
-- 	This selects the default regexp engine. |two-engines|
-- 	The possible values are:
-- 		0	automatic selection
-- 		1	old engine
-- 		2	NFA engine
-- 	Note that when using the NFA engine and the pattern contains something
-- 	that is not supported the pattern will not match.  This is only useful
-- 	for debugging the regexp engine.
-- 	Using automatic selection enables Vim to switch the engine, if the
-- 	default engine becomes too costly.  E.g., when the NFA engine uses too
-- 	many states.  This should prevent Vim from hanging on a combination of
-- 	a complex pattern with long text.
vim.o.regexpengine = "0"
-- boolean	(default off)
-- 			global
-- 	Make a backup before overwriting a file.  Leave it around after the
-- 	file has been successfully written.  If you do not want to keep the
-- 	backup file, but you do want a backup while the file is being
-- 	written, reset this option and set the 'writebackup' option (this is
-- 	the default).  If you do not want a backup file at all reset both
-- 	options (use this if your file system is almost full).  See the
-- 	|backup-table| for more explanations.
-- 	When the 'backupskip' pattern matches, a backup is not made anyway.
-- 	When 'patchmode' is set, the backup may be renamed to become the
-- 	oldest version of a file.
vim.o.backup = "false"
-- number	(default 85)
-- 			global
-- 	Gives the percentage of 'columns' to use for the length of the window
-- 	title.  When the title is longer, only the end of the path name is
-- 	shown.  A '<' character before the path name is used to indicate this.
-- 	Using a percentage makes this adapt to the width of the window.  But
-- 	it won't work perfectly, because the actual number of characters
-- 	available also depends on the font used and other things in the title
-- 	bar.  When 'titlelen' is zero the full path is used.  Otherwise,
-- 	values from 1 to 30000 percent can be used.
-- 	'titlelen' is also used for the 'titlestring' option.
vim.o.titlelen = "85"
