--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- In a nvim launched with the |--headless| option, this opens
-- 		stdin and stdout as a |channel|. This function can only be
-- 		invoked once per instance. See |channel-stdio| for more
-- 		information and examples. Note that stderr is not handled by
-- 		this function, see |v:stderr|.
--
-- 		Returns a |channel| ID. Close the stdio descriptors with |chanclose()|.
-- 		Use |chansend()| to send data to stdout, and
-- 		|rpcrequest()| and |rpcnotify()| to communicate over RPC.
--
-- 		{opts} is a dictionary with these keys:
-- 		  |on_stdin| : callback invoked when stdin is written to.
-- 		  stdin_buffered : read stdin in |channel-buffered| mode.
-- 		  rpc      : If set, |msgpack-rpc| will be used to communicate
-- 			     over stdio
-- 		Returns:
-- 		  - The channel ID on success (this is always 1)
-- 		  - 0 on invalid arguments
--- @param dict dictionary
--- @return number
function vim.fn.stdioopen(dict) end

-- The result is a Number, which is the screen column of the file
-- 		position given with {expr}.  That is, the last screen position
-- 		occupied by the character at that position, when the screen
-- 		would be of unlimited width.  When there is a <Tab> at the
-- 		position, the returned Number will be the column at the end of
-- 		the <Tab>.  For example, for a <Tab> in column 1, with 'ts'
-- 		set to 8, it returns 8. |conceal| is ignored.
-- 		For the byte position use |col()|.
-- 		For the use of {expr} see |col()|.
-- 		When 'virtualedit' is used {expr} can be [lnum, col, off], where
-- 		"off" is the offset in screen columns from the start of the
-- 		character.  E.g., a position within a <Tab> or after the last
-- 		character.  When "off" is omitted zero is used.
-- 		When Virtual editing is active in the current mode, a position
-- 		beyond the end of the line can be returned. |'virtualedit'|
-- 		The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the end of the cursor line (the result is the
-- 			    number of displayed characters in the cursor line
-- 			    plus one)
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    v       In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Note that only marks in the current file can be used.
-- 		Examples: >
--   virtcol(".")	   with text "foo^Lbar", with cursor on the "^L", returns 5
--   virtcol("$")	   with text "foo^Lbar", returns 9
--   virtcol("'t")    with text "	  there", with 't at 'h', returns 6
-- <		The first column is 1.  0 is returned for an error.
-- 		A more advanced example that echoes the maximum length of
-- 		all lines: >
-- 		    echo max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
--- @return number
function vim.fn.virtcol(expr) end

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

-- Convert String {expr} to a Float.  This mostly works the same
-- 		as when using a floating point number in an expression, see
-- 		|floating-point-format|.  But it's a bit more permissive.
-- 		E.g., "1e40" is accepted, while in an expression you need to
-- 		write "1.0e40".  The hexadecimal form "0x123" is also
-- 		accepted, but not others, like binary or octal.
-- 		Text after the number is silently ignored.
-- 		The decimal point is always '.', no matter what the locale is
-- 		set to.  A comma ends the number: "12,345.67" is converted to
-- 		12.0.  You can strip out thousands separators with
-- 		|substitute()|: >
-- 			let f = str2float(substitute(text, ',', '', 'g'))
--- @return float
function vim.fn.str2float(expr) end

-- Like byteidx(), except that a composing character is counted
-- 		as a separate character.  Example: >
-- 			let s = 'e' . nr2char(0x301)
-- 			echo byteidx(s, 1)
-- 			echo byteidxcomp(s, 1)
-- 			echo byteidxcomp(s, 2)
-- <		The first and third echo result in 3 ('e' plus composing
-- 		character is 3 bytes), the second echo results in 1 ('e' is
-- 		one byte).
--- @return number
function vim.fn.byteidxcomp(expr, nr) end

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

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

-- Close a channel or a specific stream associated with it.
-- 		For a job, {stream} can be one of "stdin", "stdout",
-- 		"stderr" or "rpc" (closes stdin/stdout for a job started
-- 		with `"rpc":v:true`) If {stream} is omitted, all streams
-- 		are closed. If the channel is a pty, this will then close the
-- 		pty master, sending SIGHUP to the job process.
-- 		For a socket, there is only one stream, and {stream} should be
-- 		ommited.
--- @return number
function vim.fn.chanclose(id, stream) end

-- Send data to channel {id}. For a job, it writes it to the
-- 		stdin of the process. For the stdio channel |channel-stdio|,
-- 		it writes to Nvim's stdout.  Returns the number of bytes
-- 		written if the write succeeded, 0 otherwise.
-- 		See |channel-bytes| for more information.
--
-- 		{data} may be a string, string convertible, or a list.  If
-- 		{data} is a list, the items will be joined by newlines; any
-- 		newlines in an item will be sent as NUL. To send a final
-- 		newline, include a final empty string. Example: >
-- 			:call chansend(id, ["abc", "123\n456", ""])
-- < 		will send "abc<NL>123<NUL>456<NL>".
--
-- 		chansend() writes raw data, not RPC messages.  If the channel
-- 		was created with `"rpc":v:true` then the channel expects RPC
-- 		messages, use |rpcnotify()| and |rpcrequest()| instead.
--- @return number
function vim.fn.chansend(id, data) end

-- Return number value of the first char in {expr}.  Examples: >
-- 			char2nr(" ")		returns 32
-- 			char2nr("ABC")		returns 65
-- 			char2nr("á")		returns 225
-- 			char2nr("á"[0])		returns 195
-- 			char2nr("\<M-x>")	returns 128
-- <		Non-ASCII characters are always treated as UTF-8 characters.
-- 		{utf8} is ignored, it exists only for backwards-compatibility.
-- 		A combining character is a separate character.
-- 		|nr2char()| does the opposite.
--- @return number
function vim.fn.char2nr(expr, utf8) end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
--- @return number
function vim.fn.strlen(expr) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- The result is a Number, which gives the byte index in
-- 		{haystack} of the last occurrence of the String {needle}.
-- 		When {start} is specified, matches beyond this index are
-- 		ignored.  This can be used to find a match before a previous
-- 		match: >
-- 			:let lastcomma = strridx(line, ",")
-- 			:let comma2 = strridx(line, ",", lastcomma - 1)
-- <		The search is done case-sensitive.
-- 		For pattern searches use |match()|.
-- 		-1 is returned if the {needle} does not occur in {haystack}.
-- 		If the {needle} is empty the length of {haystack} is returned.
-- 		See also |stridx()|.  Examples: >
-- 		  :echo strridx("an angry armadillo", "an")	     3
-- <							*strrchr()*
-- 		When used with a single character it works similar to the C
-- 		function strrchr().
--- @return number
function vim.fn.strridx(haystack, needle, start) end

-- Same as |search()|, but returns a |List| with the line and
-- 		column position of the match. The first element of the |List|
-- 		is the line number and the second element is the byte index of
-- 		the column position of the match. If no match is found,
-- 		returns [0, 0].
-- 		Example: >
-- 	:let [lnum, col] = searchpos('mypattern', 'n')
--
-- <		When the 'p' flag is given then there is an extra item with
-- 		the sub-pattern match number |search()-sub-match|.  Example: >
-- 	:let [lnum, col, submatch] = searchpos('\(\l\)\|\(\u\)', 'np')
-- <		In this example "submatch" is 2 when a lowercase letter is
-- 		found |/\l|, 3 when an uppercase letter is found |/\u|.
--- @return list
function vim.fn.searchpos(pattern, flags, stopline, timeout) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
--- @return number
function vim.fn.strwidth(expr) end

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

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

-- The result is a String, which is a copy of {expr}, in which
-- 		the first match of {pat} is replaced with {sub}.
-- 		When {flags} is "g", all matches of {pat} in {expr} are
-- 		replaced.  Otherwise {flags} should be "".
--
-- 		This works like the ":substitute" command (without any flags).
-- 		But the matching with {pat} is always done like the 'magic'
-- 		option is set and 'cpoptions' is empty (to make scripts
-- 		portable).  'ignorecase' is still relevant, use |/\c| or |/\C|
-- 		if you want to ignore or match case and ignore 'ignorecase'.
-- 		'smartcase' is not used.  See |string-match| for how {pat} is
-- 		used.
--
-- 		A "~" in {sub} is not replaced with the previous {sub}.
-- 		Note that some codes in {sub} have a special meaning
-- 		|sub-replace-special|.  For example, to replace something with
-- 		"\n" (two characters), use "\\\\n" or '\\n'.
--
-- 		When {pat} does not match in {expr}, {expr} is returned
-- 		unmodified.
--
-- 		Example: >
-- 			:let &path = substitute(&path, ",\\=[^,]*$", "", "")
-- <		This removes the last component of the 'path' option. >
-- 			:echo substitute("testing", ".*", "\\U\\0", "")
-- <		results in "TESTING".
--
-- 		When {sub} starts with "\=", the remainder is interpreted as
-- 		an expression. See |sub-replace-expression|.  Example: >
-- 			:echo substitute(s, '%\(\x\x\)',
-- 			   \ '\=nr2char("0x" . submatch(1))', 'g')
--
-- <		When {sub} is a Funcref that function is called, with one
-- 		optional argument.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', SubNr, 'g')
-- <		The optional argument is a list which contains the whole
-- 		matched string and up to nine submatches, like what
-- 		|submatch()| returns.  Example: >
-- 		   :echo substitute(s, '%\(\x\x\)', {m -> '0x' . m[1]}, 'g')
--- @return string
function vim.fn.substitute(expr, pat, sub, flags) end

-- The result is a dictionary, which holds information about the
-- 		swapfile {fname}. The available fields are:
-- 			version VIM version
-- 			user	user name
-- 			host	host name
-- 			fname	original file name
-- 			pid	PID of the VIM process that created the swap
-- 				file
-- 			mtime	last modification time in seconds
-- 			inode	Optional: INODE number of the file
-- 			dirty	1 if file was modified, 0 if not
-- 		In case of failure an "error" item is added with the reason:
-- 			Cannot open file: file not found or in accessible
-- 			Cannot read file: cannot read first block
-- 			Not a swap file: does not contain correct block ID
-- 			Magic number mismatch: Info in first block is invalid
--- @return dict
function vim.fn.swapinfo(fname) end

-- Uses the |Dictionary| returned by |winsaveview()| to restore
-- 		the view of the current window.
-- 		Note: The {dict} does not have to contain all values, that are
-- 		returned by |winsaveview()|. If values are missing, those
-- 		settings won't be restored. So you can use: >
-- 		    :call winrestview({'curswant': 4})
-- <
-- 		This will only set the curswant value (the column the cursor
-- 		wants to move on vertical movements) of the cursor to column 5
-- 		(yes, that is 5), while all other settings will remain the
-- 		same. This is useful, if you set the cursor position manually.
--
-- 		If you have changed the values the result is unpredictable.
-- 		If the window size changed the result won't be the same.
--- @param dict dictionary
--- @return none
function vim.fn.winrestview(dict) end

-- Returns a |Dictionary| representing the |context| at {index}
-- 		from the top of the |context-stack| (see |context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return dict
function vim.fn.ctxget(index) end

-- Pops and restores the |context| at the top of the
-- 		|context-stack|.
--- @return none
function vim.fn.ctxpop() end

-- Return {text} as a String where any character in {mask} is
-- 		removed from the beginning and  end of {text}.
-- 		If {mask} is not given, {mask} is all characters up to 0x20,
-- 		which includes Tab, space, NL and CR, plus the non-breaking
-- 		space character 0xa0.
-- 		This code deals with multibyte characters properly.
--
-- 		Examples: >
-- 			echo trim("   some text ")
-- <		returns "some text" >
-- 			echo trim("  \r\t\t\r RESERVE \t\n\x0B\xA0") . "_TAIL"
-- <		returns "RESERVE_TAIL" >
-- 			echo trim("rm<Xrm<>X>rrm", "rm<>")
-- <		returns "Xrm<>X" (characters in the middle are not removed)
--- @return string
function vim.fn.trim(text, mask) end

-- Pushes the current editor state (|context|) on the
-- 		|context-stack|.
-- 		If {types} is given and is a |List| of |String|s, it specifies
-- 		which |context-types| to include in the pushed context.
-- 		Otherwise, all context types are included.
--- @return none
function vim.fn.ctxpush(types) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

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

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

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

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @return number
function vim.fn.debugbreak(pid) end

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

-- Return the lowest index in |List| {list} where the item has a
-- 		value equal to {expr}.  There is no automatic conversion, so
-- 		the String "4" is different from the Number 4.  And the number
-- 		4 is different from the Float 4.0.  The value of 'ignorecase'
-- 		is not used here, case always matters.
-- 		If {start} is given then start looking at the item with index
-- 		{start} (may be negative for an item relative to the end).
-- 		When {ic} is given and it is |TRUE|, ignore case.  Otherwise
-- 		case must match.
-- 		-1 is returned when {expr} is not found in {list}.
-- 		Example: >
-- 			:let idx = index(words, "the")
-- 			:if index(numbers, 123) >= 0
--- @param list any[]
--- @return number
function vim.fn.index(list, expr, start, ic) end

-- for the current buffer.  This is the 'tags' option expanded.
--- @return list
function vim.fn.tagfiles() end

-- Make a |List| out of {expr}.  When {pattern} is omitted or
-- 		empty each white-separated sequence of characters becomes an
-- 		item.
-- 		Otherwise the string is split where {pattern} matches,
-- 		removing the matched characters. 'ignorecase' is not used
-- 		here, add \c to ignore case. |/\c|
-- 		When the first or last item is empty it is omitted, unless the
-- 		{keepempty} argument is given and it's non-zero.
-- 		Other empty items are kept when {pattern} matches at least one
-- 		character or when {keepempty} is non-zero.
-- 		Example: >
-- 			:let words = split(getline('.'), '\W\+')
-- <		To split a string in individual characters: >
-- 			:for c in split(mystring, '\zs')
-- <		If you want to keep the separator you can also use '\zs' at
-- 		the end of the pattern: >
-- 			:echo split('abc:def:ghi', ':\zs')
-- <			['abc:', 'def:', 'ghi'] ~
-- 		Splitting a table where the first element can be empty: >
-- 			:let items = split(line, ':', 1)
-- <		The opposite function is |join()|.
--- @return list
function vim.fn.split(expr, pat, keepempty) end

-- The result is a String, which is the name of a file that
-- 		doesn't exist.  It can be used for a temporary file.  Example: >
-- 			:let tmpfile = tempname()
-- 			:exe "redir > " . tmpfile
-- <		For Unix, the file will be in a private directory |tempfile|.
-- 		For MS-Windows forward slashes are used when the 'shellslash'
-- 		option is set or when 'shellcmdflag' starts with '-'.
--- @return string
function vim.fn.tempname() end

-- Get the output of {cmd} as a |string| (use |systemlist()| to
-- 		get a |List|). {cmd} is treated exactly as in |jobstart()|.
-- 		Not to be used for interactive commands.
--
-- 		If {input} is a string it is written to a pipe and passed as
-- 		stdin to the command.  The string is written as-is, line
-- 		separators are not changed.
-- 		If {input} is a |List| it is written to the pipe as
-- 		|writefile()| does with {binary} set to "b" (i.e. with
-- 		a newline between each list item, and newlines inside list
-- 		items converted to NULs).
-- 		When {input} is given and is a valid buffer id, the content of
-- 		the buffer is written to the file line by line, each line
-- 		terminated by NL (and NUL where the text has NL).
-- 								*E5677*
-- 		Note: system() cannot write to or read from backgrounded ("&")
-- 		shell commands, e.g.: >
-- 		    :echo system("cat - &", "foo"))
-- <		which is equivalent to: >
-- 		    $ echo foo | bash -c 'cat - &'
-- <		The pipes are disconnected (unless overridden by shell
-- 		redirection syntax) before input can reach it. Use
-- 		|jobstart()| instead.
--
-- 		Note: Use |shellescape()| or |::S| with |expand()| or
-- 		|fnamemodify()| to escape special characters in a command
-- 		argument.  Newlines in {cmd} may cause the command to fail.
-- 		The characters in 'shellquote' and 'shellxquote' may also
-- 		cause trouble.
--
-- 		Result is a String.  Example: >
-- 		    :let files = system("ls " .  shellescape(expand('%:h')))
-- 		    :let files = system('ls ' . expand('%:h:S'))
--
-- <		To make the result more system-independent, the shell output
-- 		is filtered to replace <CR> with <NL> for Macintosh, and
-- 		<CR><NL> with <NL> for DOS-like systems.
-- 		To avoid the string being truncated at a NUL, all NUL
-- 		characters are replaced with SOH (0x01).
--
-- 		The command executed is constructed using several options when
-- 		{cmd} is a string: 'shell' 'shellcmdflag' {cmd}
--
-- 		The resulting error code can be found in |v:shell_error|.
-- 		This function will fail in |restricted-mode|.
--
-- 		Note that any wrong value in the options mentioned above may
-- 		make the function fail.  It has also been reported to fail
-- 		when using a security agent application.
-- 		Unlike ":!cmd" there is no automatic check for changed files.
-- 		Use |:checktime| to force a check.
--- @return string
function vim.fn.system(cmd, input) end

-- Like |garbagecollect()|, but executed right away.  This must
-- 		only be called directly to avoid any structure to exist
-- 		internally, and |v:testing| must have been set before calling
-- 		any function.
--- @return none
function vim.fn.test_garbagecollect_now() end

-- Return a string which contains characters indicating the
-- 		current state.  Mostly useful in callbacks that want to do
-- 		work that may not always be safe.  Roughly this works like:
-- 		- callback uses state() to check if work is safe to do.
-- 		  Yes: then do it right away.
-- 		  No:  add to work queue and add a |SafeState| and/or
-- 		       |SafeStateAgain| autocommand (|SafeState| triggers at
-- 		       toplevel, |SafeStateAgain| triggers after handling
-- 		       messages and callbacks).
-- 		- When SafeState or SafeStateAgain is triggered and executes
-- 		  your autocommand, check with `state()` if the work can be
-- 		  done now, and if yes remove it from the queue and execute.
-- 		  Remove the autocommand if the queue is now empty.
-- 		Also see |mode()|.
--
-- 		When {what} is given only characters in this string will be
-- 		added.  E.g, this checks if the screen has scrolled: >
-- 			if state('s') == ''
-- 			   " screen has not scrolled
-- <
-- 		These characters indicate the state, generally indicating that
-- 		something is busy:
-- 		    m	halfway a mapping, :normal command, feedkeys() or
-- 			stuffed command
-- 		    o	operator pending or waiting for a command argument,
-- 		        e.g. after |f|
-- 		    a	Insert mode autocomplete active
-- 		    x	executing an autocommand
-- 		    w	blocked on waiting, e.g. ch_evalexpr(), ch_read() and
-- 			ch_readraw() when reading json.
-- 		    S	not triggering SafeState or SafeStateAgain
-- 		    c	callback invoked, including timer (repeats for
-- 			recursiveness up to "ccc")
-- 		    s	screen has scrolled for messages
--- @return string
function vim.fn.state(what) end

-- Return a list with information about timers.
-- 		When {id} is given only information about this timer is
-- 		returned.  When timer {id} does not exist an empty list is
-- 		returned.
-- 		When {id} is omitted information about all timers is returned.
--
-- 		For each timer the information is stored in a Dictionary with
-- 		these items:
-- 		    "id"	    the timer ID
-- 		    "time"	    time the timer was started with
-- 		    "repeat"	    number of times the timer will still fire;
-- 				    -1 means forever
-- 		    "callback"	    the callback
--- @return list
function vim.fn.timer_info(id) end

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

-- Stop all timers.  The timer callbacks will no longer be
-- 		invoked.  Useful if some timers is misbehaving.  If there are
-- 		no timers there is no error.
--- @return none
function vim.fn.timer_stopall() end

-- The result is a copy of the String given, with all uppercase
-- 		characters turned into lowercase (just like applying |gu| to
-- 		the string).
--- @return string
function vim.fn.tolower(expr) end

-- Bitwise XOR on the two arguments.  The arguments are converted
-- 		to a number.  A List, Dict or Float argument causes an error.
-- 		Example: >
-- 			:let bits = xor(bits, 0x80)
-- <
--- @return number
function vim.fn.xor(expr, expr) end

-- The result is a nested List containing the layout of windows
-- 		in a tabpage.
--
-- 		Without {tabnr} use the current tabpage, otherwise the tabpage
-- 		with number {tabnr}. If the tabpage {tabnr} is not found,
-- 		returns an empty list.
--
-- 		For a leaf window, it returns:
-- 			['leaf', {winid}]
-- 		For horizontally split windows, which form a column, it
-- 		returns:
-- 			['col', [{nested list of windows}]]
-- 		For vertically split windows, which form a row, it returns:
-- 			['row', [{nested list of windows}]]
--
-- 		Example: >
-- 			" Only one window in the tab page
-- 			:echo winlayout()
-- 			['leaf', 1000]
-- 			" Two horizontally split windows
-- 			:echo winlayout()
-- 			['col', [['leaf', 1000], ['leaf', 1001]]]
-- 			" Three horizontally split windows, with two
-- 			" vertically split windows in the middle window
-- 			:echo winlayout(2)
-- 			['col', [['leaf', 1002], ['row', ['leaf', 1003],
-- 					     ['leaf', 1001]]], ['leaf', 1000]]
-- <
--- @return list
function vim.fn.winlayout(tabnr) end

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

-- Returns a list with |window-ID|s for windows that contain
-- 		buffer {bufnr}.  When there is none the list is empty.
--- @return list
function vim.fn.win_findbuf(bufnr) end

-- Return a list with the tab number and window number of window
-- 		with ID {expr}: [tabnr, winnr].
-- 		Return [0, 0] if the window cannot be found.
--- @return list
function vim.fn.win_id2tabwin(expr) end

-- Return the window number of window with ID {expr}.
-- 		Return 0 if the window cannot be found in the current tabpage.
--- @return number
function vim.fn.win_id2win(expr) end

-- Return the screen position of window {nr} as a list with two
-- 		numbers: [row, col].  The first window always has position
-- 		[1, 1], unless there is a tabline, then it is [2, 1].
-- 		{nr} can be the window number or the |window-ID|.
-- 		Return [0, 0] if the window cannot be found in the current
-- 		tabpage.
--- @return list
function vim.fn.win_screenpos(nr) end

-- The result is a Dict with the screen position of the text
-- 		character in window {winid} at buffer line {lnum} and column
-- 		{col}.  {col} is a one-based byte index.
-- 		The Dict has these members:
-- 			row	screen row
-- 			col	first screen column
-- 			endcol	last screen column
-- 			curscol	cursor screen column
-- 		If the specified position is not visible, all values are zero.
-- 		The "endcol" value differs from "col" when the character
-- 		occupies more than one screen cell.  E.g. for a Tab "col" can
-- 		be 1 and "endcol" can be 8.
-- 		The "curscol" value is where the cursor would be placed.  For
-- 		a Tab it would be the same as "endcol", while for a double
-- 		width character it would be the same as "col".
--- @return dict
function vim.fn.screenpos(winid, lnum, col) end

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

-- Convert a |readfile()|-style list to a list of VimL objects.
-- 		Example: >
-- 			let fname = expand('~/.config/nvim/shada/main.shada')
-- 			let mpack = readfile(fname, 'b')
-- 			let shada_objects = msgpackparse(mpack)
-- <		This will read ~/.config/nvim/shada/main.shada file to
-- 		`shada_objects` list.
--
-- 		Limitations:
-- 		1. Mapping ordering is not preserved unless messagepack
-- 		   mapping is dumped using generic  mapping
-- 		   (|msgpack-special-map|).
-- 		2. Since the parser aims to preserve all data untouched
-- 		   (except for 1.) some strings are parsed to
-- 		   |msgpack-special-dict| format which is not convenient to
-- 		   use.
-- 							*msgpack-special-dict*
-- 		Some messagepack strings may be parsed to special
-- 		dictionaries. Special dictionaries are dictionaries which
--
-- 		1. Contain exactly two keys: `_TYPE` and `_VAL`.
-- 		2. `_TYPE` key is one of the types found in |v:msgpack_types|
-- 		   variable.
-- 		3. Value for `_VAL` has the following format (Key column
-- 		   contains name of the key from |v:msgpack_types|):
--
-- 		Key	Value ~
-- 		nil	Zero, ignored when dumping.  Not returned by
-- 			|msgpackparse()| since |v:null| was introduced.
-- 		boolean	One or zero.  When dumping it is only checked that
-- 			value is a |Number|.  Not returned by |msgpackparse()|
-- 			since |v:true| and |v:false| were introduced.
-- 		integer	|List| with four numbers: sign (-1 or 1), highest two
-- 			bits, number with bits from 62nd to 31st, lowest 31
-- 			bits. I.e. to get actual number one will need to use
-- 			code like >
-- 				_VAL[0] * ((_VAL[1] << 62)
-- 				           & (_VAL[2] << 31)
-- 				           & _VAL[3])
-- <			Special dictionary with this type will appear in
-- 			|msgpackparse()| output under one of the following
-- 			circumstances:
-- 			1. |Number| is 32-bit and value is either above
-- 			   INT32_MAX or below INT32_MIN.
-- 			2. |Number| is 64-bit and value is above INT64_MAX. It
-- 			   cannot possibly be below INT64_MIN because msgpack
-- 			   C parser does not support such values.
-- 		float	|Float|. This value cannot possibly appear in
-- 			|msgpackparse()| output.
-- 		string	|readfile()|-style list of strings. This value will
-- 			appear in |msgpackparse()| output if string contains
-- 			zero byte or if string is a mapping key and mapping is
-- 			being represented as special dictionary for other
-- 			reasons.
-- 		binary	|readfile()|-style list of strings. This value will
-- 			appear in |msgpackparse()| output if binary string
-- 			contains zero byte.
-- 		array	|List|. This value cannot appear in |msgpackparse()|
-- 			output.
-- 							*msgpack-special-map*
-- 		map	|List| of |List|s with two items (key and value) each.
-- 			This value will appear in |msgpackparse()| output if
-- 			parsed mapping contains one of the following keys:
-- 			1. Any key that is not a string (including keys which
-- 			   are binary strings).
-- 			2. String with NUL byte inside.
-- 			3. Duplicate key.
-- 			4. Empty key.
-- 		ext	|List| with two values: first is a signed integer
-- 			representing extension type. Second is
-- 			|readfile()|-style list of strings.
--- @param list any[]
--- @return list
function vim.fn.msgpackparse(list) end

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

-- Set attrs in nvim__buf_set_lua_hl callbacks
--
--                 TODO(bfredl): This is rather pedestrian. The final interface
--                 should probably be derived from a reformed bufhl/virttext
--                 interface with full support for multi-line ranges etc
function vim.fn.nvim__put_attr(id, c0, c1) end

-- Calls many API methods atomically.
--
--                 This has two main usages:
--                 1. To perform several requests from an async context
--                    atomically, i.e. without interleaving redraws, RPC requests
--                    from other clients, or user interactions (however API
--                    methods may trigger autocommands or event processing which
--                    have such side-effects, e.g. |:sleep| may wake timers).
--                 2. To minimize RPC overhead (roundtrips) of a sequence of many
--                    requests.
--
--                 Parameters: ~
--                     {calls}  an array of calls, where each call is described
--                              by an array with two elements: the request name,
--                              and an array of arguments.
--
--                 Return: ~
--                     Array of two elements. The first is an array of return
--                     values. The second is NIL if all calls succeeded. If a
--                     call resulted in an error, it is a three-element array
--                     with the zero-based index of the call which resulted in an
--                     error, the error type and the error message. If an error
--                     occurred, the values from all preceding calls will still
--                     be returned.
function vim.fn.nvim_call_atomic(calls) end

-- Execute Lua code. Parameters (if any) are available as `...`
--                 inside the chunk. The chunk can return a value.
--
--                 Only statements are executed. To evaluate an expression,
--                 prefix it with `return` : return my_function(...)
--
--                 Parameters: ~
--                     {code}  Lua code to execute
--                     {args}  Arguments to the code
--
--                 Return: ~
--                     Return value of Lua code if present or NIL.
--- @param args any[]
function vim.fn.nvim_exec_lua(code, args) end

-- Returns a 2-tuple (Array), where item 0 is the current channel
--                 id and item 1 is the |api-metadata| map (Dictionary).
--
--                 Return: ~
--                     2-tuple [{channel-id}, {api-metadata}]
--
--                 Attributes: ~
--                     {fast}
function vim.fn.nvim_get_api_info() end

-- Get the amount of indent for line {lnum} according the C
-- 		indenting rules, as with 'cindent'.
-- 		The indent is counted in spaces, the value of 'tabstop' is
-- 		relevant.  {lnum} is used just like in |getline()|.
-- 		When {lnum} is invalid -1 is returned.
-- 		See |C-indenting|.
--- @return number
function vim.fn.cindent(lnum) end

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies on the screen when it starts at {col}
-- 		(first column is zero).  When {col} is omitted zero is used.
-- 		Otherwise it is the screen column where to start.  This
-- 		matters for Tab characters.
-- 		The option settings of the current window are used.  This
-- 		matters for anything that's displayed differently, such as
-- 		'tabstop' and 'display'.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strwidth()| and |strchars()|.
--- @return number
function vim.fn.strdisplaywidth(expr, col) end

-- The result is a String, which describes the last Visual mode
-- 		used in the current buffer.  Initially it returns an empty
-- 		string, but once Visual mode has been used, it returns "v",
-- 		"V", or "<CTRL-V>" (a single CTRL-V character) for
-- 		character-wise, line-wise, or block-wise Visual mode
-- 		respectively.
-- 		Example: >
-- 			:exe "normal " . visualmode()
-- <		This enters the same Visual mode as before.  It is also useful
-- 		in scripts if you wish to act differently depending on the
-- 		Visual mode that was used.
-- 		If Visual mode is active, use |mode()| to get the Visual mode
-- 		(e.g., in a |:vmap|).
-- 		If [expr] is supplied and it evaluates to a non-zero Number or
-- 		a non-empty String, then the Visual mode will be cleared and
-- 		the old value is returned.  See |non-zero-arg|.
--- @return string
function vim.fn.visualmode(expr) end

-- Self-identifies the client.
--
--                 The client/plugin/application should call this after
--                 connecting, to provide hints about its identity and purpose,
--                 for debugging and orchestration.
--
--                 Can be called more than once; the caller should merge old info
--                 if appropriate. Example: library first identifies the channel,
--                 then a plugin using that library later identifies itself.
--
--                 Note:
--                     "Something is better than nothing". You don't need to
--                     include all the fields.
--
--                 Parameters: ~
--                     {name}        Short name for the connected client
--                     {version}     Dictionary describing the version, with
--                                   these (optional) keys:
--                                   • "major" major version (defaults to 0 if
--                                     not set, for no release yet)
--                                   • "minor" minor version
--                                   • "patch" patch number
--                                   • "prerelease" string describing a
--                                     prerelease, like "dev" or "beta1"
--                                   • "commit" hash or similar identifier of
--                                     commit
--                     {type}        Must be one of the following values. Client
--                                   libraries should default to "remote" unless
--                                   overridden by the user.
--                                   • "remote" remote client connected to Nvim.
--                                   • "ui" gui frontend
--                                   • "embedder" application using Nvim as a
--                                     component (for example, IDE/editor
--                                     implementing a vim mode).
--                                   • "host" plugin host, typically started by
--                                     nvim
--                                   • "plugin" single plugin, started by nvim
--                     {methods}     Builtin methods in the client. For a host,
--                                   this does not include plugin methods which
--                                   will be discovered later. The key should be
--                                   the method name, the values are dicts with
--                                   these (optional) keys (more keys may be
--                                   added in future versions of Nvim, thus
--                                   unknown keys are ignored. Clients must only
--                                   use keys defined in this or later versions
--                                   of Nvim):
--                                   • "async" if true, send as a notification.
--                                     If false or unspecified, use a blocking
--                                     request
--                                   • "nargs" Number of arguments. Could be a
--                                     single integer or an array of two
--                                     integers, minimum and maximum inclusive.
--                     {attributes}  Arbitrary string:string map of informal
--                                   client properties. Suggested keys:
--                                   • "website": Client homepage URL (e.g.
--                                     GitHub repository)
--                                   • "license": License description ("Apache
--                                     2", "GPLv3", "MIT", …)
--                                   • "logo": URI or path to image, preferably
--                                     small logo or icon. .png or .svg format is
--                                     preferred.
function vim.fn.nvim_set_client_info(name, version, type, methods, attributes) end

-- Return the line number of the first line at or above {lnum}
-- 		that is not blank.  Example: >
-- 			let ind = indent(prevnonblank(v:lnum - 1))
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		above it, zero is returned.
-- 		Also see |nextnonblank()|.
--- @return number
function vim.fn.prevnonblank(lnum) end

-- Subscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_subscribe(event) end

-- Unsubscribes to event broadcasts.
--
--                 Parameters: ~
--                     {event}  Event type string
function vim.fn.nvim_unsubscribe(event) end

-- Unstabilized interface for defining syntax hl in lua.
--
--                 This is not yet safe for general use, lua callbacks will need
--                 to be restricted, like textlock and probably other stuff.
--
--                 The API on_line/nvim__put_attr is quite raw and not intended
--                 to be the final shape. Ideally this should operate on chunks
--                 larger than a single line to reduce interpreter overhead, and
--                 generate annotation objects (bufhl/virttext) on the fly but
--                 using the same representation.
function vim.fn.nvim__buf_set_luahl(buffer, opts) end

-- Deactivates buffer-update events on the channel.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--
--                 Return: ~
--                     False if detach failed (because the buffer isn't loaded);
--                     otherwise True.
--
--                 See also: ~
--                     |nvim_buf_attach()|
--                     |api-lua-detach| for detaching Lua callbacks
function vim.fn.nvim_buf_detach(buffer) end

-- Confirm() offers the user a dialog, from which a choice can be
-- 		made.  It returns the number of the choice.  For the first
-- 		choice this is 1.
--
-- 		{msg} is displayed in a dialog with {choices} as the
-- 		alternatives.  When {choices} is missing or empty, "&OK" is
-- 		used (and translated).
-- 		{msg} is a String, use '\n' to include a newline.  Only on
-- 		some systems the string is wrapped when it doesn't fit.
--
-- 		{choices} is a String, with the individual choices separated
-- 		by '\n', e.g. >
-- 			confirm("Save changes?", "&Yes\n&No\n&Cancel")
-- <		The letter after the '&' is the shortcut key for that choice.
-- 		Thus you can type 'c' to select "Cancel".  The shortcut does
-- 		not need to be the first letter: >
-- 			confirm("file has been modified", "&Save\nSave &All")
-- <		For the console, the first letter of each choice is used as
-- 		the default shortcut key.
--
-- 		The optional {default} argument is the number of the choice
-- 		that is made if the user hits <CR>.  Use 1 to make the first
-- 		choice the default one.  Use 0 to not set a default.  If
-- 		{default} is omitted, 1 is used.
--
-- 		The optional {type} argument gives the type of dialog.  This
-- 		is only used for the icon of the Win32 GUI.  It can be one of
-- 		these values: "Error", "Question", "Info", "Warning" or
-- 		"Generic".  Only the first character is relevant.
-- 		When {type} is omitted, "Generic" is used.
--
-- 		If the user aborts the dialog by pressing <Esc>, CTRL-C,
-- 		or another valid interrupt key, confirm() returns 0.
--
-- 		An example: >
--    :let choice = confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2)
--    :if choice == 0
--    :	echo "make up your mind!"
--    :elseif choice == 3
--    :	echo "tasteful"
--    :else
--    :	echo "I prefer bananas myself."
--    :endif
-- <		In a GUI dialog, buttons are used.  The layout of the buttons
-- 		depends on the 'v' flag in 'guioptions'.  If it is included,
-- 		the buttons are always put vertically.  Otherwise,  confirm()
-- 		tries to put the buttons in one horizontal line.  If they
-- 		don't fit, a vertical layout is used anyway.  For some systems
-- 		the horizontal layout is always used.
--- @return number
function vim.fn.confirm(msg, choices, default, type) end

-- Get the virtual text (annotation) for a buffer line.
--
--                 The virtual text is returned as list of lists, whereas the
--                 inner lists have either one or two elements. The first element
--                 is the actual text, the optional second element is the
--                 highlight group.
--
--                 The format is exactly the same as given to
--                 nvim_buf_set_virtual_text().
--
--                 If there is no virtual text associated with the given line, an
--                 empty list is returned.
--
--                 Parameters: ~
--                     {buffer}  Buffer handle, or 0 for current buffer
--                     {line}    Line to get the virtual text from (zero-indexed)
--
--                 Return: ~
--                     List of virtual text chunks
function vim.fn.nvim_buf_get_virtual_text(buffer, lnum) end

