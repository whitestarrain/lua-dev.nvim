--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- boolean	(default off)
-- 			global
-- 	Use visual bell instead of beeping.  Also see 'errorbells'.
vim.o.visualbell = "false"
-- boolean	(default off)
-- 			global
-- 			{only for Windows}
-- 	When set, a forward slash is used when expanding file names.  This is
-- 	useful when a Unix-like shell is used instead of command.com or
-- 	cmd.exe.  Backward slashes can still be typed, but they are changed to
-- 	forward slashes by Vim.
-- 	Note that setting or resetting this option has no effect for some
-- 	existing file names, thus this option needs to be set before opening
-- 	any file for best results.  This might change in the future.
-- 	'shellslash' only works when a backslash can be used as a path
-- 	separator.  To test if this is so use: >
-- 		if exists('+shellslash')
-- <
-- 			*'shelltemp'* *'stmp'* *'noshelltemp'* *'nostmp'*
vim.o.shellslash = "false"
-- boolean	(default on)
-- 			global
-- 	Give a warning message when a shell command is used while the buffer
-- 	has been changed.
vim.o.warn = "true"
-- boolean	(Vim default on, Vi default off)
-- 			global
-- 	When on, use temp files for shell commands.  When off use a pipe.
-- 	When using a pipe is not possible temp files are used anyway.
-- 	The advantage of using a pipe is that nobody can read the temp file
-- 	and the 'shell' command does not need to support redirection.
-- 	The advantage of using a temp file is that the file type and encoding
-- 	can be detected.
-- 	The |FilterReadPre|, |FilterReadPost| and |FilterWritePre|,
-- 	|FilterWritePost| autocommands event are not triggered when
-- 	'shelltemp' is off.
-- 	|system()| does not respect this option, it always uses pipes.
vim.o.shelltemp = "true"
-- boolean	(default on, off when a |vimrc| or |gvimrc|
-- 					file is found, reset in |defaults.vim|)
-- 			global
-- 	This option has the effect of making Vim either more Vi-compatible, or
-- 	make Vim behave in a more useful way.
vim.o.compatible = "false"
-- string	(default: "", Windows: "\"")
-- 			global
-- 	Quoting character(s), put around the command passed to the shell, for
-- 	the "!" and ":!" commands.  Includes the redirection.  See
-- 	'shellquote' to exclude the redirection.  It's probably not useful
-- 	to set both options.
-- 	When the value is '(' then ')' is appended. When the value is '"('
-- 	then ')"' is appended.
-- 	When the value is '(' then also see 'shellxescape'.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.shellxquote = ""
-- number	(Vim default: <Tab>, Vi default: CTRL-E)
-- 			global
-- 	Character you have to type to start wildcard expansion in the
-- 	command-line, as specified with 'wildmode'.
-- 	More info here: |cmdline-completion|.
-- 	The character is not recognized when used inside a macro.  See
-- 	'wildcharm' for that.
-- 	Although 'wc' is a number option, you can set it to a special key: >
-- 		:set wc=<Esc>
-- <
vim.o.wildchar = "9"
-- string	(default: "")
-- 			global
-- 	When 'shellxquote' is set to "(" then the characters listed in this
-- 	option will be escaped with a '^' character.  This makes it possible
-- 	to execute most external commands with cmd.exe.
vim.o.shellxescape = ""
-- number	(default: none (0))
-- 			global
-- 	'wildcharm' works exactly like 'wildchar', except that it is
-- 	recognized when used inside a macro.  You can find "spare" command-line
-- 	keys suitable for this option by looking at |ex-edit-index|.  Normally
-- 	you'll never actually type 'wildcharm', just use it in mappings that
-- 	automatically invoke completion mode, e.g.: >
-- 		:set wcm=<C-Z>
-- 		:cnoremap ss so $vim/sessions/*.vim<C-Z>
-- <	Then after typing :ss you can use CTRL-P & CTRL-N.
vim.o.wildcharm = "0"
-- boolean	(default off)
-- 			global
-- 	Round indent to multiple of 'shiftwidth'.  Applies to > and <
-- 	commands.  CTRL-T and CTRL-D in Insert mode always round the indent to
-- 	a multiple of 'shiftwidth' (this is Vi compatible).
vim.o.shiftround = "false"
-- string	(default "")
-- 			global
-- 	A list of file patterns.  A file that matches with one of these
-- 	patterns is ignored when expanding |wildcards|, completing file or
-- 	directory names, and influences the result of |expand()|, |glob()| and
-- 	|globpath()| unless a flag is passed to disable this.
-- 	The pattern is used like with |:autocmd|, see |autocmd-pattern|.
-- 	Also see 'suffixes'.
-- 	Example: >
-- 		:set wildignore=*.o,*.obj
-- <	The use of |:set+=| and |:set-=| is preferred when adding or removing
-- 	a pattern from the list.  This avoids problems when a future version
-- 	uses another default.
vim.o.wildignore = ""
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
-- boolean	(default off)
-- 			global
-- 	When set case is ignored when completing file names and directories.
-- 	Has no effect when 'fileignorecase' is set.
-- 	Does not apply when the shell is used to expand wildcards, which
-- 	happens when there are special characters.
vim.o.wildignorecase = "false"
-- string	(Vim default "filnxtToOF", Vi default: "S")
-- 			global
-- 	This option helps to avoid all the |hit-enter| prompts caused by file
-- 	messages, for example  with CTRL-G, and to avoid some other messages.
-- 	It is a list of flags:
-- 	 flag	meaning when present	~
-- 	  f	use "(3 of 5)" instead of "(file 3 of 5)"
-- 	  i	use "[noeol]" instead of "[Incomplete last line]"
-- 	  l	use "999L, 888C" instead of "999 lines, 888 characters"
-- 	  m	use "[+]" instead of "[Modified]"
-- 	  n	use "[New]" instead of "[New File]"
-- 	  r	use "[RO]" instead of "[readonly]"
-- 	  w	use "[w]" instead of "written" for file write message
-- 		and "[a]" instead of "appended" for ':w >> file' command
-- 	  x	use "[dos]" instead of "[dos format]", "[unix]" instead of
-- 		"[unix format]" and "[mac]" instead of "[mac format]".
-- 	  a	all of the above abbreviations
vim.o.shortmess = "filnxtToOF"
-- boolean	(default on)
-- 			global
-- 	Enables "enhanced mode" of command-line completion. When user hits
-- 	<Tab> (or 'wildchar') to invoke completion, the possible matches are
-- 	shown in a menu just above the command-line (see 'wildoptions'), with
-- 	the first match highlighted (overwriting the statusline).  Keys that
-- 	show the previous/next match (<Tab>/CTRL-P/CTRL-N) highlight the
-- 	match.
-- 	'wildmode' must specify "full": "longest" and "list" do not start
-- 	'wildmenu' mode. You can check the current mode with |wildmenumode()|.
-- 	The menu is canceled when a key is hit that is not used for selecting
-- 	a completion.
vim.o.wildmenu = "true"
-- string	(default: "menu,preview")
-- 			global
-- 	A comma separated list of options for Insert mode completion
-- 	|ins-completion|.  The supported values are:
vim.o.completeopt = "menu,preview"
-- string	(default "")
-- 			global
-- 	String to put at the start of lines that have been wrapped.  Useful
-- 	values are "> " or "+++ ": >
-- 		:set showbreak=>\
-- <	Note the backslash to escape the trailing space.  It's easier like
-- 	this: >
-- 		:let &showbreak = '+++ '
-- <	Only printable single-cell characters are allowed, excluding <Tab> and
-- 	comma (in a future version the comma might be used to separate the
-- 	part that is shown at the end and at the start of a line).
-- 	The |hl-NonText| highlight group determines the highlighting.
-- 	Note that tabs after the showbreak will be displayed differently.
-- 	If you want the 'showbreak' to appear in between line numbers, add the
-- 	"n" flag to 'cpoptions'.
vim.o.showbreak = ""
-- boolean	(default off)
-- 			global
-- 	When on, ":autocmd", shell and write commands are not allowed in
-- 	".nvimrc" and ".exrc" in the current directory and map commands are
-- 	displayed.  Switch it off only if you know that you will not run into
-- 	problems, or when the 'exrc' option is off.  On Unix this option is
-- 	only used if the ".nvimrc" or ".exrc" is not owned by you.  This can be
-- 	dangerous if the systems allows users to do a "chown".  You better set
-- 	'secure' at the end of your |init.vim| then.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.secure = "false"
-- string	(default: "")
-- 			local to buffer
-- 			{only for MS-Windows}
-- 	When this option is set it overrules 'shellslash' for completion:
-- 	- When this option is set to "slash", a forward slash is used for path
-- 	  completion in insert mode. This is useful when editing HTML tag, or
-- 	  Makefile with 'noshellslash' on Windows.
-- 	- When this option is set to "backslash", backslash is used. This is
-- 	  useful when editing a batch file with 'shellslash' set on Windows.
-- 	- When this option is empty, same character is used as for
-- 	  'shellslash'.
-- 	For Insert mode completion the buffer-local value is used.  For
-- 	command line completion the global value is used.
vim.o.completeslash = ""
-- string	(default "pum,tagfile")
-- 			global
-- 	List of words that change how |cmdline-completion| is done.
-- 	  pum		Display the completion matches using the popupmenu
-- 			in the same style as the |ins-completion-menu|.
-- 	  tagfile	When using CTRL-D to list matching tags, the kind of
-- 			tag and the file of the tag is listed.	Only one match
-- 			is displayed per line.  Often used tag kinds are:
-- 				d	#define
-- 				f	function
vim.o.wildoptions = "pum,tagfile"
-- boolean (default off)
-- 			global
-- 	When 'confirm' is on, certain operations that would normally
-- 	fail because of unsaved changes to a buffer, e.g. ":q" and ":e",
-- 	instead raise a dialog asking if you wish to save the current
-- 	file(s).  You can still use a ! to unconditionally |abandon| a buffer.
-- 	If 'confirm' is off you can still activate confirmation for one
-- 	command only (this is most useful in mappings) with the |:confirm|
-- 	command.
-- 	Also see the |confirm()| function and the 'v' flag in 'guioptions'.
vim.o.confirm = "false"
-- string	(default "ver,jump")
-- 			global
-- 	This is a comma-separated list of words that specifies how
-- 	'scrollbind' windows should behave.  'sbo' stands for ScrollBind
-- 	Options.
-- 	The following words are available:
-- 	    ver		Bind vertical scrolling for 'scrollbind' windows
-- 	    hor		Bind horizontal scrolling for 'scrollbind' windows
-- 	    jump	Applies to the offset between two windows for vertical
-- 			scrolling.  This offset is the difference in the first
-- 			displayed line of the bound windows.  When moving
-- 			around in a window, another 'scrollbind' window may
-- 			reach a position before the start or after the end of
-- 			the buffer.  The offset is not changed though, when
-- 			moving back the 'scrollbind' window will try to scroll
-- 			to the desired position when possible.
-- 			When now making that window the current one, two
-- 			things can be done with the relative offset:
-- 			1. When "jump" is not included, the relative offset is
-- 			   adjusted for the scroll position in the new current
-- 			   window.  When going back to the other window, the
-- 			   new relative offset will be used.
-- 			2. When "jump" is included, the other windows are
-- 			   scrolled to keep the same relative offset.  When
-- 			   going back to the other window, it still uses the
-- 			   same relative offset.
-- 	Also see |scroll-binding|.
-- 	When 'diff' mode is active there always is vertical scroll binding,
-- 	even when "ver" isn't there.
vim.o.scrollopt = "ver,jump"
-- boolean	(default off)
-- 			global
-- 	When a bracket is inserted, briefly jump to the matching one.  The
-- 	jump is only done if the match can be seen on the screen.  The time to
-- 	show the match can be set with 'matchtime'.
-- 	A Beep is given if there is no match (no matter if the match can be
-- 	seen or not).
-- 	This option is reset when 'paste' is set and restored when 'paste' is
-- 	reset.
-- 	When the 'm' flag is not included in 'cpoptions', typing a character
-- 	will immediately move the cursor back to where it belongs.
-- 	See the "sm" field in 'guicursor' for setting the cursor shape and
-- 	blinking when showing the match.
-- 	The 'matchpairs' option can be used to specify the characters to show
-- 	matches for.  'rightleft' and 'revins' are used to look for opposite
-- 	matches.
-- 	Also see the matchparen plugin for highlighting the match when moving
-- 	around |pi_paren.txt|.
-- 	Note: Use of the short form is rated PG.
vim.o.showmatch = "false"
-- number	(default 0)
-- 			global or local to window |global-local|
-- 	Minimal number of screen lines to keep above and below the cursor.
-- 	This will make some context visible around where you are working.  If
-- 	you set it to a very large value (999) the cursor line will always be
-- 	in the middle of the window (except at the start or end of the file or
-- 	when long lines wrap).
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal scrolloff<
-- 		setlocal scrolloff=-1
-- <	For scrolling horizontally see 'sidescrolloff'.
vim.o.scrolloff = "0"
-- string	(Vim default: "aABceFs_",
-- 				 Vi default: all flags)
-- 			global
-- 	A sequence of single character flags.  When a character is present
-- 	this indicates Vi-compatible behavior.  This is used for things where
-- 	not being Vi-compatible is mostly or sometimes preferred.
-- 	'cpoptions' stands for "compatible-options".
-- 	Commas can be added for readability.
-- 	To avoid problems with flags that are added in the future, use the
-- 	"+=" and "-=" feature of ":set" |add-option-flags|.
vim.o.cpoptions = "aABceFs_"
-- number	(default 50)
-- 			global
-- 	Time in milliseconds to wait for a key code sequence to complete. Also
-- 	used for CTRL-\ CTRL-N and CTRL-\ CTRL-G when part of a command has
-- 	been typed.
vim.o.ttimeoutlen = "50"
-- number	(default 1)
-- 			global
-- 	The value of this option specifies when the line with tab page labels
-- 	will be displayed:
-- 		0: never
-- 		1: only if there are at least two tab pages
-- 		2: always
-- 	This is both for the GUI and non-GUI implementation of the tab pages
-- 	line.
-- 	See |tab-page| for more information about tab pages.
vim.o.showtabline = "1"
-- number	(default 0)
-- 			global
-- 	Determines how many components of the path to show in a list of tags.
-- 	See |cscopepathcomp|.
vim.o.cscopepathcomp = "0"
-- number	(default 1)
-- 			global
-- 	The minimal number of columns to scroll horizontally.  Used only when
-- 	the 'wrap' option is off and the cursor is moved off of the screen.
-- 	When it is zero the cursor will be put in the middle of the screen.
-- 	When using a slow terminal set it to a large number or 0.  Not used
-- 	for "zh" and "zl" commands.
vim.o.sidescroll = "1"
-- string	(default "cscope")
-- 			global
-- 	Specifies the command to execute cscope.  See |cscopeprg|.
-- 	This option cannot be set from a |modeline| or in the |sandbox|, for
-- 	security reasons.
vim.o.cscopeprg = "cscope"
-- number (default 0)
-- 			global or local to window |global-local|
-- 	The minimal number of screen columns to keep to the left and to the
-- 	right of the cursor if 'nowrap' is set.  Setting this option to a
-- 	value greater than 0 while having |'sidescroll'| also at a non-zero
-- 	value makes some context visible in the line you are scrolling in
-- 	horizontally (except at beginning of the line).  Setting this option
-- 	to a large value (like 999) has the effect of keeping the cursor
-- 	horizontally centered in the window, as long as one does not come too
-- 	close to the beginning of the line.
-- 	After using the local value, go back the global value with one of
-- 	these two: >
-- 		setlocal sidescrolloff<
-- 		setlocal sidescrolloff=-1
-- <
-- 	Example: Try this together with 'sidescroll' and 'listchars' as
-- 		 in the following example to never allow the cursor to move
-- 		 onto the "extends" character: >
vim.o.sidescrolloff = "0"
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	If in Insert, Replace or Visual mode put a message on the last line.
-- 	The |hl-ModeMsg| highlight group determines the highlighting.
vim.o.showmode = "true"
-- string	(default "")
-- 			global
-- 	Specifies whether to use quickfix window to show cscope results.
-- 	See |cscopequickfix|.
vim.o.cscopequickfix = ""
-- boolean	(Vim default: on, Vi default: off)
-- 			global
-- 	If on and using a tags file in another directory, file names in that
-- 	tags file are relative to the directory where the tags file is.
vim.o.tagrelative = "true"
-- boolean (default off)
-- 			global
-- 	In the absence of a prefix (-P) for cscope. setting this option enables
-- 	to use the basename of cscope.out path as the prefix.
-- 	See |cscoperelative|.
vim.o.cscoperelative = "false"
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
-- boolean (default off)
-- 			global
-- 	Use cscope for tag commands.  See |cscope-options|.
vim.o.cscopetag = "false"
-- boolean (default off)
-- 			global
-- 	Enables 24-bit RGB color in the |TUI|.  Uses "gui" |:highlight|
-- 	attributes instead of "cterm" attributes. |highlight-guifg|
-- 	Requires an ISO-8613-3 compatible terminal.
vim.o.termguicolors = "false"
-- number	(default 0)
-- 			global
-- 	Determines the order in which ":cstag" performs a search.  See
-- 	|cscopetagorder|.
vim.o.cscopetagorder = "0"
vim.o.termpastefilter = "BS,HT,ESC,DEL"
-- boolean (default off)
-- 			global
-- 			{not available when compiled without the |+cscope|
-- 			feature}
-- 	Give messages when adding a cscope database.  See |cscopeverbose|.
-- 	NOTE: This option is reset when 'compatible' is set.
vim.o.cscopeverbose = "true"
-- string	(default "")
-- 			global
-- 	This option is a list of comma separated names.
-- 	These names are recognized:
vim.o.clipboard = ""
-- number	(default 0)
-- 			global
-- 	If non-zero, tags are significant up to this number of characters.
vim.o.taglength = "0"
-- boolean	(default off)
-- 			global
-- 	When set: Add 's' flag to 'shortmess' option (this makes the message
-- 	for a search that hits the start or end of the file not being
-- 	displayed).  When reset: Remove 's' flag from 'shortmess' option.
vim.o.terse = "false"
-- boolean	(default on)			*E384* *E385*
-- 			global
-- 	Searches wrap around the end of the file.  Also applies to |]s| and
-- 	|[s|, searching for spelling mistakes.
vim.o.wrapscan = "true"
-- boolean	(default off)
-- 			global
-- 	When on: The tilde command "~" behaves like an operator.
vim.o.tildeop = "false"
-- boolean	(default off)
-- 			global
-- 	Allows writing to any file with no need for "!" override.
vim.o.writeany = "false"
-- boolean	(default off)
-- 			global
-- 	Makes Vim work in a way that Insert mode is the default mode.  Useful
-- 	if you want to use Vim as a modeless editor.
-- 	These Insert mode commands will be useful:
-- 	- Use the cursor keys to move around.
-- 	- Use CTRL-O to execute one Normal mode command |i_CTRL-O|.  When
-- 	  this is a mapping, it is executed as if 'insertmode' was off.
-- 	  Normal mode remains active until the mapping is finished.
-- 	- Use CTRL-L to execute a number of Normal mode commands, then use
-- 	  <Esc> to get back to Insert mode.  Note that CTRL-L moves the cursor
-- 	  left, like <Esc> does when 'insertmode' isn't set.  |i_CTRL-L|
vim.o.insertmode = "false"
-- boolean	(default on with |+writebackup| feature, off
-- 					otherwise)
-- 			global
-- 	Make a backup before overwriting a file.  The backup is removed after
-- 	the file was successfully written, unless the 'backup' option is
-- 	also on.
-- 	WARNING: Switching this option off means that when Vim fails to write
-- 	your buffer correctly and then, for whatever reason, Vim exits, you
-- 	lose both the original file and what you were writing.  Only reset
-- 	this option if your file system is almost full and it makes the write
-- 	fail (and make sure not to exit Vim until the write was successful).
-- 	See |backup-table| for another explanation.
-- 	When the 'backupskip' pattern matches, a backup is not made anyway.
vim.o.writebackup = "true"
-- string	(default "")
-- 			global
-- 	When this option is not empty, it will be used for the icon text of
-- 	the window.  This happens only when the 'icon' option is on.
-- 	Only works if the terminal supports setting window icon text
-- 	When this option contains printf-style '%' items, they will be
-- 	expanded according to the rules used for 'statusline'.  See
-- 	'titlestring' for example settings.
-- 	This option cannot be set in a modeline when 'modelineexpr' is off.
vim.o.iconstring = ""
