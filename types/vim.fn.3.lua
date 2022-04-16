--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Return the reference count of {expr}.  When {expr} is of a
-- 		type that does not have a reference count, returns -1.  Only
-- 		to be used for testing.
--
-- 		Can also be used as a |method|: >
-- 			GetVarname()->test_refcount()
--- @return number
function vim.fn.test_refcount(expr) end

-- Pretend using scrollbar {which} to move it to position
-- 		{value}.  {which} can be:
-- 			left	Left scrollbar of the current window
-- 			right	Right scrollbar of the current window
-- 			hor	Horizontal scrollbar
--
-- 		For the vertical scrollbars {value} can be 1 to the
-- 		line-count of the buffer.  For the horizontal scrollbar the
-- 		{value} can be between 1 and the maximum line length, assuming
-- 		'wrap' is not set.
--
-- 		When {dragging} is non-zero it's like dragging the scrollbar,
-- 		otherwise it's like clicking in the scrollbar.
-- 		Only works when the {which} scrollbar actually exists,
-- 		obviously only when using the GUI.
--
-- 		Can also be used as a |method|: >
-- 			GetValue()->test_scrollbar('right', 0)
--- @return none
function vim.fn.test_scrollbar(which, value, dragging) end

-- The result is a String, which is the {what} attribute of
-- 		syntax ID {synID}.  This can be used to obtain information
-- 		about a syntax item.
-- 		{mode} can be "gui", "cterm" or "term", to get the attributes
-- 		for that mode.  When {mode} is omitted, or an invalid value is
-- 		used, the attributes for the currently active highlighting are
-- 		used (GUI, cterm or term).
-- 		Use synIDtrans() to follow linked highlight groups.
-- 		{what}		result
-- 		"name"		the name of the syntax item
-- 		"fg"		foreground color (GUI: color name used to set
-- 				the color, cterm: color number as a string,
-- 				term: empty string)
-- 		"bg"		background color (as with "fg")
-- 		"font"		font name (only available in the GUI)
-- 				|highlight-font|
-- 		"sp"		special color (as with "fg") |highlight-guisp|
-- 		"fg#"		like "fg", but for the GUI and the GUI is
-- 				running the name in "#RRGGBB" form
-- 		"bg#"		like "fg#" for "bg"
-- 		"sp#"		like "fg#" for "sp"
-- 		"bold"		"1" if bold
-- 		"italic"	"1" if italic
-- 		"reverse"	"1" if reverse
-- 		"inverse"	"1" if inverse (= reverse)
-- 		"standout"	"1" if standout
-- 		"underline"	"1" if underlined
-- 		"undercurl"	"1" if undercurled
-- 		"strikethrough"	"1" if struckthrough
--
-- 		Example (echoes the color of the syntax item under the
-- 		cursor): >
-- 	:echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
--- @return string
function vim.fn.synIDattr(synID, what, mode) end

-- Set the mouse position to be used for the next mouse action.
-- 		{row} and {col} are one based.
-- 		For example: >
-- 			call test_setmouse(4, 20)
-- 			call feedkeys("\<LeftMouse>", "xt")
--- @return none
function vim.fn.test_setmouse(row, col) end

-- with name {name}.  When the highlight group doesn't exist,
-- 		zero is returned.
-- 		This can be used to retrieve information about the highlight
-- 		group.  For example, to get the background color of the
-- 		"Comment" group: >
-- 	:echo synIDattr(synIDtrans(hlID("Comment")), "bg")
--- @return number
function vim.fn.hlID(name) end

-- The result is a Number, which is the translated syntax ID of
-- 		{synID}.  This is the syntax group ID of what is being used to
-- 		highlight the character.  Highlight links given with
-- 		":highlight link" are followed.
--- @return number
function vim.fn.synIDtrans(synID) end

-- Return the number of times an item with value {expr} appears
-- 		in |String|, |List| or |Dictionary| {comp}.
--
-- 		If {start} is given then start with the item with this index.
-- 		{start} can only be used with a |List|.
--
-- 		When {ic} is given and it's |TRUE| then case is ignored.
--
-- 		When {comp} is a string then the number of not overlapping
-- 		occurrences of {expr} is returned. Zero is returned when
-- 		{expr} is an empty string.
--- @param list any[]
--- @return number
function vim.fn.count(list, expr, ic, start) end

-- Like `execute()` but in the context of window {id}.
-- 		The window will temporarily be made the current window,
-- 		without triggering autocommands.  When executing {command}
-- 		autocommands will be triggered, this may have unexpected side
-- 		effects.  Use |:noautocmd| if needed.
-- 		Example: >
-- 			call win_execute(winid, 'set syntax=python')
-- <		Doing the same with `setwinvar()` would not trigger
-- 		autocommands and not actually show syntax highlighting.
-- 							*E994*
-- 		Not all commands are allowed in popup windows.
-- 		When window {id} does not exist then no error is given.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetCommand()->win_execute(winid)
--- @return string
function vim.fn.win_execute(id, command, silent) end

-- Move the window {nr} to a new split of the window {target}.
-- 		This is similar to moving to {target}, creating a new window
-- 		using |:split| but having the same contents as window {nr}, and
-- 		then closing {nr}.
--
-- 		Both {nr} and {target} can be window numbers or |window-ID|s.
--
-- 		Returns zero for success, non-zero for failure.
--
-- 		{options} is a Dictionary with the following optional entries:
-- 		  "vertical"	When TRUE, the split is created vertically,
-- 				like with |:vsplit|.
-- 		  "rightbelow"	When TRUE, the split is made below or to the
-- 				right (if vertical).  When FALSE, it is done
-- 				above or to the left (if vertical).  When not
-- 				present, the values of 'splitbelow' and
-- 				'splitright' are used.
--
-- 		Can also be used as a |method|: >
-- 			GetWinid()->win_splitmove(target)
-- <
--- @return number
function vim.fn.win_splitmove(nr, target, options) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @return number
function vim.fn.empty(expr) end

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

-- {expr1} must be a |List| or a |Dictionary|.
-- 		For each item in {expr1} evaluate {expr2} and when the result
-- 		is zero remove the item from the |List| or |Dictionary|.
-- 		{expr2} must be a |string| or |Funcref|.
--
-- 		If {expr2} is a |string|, inside {expr2} |v:val| has the value
-- 		of the current item.  For a |Dictionary| |v:key| has the key
-- 		of the current item and for a |List| |v:key| has the index of
-- 		the current item.
-- 		For a |Dictionary| |v:key| has the key of the current item.
-- 		Examples: >
-- 			call filter(mylist, 'v:val !~ "OLD"')
-- <		Removes the items where "OLD" appears. >
-- 			call filter(mydict, 'v:key >= 8')
-- <		Removes the items with a key below 8. >
-- 			call filter(var, 0)
-- <		Removes all the items, thus clears the |List| or |Dictionary|.
--
-- 		Note that {expr2} is the result of expression and is then
-- 		used as an expression again.  Often it is good to use a
-- 		|literal-string| to avoid having to double backslashes.
--
-- 		If {expr2} is a |Funcref| it must take two arguments:
-- 			1. the key or the index of the current item.
-- 			2. the value of the current item.
-- 		The function must return |TRUE| if the item should be kept.
-- 		Example that keeps the odd items of a list: >
-- 			func Odd(idx, val)
-- 			  return a:idx % 2 == 1
-- 			endfunc
-- 			call filter(mylist, function('Odd'))
-- <		It is shorter when using a |lambda|: >
-- 			call filter(myList, {idx, val -> idx * val <= 42})
-- <		If you do not use "val" you can leave it out: >
-- 			call filter(myList, {idx -> idx % 2 == 1})
-- <
-- 		The operation is done in-place.  If you want a |List| or
-- 		|Dictionary| to remain unmodified make a copy first: >
-- 			:let l = filter(copy(mylist), 'v:val =~ "KEEP"')
--
-- <		Returns {expr1}, the |List| or |Dictionary| that was filtered.
-- 		When an error is encountered while evaluating {expr2} no
-- 		further items in {expr1} are processed. When {expr2} is a
-- 		Funcref errors inside a function are ignored, unless it was
-- 		defined with the "abort" flag.
--- @return list/dict
function vim.fn.filter(expr1, expr2) end

-- The result is a Number, which is |TRUE| when a file with the
-- 		name {file} exists, and can be read.  If {file} doesn't exist,
-- 		or is a directory, the result is |FALSE|.  {file} is any
-- 		expression, which is used as a String.
-- 		If you don't care about the file being readable you can use
-- 		|glob()|.
--- @return number
function vim.fn.filereadable(file) end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of bytes in the cursor line plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Additionally {expr} can be [lnum, col]: a |List| with the line
-- 		and column number. Most useful when the column is "$", to get
-- 		the last column of a specific line.  When "lnum" or "col" is
-- 		out of range then col() returns zero.
-- 		To get the line number use |line()|.  To get both use
-- 		|getpos()|.
-- 		For the screen column position use |virtcol()|.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
-- 			col(".")		column of cursor
-- 			col("$")		length of cursor line plus one
-- 			col("'t")		column of mark t
-- 			col("'" . markname)	column of mark markname
-- <		The first column is 1.  0 is returned for an error.
-- 		For an uppercase mark the column may actually be in another
-- 		buffer.
-- 		For the cursor position, when 'virtualedit' is active, the
-- 		column is one higher if the cursor is after the end of the
-- 		line.  This can be used to obtain the column in Insert mode: >
-- 			:imap <F2> <C-O>:let save_ve = &ve<CR>
-- 				\<C-O>:set ve=all<CR>
-- 				\<C-O>:echo col(".") . "\n" <Bar>
-- 				\let &ve = save_ve<CR>
-- <
--- @return number
function vim.fn.col(expr) end

-- Write |List| {list} to file {fname}.  Each list item is
-- 		separated with a NL.  Each list item must be a String or
-- 		Number.
-- 		When {flags} contains "b" then binary mode is used: There will
-- 		not be a NL after the last list item.  An empty item at the
-- 		end does cause the last line in the file to end in a NL.
--
-- 		When {flags} contains "a" then append mode is used, lines are
-- 		appended to the file: >
-- 			:call writefile(["foo"], "event.log", "a")
-- 			:call writefile(["bar"], "event.log", "a")
-- <
-- 		When {flags} contains "S" fsync() call is not used, with "s"
-- 		it is used, 'fsync' option applies by default. No fsync()
-- 		means that writefile() will finish faster, but writes may be
-- 		left in OS buffers and not yet written to disk. Such changes
-- 		will disappear if system crashes before OS does writing.
--
-- 		All NL characters are replaced with a NUL character.
-- 		Inserting CR characters needs to be done before passing {list}
-- 		to writefile().
-- 		An existing file is overwritten, if possible.
-- 		When the write fails -1 is returned, otherwise 0.  There is an
-- 		error message if the file can't be created or when writing
-- 		fails.
-- 		Also see |readfile()|.
-- 		To copy a file byte for byte: >
-- 			:let fl = readfile("foo", "b")
-- 			:call writefile(fl, "foocopy", "b")
--- @param list any[]
--- @return number
function vim.fn.writefile(list, fname, flags) end

-- Defines a pattern to be highlighted in the current window (a
-- 		"match").  It will be highlighted with {group}.  Returns an
-- 		identification number (ID), which can be used to delete the
-- 		match using |matchdelete()|.
-- 		Matching is case sensitive and magic, unless case sensitivity
-- 		or magicness are explicitly overridden in {pattern}.  The
-- 		'magic', 'smartcase' and 'ignorecase' options are not used.
-- 		The "Conceal" value is special, it causes the match to be
-- 		concealed.
--
-- 		The optional {priority} argument assigns a priority to the
-- 		match.  A match with a high priority will have its
-- 		highlighting overrule that of a match with a lower priority.
-- 		A priority is specified as an integer (negative numbers are no
-- 		exception).  If the {priority} argument is not specified, the
-- 		default priority is 10.  The priority of 'hlsearch' is zero,
-- 		hence all matches with a priority greater than zero will
-- 		overrule it.  Syntax highlighting (see 'syntax') is a separate
-- 		mechanism, and regardless of the chosen priority a match will
-- 		always overrule syntax highlighting.
--
-- 		The optional {id} argument allows the request for a specific
-- 		match ID.  If a specified ID is already taken, an error
-- 		message will appear and the match will not be added.  An ID
-- 		is specified as a positive integer (zero excluded).  IDs 1, 2
-- 		and 3 are reserved for |:match|, |:2match| and |:3match|,
-- 		respectively.  If the {id} argument is not specified or -1,
-- 		|matchadd()| automatically chooses a free ID.
--
-- 		The optional {dict} argument allows for further custom
-- 		values. Currently this is used to specify a match specific
-- 		conceal character that will be shown for |hl-Conceal|
-- 		highlighted matches. The dict can have the following members:
--
-- 			conceal	    Special character to show instead of the
-- 				    match (only for |hl-Conceal| highlighed
-- 				    matches, see |:syn-cchar|)
-- 			window	    Instead of the current window use the
-- 				    window with this number or window ID.
--
-- 		The number of matches is not limited, as it is the case with
-- 		the |:match| commands.
--
-- 		Example: >
-- 			:highlight MyGroup ctermbg=green guibg=green
-- 			:let m = matchadd("MyGroup", "TODO")
-- <		Deletion of the pattern: >
-- 			:call matchdelete(m)
--
-- <		A list of matches defined by |matchadd()| and |:match| are
-- 		available from |getmatches()|.  All matches can be deleted in
-- 		one operation by |clearmatches()|.
--- @return number
function vim.fn.matchadd(group, pattern, priority, id) end

-- Return an item that represents a time value.  The format of
-- 		the item depends on the system.  It can be passed to
-- 		|reltimestr()| to convert it to a string or |reltimefloat()|
-- 		to convert to a float.
--
-- 		Without an argument it returns the current "relative time", an
-- 		implementation-defined value meaningful only when used as an
-- 		argument to |reltime()|, |reltimestr()| and |reltimefloat()|.
--
-- 		With one argument it returns the time passed since the time
-- 		specified in the argument.
-- 		With two arguments it returns the time passed between {start}
-- 		and {end}.
-- 		The {start} and {end} arguments must be values returned by
-- 		reltime().
--
-- 		Note: |localtime()| returns the current (non-relative) time.
--- @return list
function vim.fn.reltime(start, _end) end

-- Without argument: The result is the badly spelled word under
-- 		or after the cursor.  The cursor is moved to the start of the
-- 		bad word.  When no bad word is found in the cursor line the
-- 		result is an empty string and the cursor doesn't move.
--
-- 		With argument: The result is the first word in {sentence} that
-- 		is badly spelled.  If there are no spelling mistakes the
-- 		result is an empty string.
--
-- 		The return value is a list with two items:
-- 		- The badly spelled word or an empty string.
-- 		- The type of the spelling error:
-- 			"bad"		spelling mistake
-- 			"rare"		rare word
-- 			"local"		word only valid in another region
-- 			"caps"		word should start with Capital
-- 		Example: >
-- 			echo spellbadword("the quik brown fox")
-- <			['quik', 'bad'] ~
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the value of 'spelllang' is
-- 		used.
--- @return string
function vim.fn.spellbadword() end

-- Convert string {expr} to a number.
-- 		{base} is the conversion base, it can be 2, 8, 10 or 16.
-- 		When {base} is omitted base 10 is used.  This also means that
-- 		a leading zero doesn't cause octal conversion to be used, as
-- 		with the default String to Number conversion.
-- 		When {base} is 16 a leading "0x" or "0X" is ignored.  With a
-- 		different base the result will be zero. Similarly, when {base}
-- 		is 8 a leading "0" is ignored, and when {base} is 2 a leading
-- 		"0b" or "0B" is ignored.
-- 		Text after the number is silently ignored.
--- @return number
function vim.fn.str2nr(expr, base) end

-- The result is a String, which is a formatted date and time, as
-- 		specified by the {format} string.  The given {time} is used,
-- 		or the current time if no time is given.  The accepted
-- 		{format} depends on your system, thus this is not portable!
-- 		See the manual page of the C function strftime() for the
-- 		format.  The maximum length of the result is 80 characters.
-- 		See also |localtime()| and |getftime()|.
-- 		The language can be changed with the |:language| command.
-- 		Examples: >
-- 		  :echo strftime("%c")		   Sun Apr 27 11:49:23 1997
-- 		  :echo strftime("%Y %b %d %X")	   1997 Apr 27 11:53:25
-- 		  :echo strftime("%y%m%d %T")	   970427 11:53:55
-- 		  :echo strftime("%H:%M")	   11:55
-- 		  :echo strftime("%c", getftime("file.c"))
-- 						   Show mod time of file.c.
-- <		Not available on all systems.  To check use: >
-- 			:if exists("*strftime")
--- @return string
function vim.fn.strftime(format, time) end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
--- @return number
function vim.fn.strlen(expr) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
--- @return number
function vim.fn.strwidth(expr) end

-- Only for an expression in a |:substitute| command or
-- 		substitute() function.
-- 		Returns the {nr}'th submatch of the matched text.  When {nr}
-- 		is 0 the whole matched text is returned.
-- 		Note that a NL in the string can stand for a line break of a
-- 		multi-line match or a NUL character in the text.
-- 		Also see |sub-replace-expression|.
--
-- 		If {list} is present and non-zero then submatch() returns
-- 		a list of strings, similar to |getline()| with two arguments.
-- 		NL characters in the text represent NUL characters in the
-- 		text.
-- 		Only returns more than one item for |:substitute|, inside
-- 		|substitute()| this list will always contain one or zero
-- 		items, since there are no real line breaks.
--
-- 		When substitute() is used recursively only the submatches in
-- 		the current (deepest) call can be obtained.
--
-- 		Examples: >
-- 			:s/\d\+/\=submatch(0) + 1/
-- 			:echo substitute(text, '\d\+', '\=submatch(0) + 1', '')
-- <		This finds the first number in the line and adds one to it.
-- 		A line break is included as a newline character.
--- @param list any[]
--- @return string
function vim.fn.submatch(nr, list) end

-- The result is a |List|, where each item is the number of the
-- 		buffer associated with each window in the current tab page.
-- 		{arg} specifies the number of the tab page to be used. When
-- 		omitted the current tab page is used.
-- 		When {arg} is invalid the number zero is returned.
-- 		To get a list of all buffers in all tabs use this: >
-- 			let buflist = []
-- 			for i in range(tabpagenr('$'))
-- 			   call extend(buflist, tabpagebuflist(i + 1))
-- 			endfor
-- <		Note that a buffer may appear in more than one window.
--- @return list
function vim.fn.tabpagebuflist(arg) end

-- The result is a Number, which is the number of the current
-- 		tab page.  The first tab page has number 1.
-- 		The optional argument {arg} supports the following values:
-- 			$	the number of the last tab page (the tab page
-- 				count).
-- 			#	the number of the last accessed tab page (where
-- 				|g<Tab>| goes to).  If there is no previous
-- 				tab page, 0 is returned.
-- 		The number can be used with the |:tab| command.
--- @return number
function vim.fn.tabpagenr(arg) end

-- Like |winnr()| but for tab page {tabarg}.
-- 		{tabarg} specifies the number of tab page to be used.
-- 		{arg} is used like with |winnr()|:
-- 		- When omitted the current window number is returned.  This is
-- 		  the window which will be used when going to this tab page.
-- 		- When "$" the number of windows is returned.
-- 		- When "#" the previous window nr is returned.
-- 		Useful examples: >
-- 		    tabpagewinnr(1)	    " current window of tab page 1
-- 		    tabpagewinnr(4, '$')    " number of windows in tab page 4
-- <		When {tabarg} is invalid zero is returned.
--- @return number
function vim.fn.tabpagewinnr(tabarg, arg) end

-- Returns a list of tags matching the regular expression {expr}.
--
-- 		If {filename} is passed it is used to prioritize the results
-- 		in the same way that |:tselect| does. See |tag-priority|.
-- 		{filename} should be the full path of the file.
--
-- 		Each list item is a dictionary with at least the following
-- 		entries:
-- 			name		Name of the tag.
-- 			filename	Name of the file where the tag is
-- 					defined.  It is either relative to the
-- 					current directory or a full path.
-- 			cmd		Ex command used to locate the tag in
-- 					the file.
-- 			kind		Type of the tag.  The value for this
-- 					entry depends on the language specific
-- 					kind values.  Only available when
-- 					using a tags file generated by
-- 					Exuberant ctags or hdrtag.
-- 			static		A file specific tag.  Refer to
-- 					|static-tag| for more information.
-- 		More entries may be present, depending on the content of the
-- 		tags file: access, implementation, inherits and signature.
-- 		Refer to the ctags documentation for information about these
-- 		fields.  For C code the fields "struct", "class" and "enum"
-- 		may appear, they give the name of the entity the tag is
-- 		contained in.
--
-- 		The ex-command "cmd" can be either an ex search pattern, a
-- 		line number or a line number followed by a byte number.
--
-- 		If there are no matching tags, then an empty list is returned.
--
-- 		To get an exact tag match, the anchors '^' and '$' should be
-- 		used in {expr}.  This also make the function work faster.
-- 		Refer to |tag-regexp| for more information about the tag
-- 		search regular expression pattern.
--
-- 		Refer to |'tags'| for information about how the tags file is
-- 		located by Vim. Refer to |tags-file-format| for the format of
-- 		the tags file generated by the different ctags tools.
--- @return list
function vim.fn.taglist(expr, filename) end

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- Sends a request to {channel} to invoke {method} via
-- 		|RPC| and blocks until a response is received.
-- 		Example: >
-- 			:let result = rpcrequest(rpc_chan, "func", 1, 2, 3)
--- @return sends
function vim.fn.rpcrequest(channel, method, ...) end

-- Sends {event} to {channel} via |RPC| and returns immediately.
-- 		If {channel} is 0, the event is broadcast to all channels.
-- 		Example: >
-- 			:au VimLeave call rpcnotify(0, "leaving")
--- @return sends
function vim.fn.rpcnotify(channel, event, ...) end

-- Waits until {condition} evaluates to |TRUE|, where {condition}
-- 		is a |Funcref| or |string| containing an expression.
--
-- 		{timeout} is the maximum waiting time in milliseconds, -1
-- 		means forever.
--
-- 		Condition is evaluated on user events, internal events, and
-- 		every {interval} milliseconds (default: 200).
--
-- 		Returns a status integer:
-- 			0 if the condition was satisfied before timeout
-- 			-1 if the timeout was exceeded
-- 			-2 if the function was interrupted (by |CTRL-C|)
-- 			-3 if an error occurred
--- @return number
function vim.fn.wait(timeout, condition, interval) end

-- The result is a String, which is the name of a file that
-- 		doesn't exist.  It can be used for a temporary file.  Example: >
-- 			:let tmpfile = tempname()
-- 			:exe "redir > " . tmpfile
-- <		For Unix, the file will be in a private directory |tempfile|.
-- 		For MS-Windows forward slashes are used when the 'shellslash'
-- 		option is set or when 'shellcmdflag' starts with '-'.
--- @return string
function vim.fn.tempname() end

-- Return a String that represents the time value of {time}.
-- 		This is the number of seconds, a dot and the number of
-- 		microseconds.  Example: >
-- 			let start = reltime()
-- 			call MyFunction()
-- 			echo reltimestr(reltime(start))
-- <		Note that overhead for the commands will be added to the time.
-- 		Leading spaces are used to make the string align nicely.  You
-- 		can use split() to remove it. >
-- 			echo split(reltimestr(reltime(start)))[0]
-- <		Also see |profiling|.
--- @return string
function vim.fn.reltimestr(time) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- Returns a Dictionary with the last known position of the
-- 		mouse.  This can be used in a mapping for a mouse click or in
-- 		a filter of a popup window.  The items are:
-- 			screenrow	screen row
-- 			screencol	screen column
-- 			winid		Window ID of the click
-- 			winrow		row inside "winid"
-- 			wincol		column inside "winid"
-- 			line		text line inside "winid"
-- 			column		text column inside "winid"
-- 		All numbers are 1-based.
--
-- 		If not over a window, e.g. when in the command line, then only
-- 		"screenrow" and "screencol" are valid, the others are zero.
--
-- 		When on the status line below a window or the vertical
-- 		separater right of a window, the "line" and "column" values
-- 		are zero.
--
-- 		When the position is after the text then "column" is the
-- 		length of the text in bytes.
--
-- 		If the mouse is over a popup window then that window is used.
--
--
-- 		When using |getchar()| the Vim variables |v:mouse_lnum|,
-- 		|v:mouse_col| and |v:mouse_winid| also provide these values.
--- @return dict
function vim.fn.getmousepos() end

-- The result is a Number, which is 1 if there is a mapping that
-- 		contains {what} in somewhere in the rhs (what it is mapped to)
-- 		and this mapping exists in one of the modes indicated by
-- 		{mode}.
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.  Don't forget to specify Insert and/or
-- 		Command-line mode.
-- 		Both the global mappings and the mappings local to the current
-- 		buffer are checked for a match.
-- 		If no matching mapping is found 0 is returned.
-- 		The following characters are recognized in {mode}:
-- 			n	Normal mode
-- 			v	Visual mode
-- 			o	Operator-pending mode
-- 			i	Insert mode
-- 			l	Language-Argument ("r", "f", "t", etc.)
-- 			c	Command-line mode
-- 		When {mode} is omitted, "nvo" is used.
--
-- 		This function is useful to check if a mapping already exists
-- 		to a function in a Vim script.  Example: >
-- 			:if !hasmapto('\ABCdoit')
-- 			:   map <Leader>d \ABCdoit
-- 			:endif
-- <		This installs the mapping to "\ABCdoit" only if there isn't
-- 		already a mapping to "\ABCdoit".
--- @return number
function vim.fn.hasmapto(what, mode, abbr) end

-- Check if there is a mapping that matches with {name} in mode
-- 		{mode}.  See |maparg()| for {mode} and special names in
-- 		{name}.
-- 		When {abbr} is there and it is non-zero use abbreviations
-- 		instead of mappings.
-- 		A match happens with a mapping that starts with {name} and
-- 		with a mapping which is equal to the start of {name}.
--
-- 			matches mapping "a"	"ab"	"abc" ~
-- 		   mapcheck("a")	yes	yes	 yes
-- 		   mapcheck("abc")	yes	yes	 yes
-- 		   mapcheck("ax")	yes	no	 no
-- 		   mapcheck("b")	no	no	 no
--
-- 		The difference with maparg() is that mapcheck() finds a
-- 		mapping that matches with {name}, while maparg() only finds a
-- 		mapping for {name} exactly.
-- 		When there is no mapping that starts with {name}, an empty
-- 		String is returned.  If there is one, the RHS of that mapping
-- 		is returned.  If there are several mappings that start with
-- 		{name}, the RHS of one of them is returned.  This will be
-- 		"<Nop>" if the RHS is empty.
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to check if a mapping can be added
-- 		without being ambiguous.  Example: >
-- 	:if mapcheck("_vv") == ""
-- 	:   map _vv :set guifont=7x13<CR>
-- 	:endif
-- <		This avoids adding the "_vv" mapping when there already is a
-- 		mapping for "_v" or for "_vvv".
--- @return string
function vim.fn.mapcheck(name, mode, abbr) end

-- Pause or unpause a timer.  A paused timer does not invoke its
-- 		callback when its time expires.  Unpausing a timer may cause
-- 		the callback to be invoked almost immediately if enough time
-- 		has passed.
--
-- 		Pausing a timer is useful to avoid the callback to be called
-- 		for a short time.
--
-- 		If {paused} evaluates to a non-zero Number or a non-empty
-- 		String, then the timer is paused, otherwise it is unpaused.
-- 		See |non-zero-arg|.
--- @return none
function vim.fn.timer_pause(id, pause) end

-- Get character {index} from {str}.  This uses a character
-- 		index, not a byte index.  Composing characters are considered
-- 		separate characters here.
-- 		Also see |strcharpart()| and |strchars()|.
--- @return number
function vim.fn.strgetchar(str, index) end

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

-- Returns a Dictionary with information about {job}:
-- 		   "status"	what |job_status()| returns
-- 		   "channel"	what |job_getchannel()| returns
-- 		   "cmd"	List of command arguments used to start the job
-- 		   "process"	process ID
-- 		   "tty_in"	terminal input name, empty when none
-- 		   "tty_out"	terminal output name, empty when none
-- 		   "exitval"	only valid when "status" is "dead"
-- 		   "exit_cb"	function to be called on exit
-- 		   "stoponexit"	|job-stoponexit|
--
-- 		   Only in Unix:
-- 		   "termsig"	the signal which terminated the process
-- 				(See |job_stop()| for the values)
-- 				only valid when "status" is "dead"
--
-- 		   Only in MS-Windows:
-- 		   "tty_type"	Type of virtual console in use.
-- 				Values are "winpty" or "conpty".
-- 				See 'termwintype'.
--
-- 		Without any arguments, returns a List with all Job objects.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_info()
--- @return dict
function vim.fn.job_info(job) end

-- The result is a Number.  If the line {lnum} is in a closed
-- 		fold, the result is the number of the last line in that fold.
-- 		If the line {lnum} is not in a closed fold, -1 is returned.
--- @return number
function vim.fn.foldclosedend(lnum) end

-- The result is a copy of the String given, with all uppercase
-- 		characters turned into lowercase (just like applying |gu| to
-- 		the string).
--- @return string
function vim.fn.tolower(expr) end

-- The result is a copy of the String given, with all lowercase
-- 		characters turned into uppercase (just like applying |gU| to
-- 		the string).
--- @return string
function vim.fn.toupper(expr) end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

-- Returns a String with the status of {job}:
-- 			"run"	job is running
-- 			"fail"	job failed to start
-- 			"dead"	job died or was stopped after running
--
-- 		On Unix a non-existing command results in "dead" instead of
-- 		"fail", because a fork happens before the failure can be
-- 		detected.
--
-- 		If an exit callback was set with the "exit_cb" option and the
-- 		job is now detected to be "dead" the callback will be invoked.
--
-- 		For more information see |job_info()|.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_status()
--- @return string
function vim.fn.job_status(job) end

-- Return the largest integral value with magnitude less than or
-- 		equal to {expr} as a |Float| (truncate towards zero).
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			echo trunc(1.456)
-- <			1.0  >
-- 			echo trunc(-5.456)
-- <			-5.0  >
-- 			echo trunc(4.0)
-- <			4.0
--- @return float
function vim.fn.trunc(expr) end

-- Stop the {job}.  This can also be used to signal the job.
--
-- 		When {how} is omitted or is "term" the job will be terminated.
-- 		For Unix SIGTERM is sent.  On MS-Windows the job will be
-- 		terminated forcedly (there is no "gentle" way).
-- 		This goes to the process group, thus children may also be
-- 		affected.
--
-- 		Effect for Unix:
-- 			"term"	 SIGTERM (default)
-- 			"hup"	 SIGHUP
-- 			"quit"	 SIGQUIT
-- 			"int"	 SIGINT
-- 			"kill"	 SIGKILL (strongest way to stop)
-- 			number	 signal with that number
--
-- 		Effect for MS-Windows:
-- 			"term"	 terminate process forcedly (default)
-- 			"hup"	 CTRL_BREAK
-- 			"quit"	 CTRL_BREAK
-- 			"int"	 CTRL_C
-- 			"kill"	 terminate process forcedly
-- 			Others	 CTRL_BREAK
--
-- 		On Unix the signal is sent to the process group.  This means
-- 		that when the job is "sh -c command" it affects both the shell
-- 		and the command.
--
-- 		The result is a Number: 1 if the operation could be executed,
-- 		0 if "how" is not supported on the system.
-- 		Note that even when the operation was executed, whether the
-- 		job was actually stopped needs to be checked with
-- 		|job_status()|.
--
-- 		If the status of the job is "dead", the signal will not be
-- 		sent.  This is to avoid to stop the wrong job (esp. on Unix,
-- 		where process numbers are recycled).
--
-- 		When using "kill" Vim will assume the job will die and close
-- 		the channel.
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_stop()
--- @return number
function vim.fn.job_stop(job, how) end

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
function vim.fn.js_decode(string) end

-- This is similar to |json_encode()| with these differences:
-- 		- Object key names are not in quotes.
-- 		- v:none items in an array result in an empty item between
-- 		  commas.
-- 		For example, the Vim object:
-- 			[1,v:none,{"one":1},v:none] ~
-- 		Will be encoded as:
-- 			[1,,{one:1},,] ~
-- 		While json_encode() would produce:
-- 			[1,null,{"one":1},null] ~
-- 		This encoding is valid for JavaScript. It is more efficient
-- 		than JSON, especially when using an array with optional items.
--
-- 		Can also be used as a |method|: >
-- 			GetObject()->js_encode()
--- @return string
function vim.fn.js_encode(expr) end

-- Add a callback function that will be invoked when changes have
-- 		been made to buffer {buf}.
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
-- 		Returns a unique ID that can be passed to |listener_remove()|.
--
-- 		The {callback} is invoked with five arguments:
-- 		    a:bufnr	the buffer that was changed
-- 		    a:start	first changed line number
-- 		    a:end	first line number below the change
-- 		    a:added	number of lines added, negative if lines were
-- 				deleted
-- 		    a:changes	a List of items with details about the changes
--
-- 		Example: >
-- 	    func Listener(bufnr, start, end, added, changes)
-- 	      echo 'lines ' .. a:start .. ' until ' .. a:end .. ' changed'
-- 	    endfunc
-- 	    call listener_add('Listener', bufnr)
--
-- <		The List cannot be changed.  Each item in a:changes is a
-- 		dictionary with these entries:
-- 		    lnum	the first line number of the change
-- 		    end		the first line below the change
-- 		    added	number of lines added; negative if lines were
-- 				deleted
-- 		    col		first column in "lnum" that was affected by
-- 				the change; one if unknown or the whole line
-- 				was affected; this is a byte index, first
-- 				character has a value of one.
-- 		When lines are inserted the values are:
-- 		    lnum	line above which the new line is added
-- 		    end		equal to "lnum"
-- 		    added	number of lines inserted
-- 		    col		1
-- 		When lines are deleted the values are:
-- 		    lnum	the first deleted line
-- 		    end		the line below the first deleted line, before
-- 				the deletion was done
-- 		    added	negative, number of lines deleted
-- 		    col		1
-- 		When lines are changed:
-- 		    lnum	the first changed line
-- 		    end		the line below the last changed line
-- 		    added	0
-- 		    col		first column with a change or 1
--
-- 		The entries are in the order the changes were made, thus the
-- 		most recent change is at the end.  The line numbers are valid
-- 		when the callback is invoked, but later changes may make them
-- 		invalid, thus keeping a copy for later might not work.
--
-- 		The {callback} is invoked just before the screen is updated,
-- 		when |listener_flush()| is called or when a change is being
-- 		made that changes the line count in a way it causes a line
-- 		number in the list of changes to become invalid.
--
-- 		The {callback} is invoked with the text locked, see
-- 		|textlock|.  If you do need to make changes to the buffer, use
-- 		a timer to do this later |timer_start()|.
--
-- 		The {callback} is not invoked when the buffer is first loaded.
-- 		Use the |BufReadPost| autocmd event to handle the initial text
-- 		of a buffer.
-- 		The {callback} is also not invoked when the buffer is
-- 		unloaded, use the |BufUnload| autocmd event for that.
--
-- 		Can also be used as a |method|, the base is passed as the
-- 		second argument: >
-- 			GetBuffer()->listener_add(callback)
--- @return number
function vim.fn.listener_add(callback, buf) end

-- Invoke listener callbacks for buffer {buf}.  If there are no
-- 		pending changes then no callbacks are invoked.
--
-- 		{buf} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.  When {buf} is omitted the current
-- 		buffer is used.
--
-- 		Can also be used as a |method|: >
-- 			GetBuffer()->listener_flush()
--- @return none
function vim.fn.listener_flush(buf) end

-- Returns |TRUE| when the wildmenu is active and |FALSE|
-- 		otherwise.  See 'wildmenu' and 'wildmode'.
-- 		This can be used in mappings to handle the 'wildcharm' option
-- 		gracefully. (Makes only sense with |mapmode-c| mappings).
--
-- 		For example to make <c-j> work like <down> in wildmode, use: >
--     :cnoremap <expr> <C-j> wildmenumode() ? "\<Down>\<Tab>" : "\<c-j>"
-- <
-- 		(Note, this needs the 'wildcharm' option set appropriately).
--- @return number
function vim.fn.wildmenumode() end

-- Remove a listener previously added with listener_add().
-- 		Returns zero when {id} could not be found, one when {id} was
-- 		removed.
--
-- 		Can also be used as a |method|: >
-- 			GetListenerId()->listener_remove()
--- @return none
function vim.fn.listener_remove(id) end

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @return list
function vim.fn.win_findbuf(bufnr) end

-- Evaluate MzScheme expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are.
-- 		Pairs (including lists and improper lists) and vectors are
-- 		returned as Vim |Lists|.
-- 		Hash tables are represented as Vim |Dictionary| type with keys
-- 		converted to strings.
-- 		All other types are converted to string with display function.
-- 		Examples: >
-- 		    :mz (define l (list 1 2 3))
-- 		    :mz (define h (make-hash)) (hash-set! h "list" l)
-- 		    :echo mzeval("l")
-- 		    :echo mzeval("h")
-- <
-- 		Can also be used as a |method|: >
-- 			GetExpr()->mzeval()
-- <
-- 		{only available when compiled with the |+mzscheme| feature}
function vim.fn.mzeval(expr) end

-- Evaluate Perl expression {expr} in scalar context and return
-- 		its result converted to Vim data structures. If value can't be
-- 		converted, it is returned as a string Perl representation.
-- 		Note: If you want an array or hash, {expr} must return a
-- 		reference to it.
-- 		Example: >
-- 			:echo perleval('[1 .. 4]')
-- <			[1, 2, 3, 4]
--
-- 		Can also be used as a |method|: >
-- 			GetExpr()->perleval()
--
-- <		{only available when compiled with the |+perl| feature}
--
--
-- popup_ functions are documented here: |popup-functions|.
function vim.fn.perleval(expr) end

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @return list
function vim.fn.win_id2tabwin(expr) end

-- Show the {what} above the cursor, and close it when the cursor
-- 		moves.  This works like: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'botleft',
-- 				\ line: 'cursor-1',
-- 				\ col: 'cursor',
-- 				\ moved: 'WORD',
-- 				\ })
-- <		Use {options} to change the properties.
-- 		If "pos" is passed as "topleft" then the default for "line"
-- 		becomes "cursor+1".
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_atcursor({})
--- @return number
function vim.fn.popup_atcursor(what, options) end

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

-- Show the {what} above the position from 'ballooneval' and
-- 		close it when the mouse moves.  This works like: >
-- 		  let pos = screenpos(v:beval_winnr, v:beval_lnum, v:beval_col)
-- 		  call popup_create({what}, #{
-- 			\ pos: 'botleft',
-- 			\ line: pos.row - 1,
-- 			\ col: pos.col,
-- 			\ mousemoved: 'WORD',
-- 			\ })
-- <		Use {options} to change the properties.
-- 		See |popup_beval_example| for an example.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_beval({})
-- <
--- @return number
function vim.fn.popup_beval(what, options) end

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- windows for the current tab and global popups.
--- @return none
function vim.fn.popup_clear() end

-- associated with window {nr}.  {nr} can be the window number or
-- 		the |window-ID|.
-- 		When {nr} is zero, the number of the buffer in the current
-- 		window is returned.
-- 		When window {nr} doesn't exist, -1 is returned.
-- 		Example: >
--   :echo "The file in the current window is " . bufname(winbufnr(0))
-- <
--- @return number
function vim.fn.winbufnr(nr) end

-- Close popup {id}.  The window and the associated buffer will
-- 		be deleted.
--
-- 		If the popup has a callback it will be called just before the
-- 		popup window is deleted.  If the optional {result} is present
-- 		it will be passed as the second argument of the callback.
-- 		Otherwise zero is passed to the callback.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_close()
--- @return none
function vim.fn.popup_close(id, result) end

-- Open a popup window showing {what}, which is either:
-- 		- a buffer number
-- 		- a string
-- 		- a list of strings
-- 		- a list of text lines with text properties
-- 		When {what} is not a buffer number, a buffer is created with
-- 		'buftype' set to "popup".  That buffer will be wiped out once
-- 		the popup closes.
--
-- 		{options} is a dictionary with many possible entries.
-- 		See |popup_create-arguments| for details.
--
-- 		Returns a window-ID, which can be used with other popup
-- 		functions.  Use `winbufnr()` to get the number of the buffer
-- 		in the window: >
-- 			let winid = popup_create('hello', {})
-- 			let bufnr = winbufnr(winid)
-- 			call setbufline(bufnr, 2, 'second line')
-- <		In case of failure zero is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_create({})
--- @return number
function vim.fn.popup_create(what, options) end

-- Just like |popup_create()| but with these default options: >
-- 			call popup_create({what}, #{
-- 				\ pos: 'center',
-- 				\ zindex: 200,
-- 				\ drag: 1,
-- 				\ border: [],
-- 				\ padding: [],
-- 				\ mapping: 0,
-- 				\})
-- <		Use {options} to change the properties. E.g. add a 'filter'
-- 		option with value 'popup_filter_yesno'.  Example: >
-- 			call popup_create('do you want to quit (Yes/no)?', #{
-- 				\ filter: 'popup_filter_yesno',
-- 				\ callback: 'QuitCallback',
-- 				\ })
--
-- <		By default the dialog can be dragged, so that text below it
-- 		can be read if needed.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->popup_dialog({})
--- @return number
function vim.fn.popup_dialog(what, options) end

-- the current window sizes.  Only works properly when no windows
-- 		are opened or closed and the current window and tab page is
-- 		unchanged.
-- 		Example: >
-- 			:let cmd = winrestcmd()
-- 			:call MessWithWindowSizes()
-- 			:exe cmd
-- <
--- @return string
function vim.fn.winrestcmd() end

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

-- Get the |window-ID| for the popup info window, as it used by
-- 		the popup menu.  See |complete-popup|.  The info popup is
-- 		hidden when not used, it can be deleted with |popup_clear()|
-- 		and |popup_close()|.  Use |popup_show()| to reposition it to
-- 		the item in the popup menu.
-- 		Returns zero if there is none.
--- @return number
function vim.fn.popup_findinfo() end

-- The result is a dictionary of byte/chars/word statistics for
-- 		the current buffer.  This is the same info as provided by
-- 		|g_CTRL-G|
-- 		The return value includes:
-- 			bytes		Number of bytes in the buffer
-- 			chars		Number of chars in the buffer
-- 			words		Number of words in the buffer
-- 			cursor_bytes    Number of bytes before cursor position
-- 					(not in Visual mode)
-- 			cursor_chars    Number of chars before cursor position
-- 					(not in Visual mode)
-- 			cursor_words    Number of words before cursor position
-- 					(not in Visual mode)
-- 			visual_bytes    Number of bytes visually selected
-- 					(only in Visual mode)
-- 			visual_chars    Number of chars visually selected
-- 					(only in Visual mode)
-- 			visual_words    Number of chars visually selected
-- 					(only in Visual mode)
--- @return dict
function vim.fn.wordcount() end

-- Get the |window-ID| for the popup preview window.
-- 		Return zero if there is none.
--- @return number
function vim.fn.popup_findpreview() end

-- Return the {options} for popup {id} in a Dict.
-- 		A zero value means the option was not set.  For "zindex" the
-- 		default value is returned, not zero.
--
-- 		The "moved" entry is a list with line number, minimum and
-- 		maximum column, [0, 0, 0] when not set.
--
-- 		The "mousemoved" entry is a list with screen row, minimum and
-- 		maximum screen column, [0, 0, 0] when not set.
--
-- 		"firstline" is the property set on the popup, unlike the
-- 		"firstline" obtained with |popup_getpos()| which is the actual
-- 		buffer line at the top of the popup window.
--
-- 		"border" and "padding" are not included when all values are
-- 		zero.  When all values are one then an empty list is included.
--
-- 		"borderhighlight" is not included when all values are empty.
-- 		"scrollbarhighlight" and "thumbhighlight" are only included
-- 		when set.
--
-- 		"tabpage" will be -1 for a global popup, zero for a popup on
-- 		the current tabpage and a positive number for a popup on
-- 		another tabpage.
--
-- 		"textprop", "textpropid" and "textpropwin" are only present
-- 		when "textprop" was set.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getoptions()
--- @return dict
function vim.fn.popup_getoptions(id) end

-- Return the position and size of popup {id}.  Returns a Dict
-- 		with these entries:
-- 		    col		screen column of the popup, one-based
-- 		    line	screen line of the popup, one-based
-- 		    width	width of the whole popup in screen cells
-- 		    height	height of the whole popup in screen cells
-- 		    core_col	screen column of the text box
-- 		    core_line	screen line of the text box
-- 		    core_width	width of the text box in screen cells
-- 		    core_height	height of the text box in screen cells
-- 		    firstline	line of the buffer at top (1 unless scrolled)
-- 				(not the value of the "firstline" property)
-- 		    lastline	line of the buffer at the bottom (updated when
-- 				the popup is redrawn)
-- 		    scrollbar	non-zero if a scrollbar is displayed
-- 		    visible	one if the popup is displayed, zero if hidden
-- 		Note that these are the actual screen positions.  They differ
-- 		from the values in `popup_getoptions()` for the sizing and
-- 		positioning mechanism applied.
--
-- 		The "core_" values exclude the padding and border.
--
-- 		If popup window {id} is not found an empty Dict is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetPopup()->popup_getpos()
--- @return dict
function vim.fn.popup_getpos(id) end

