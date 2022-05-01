--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Become the server {name}.  This fails if already running as a
-- 		server, when |v:servername| is not empty.
--- @return none
function vim.fn.remote_startserver(name) end

-- Get information about buffers as a List of Dictionaries.
--
-- 		Without an argument information about all the buffers is
-- 		returned.
--
-- 		When the argument is a Dictionary only the buffers matching
-- 		the specified criteria are returned.  The following keys can
-- 		be specified in {dict}:
-- 			buflisted	include only listed buffers.
-- 			bufloaded	include only loaded buffers.
-- 			bufmodified	include only modified buffers.
--
-- 		Otherwise, {expr} specifies a particular buffer to return
-- 		information for.  For the use of {expr}, see |bufname()|
-- 		above.  If the buffer is found the returned List has one item.
-- 		Otherwise the result is an empty list.
--
-- 		Each returned List item is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number.
-- 			changed		TRUE if the buffer is modified.
-- 			changedtick	number of changes made to the buffer.
-- 			hidden		TRUE if the buffer is hidden.
-- 			listed		TRUE if the buffer is listed.
-- 			lnum		current line number in buffer.
-- 			linecount	number of lines in the buffer (only
-- 					valid when loaded)
-- 			loaded		TRUE if the buffer is loaded.
-- 			name		full path to the file in the buffer.
-- 			signs		list of signs placed in the buffer.
-- 					Each list item is a dictionary with
-- 					the following fields:
-- 					    id	  sign identifier
-- 					    lnum  line number
-- 					    name  sign name
-- 			variables	a reference to the dictionary with
-- 					buffer-local variables.
-- 			windows		list of |window-ID|s that display this
-- 					buffer
--
-- 		Examples: >
-- 			for buf in getbufinfo()
-- 			    echo buf.name
-- 			endfor
-- 			for buf in getbufinfo({'buflisted':1})
-- 			    if buf.changed
-- 				....
-- 			    endif
-- 			endfor
-- <
-- 		To get buffer-local options use: >
-- 			getbufvar({bufnr}, '&option_name')
--
-- <
--- @return list
function vim.fn.getbufinfo(expr) end

-- If {arg} is not specified, then information about all the tab
-- 		pages is returned as a List. Each List item is a Dictionary.
-- 		Otherwise, {arg} specifies the tab page number and information
-- 		about that one is returned.  If the tab page does not exist an
-- 		empty List is returned.
--
-- 		Each List item is a Dictionary with the following entries:
-- 			tabnr		tab page number.
-- 			variables	a reference to the dictionary with
-- 					tabpage-local variables
-- 			windows		List of |window-ID|s in the tab page.
--- @return list
function vim.fn.gettabinfo(expr) end

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

-- The result is a Number, which is the number of characters
-- 		in String {expr}.
-- 		When {skipcc} is omitted or zero, composing characters are
-- 		counted separately.
-- 		When {skipcc} set to 1, Composing characters are ignored.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strwidth()|.
--
-- 		{skipcc} is only available after 7.4.755.  For backward
-- 		compatibility, you can define a wrapper function: >
-- 		    if has("patch-7.4.755")
-- 		      function s:strchars(str, skipcc)
-- 			return strchars(a:str, a:skipcc)
-- 		      endfunction
-- 		    else
-- 		      function s:strchars(str, skipcc)
-- 			if a:skipcc
-- 			  return strlen(substitute(a:str, ".", "x", "g"))
-- 			else
-- 			  return strchars(a:str)
-- 			endif
-- 		      endfunction
-- 		    endif
--- @return number
function vim.fn.strchars(expr, skipcc) end

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

-- Like |screenchar()|, but return the attribute.  This is a rather
-- 		arbitrary number that can only be used to compare to the
-- 		attribute at other positions.
--- @return number
function vim.fn.screenattr(row, col) end

-- The result is a Number, which is the character at position
-- 		[row, col] on the screen.  This works for every possible
-- 		screen position, also status lines, window separators and the
-- 		command line.  The top left position is row one, column one
-- 		The character excludes composing characters.  For double-byte
-- 		encodings it may only be the first byte.
-- 		This is mainly to be used for testing.
-- 		Returns -1 when row or col is out of range.
--- @return number
function vim.fn.screenchar(row, col) end

-- Search for the declaration of {name}.
--
-- 		With a non-zero {global} argument it works like |gD|, find
-- 		first match in the file.  Otherwise it works like |gd|, find
-- 		first match in the function.
--
-- 		With a non-zero {thisblock} argument matches in a {} block
-- 		that ends before the cursor position are ignored.  Avoids
-- 		finding variable declarations only valid in another scope.
--
-- 		Moves the cursor to the found match.
-- 		Returns zero for success, non-zero for failure.
-- 		Example: >
-- 			if searchdecl('myvar') == 0
-- 			   echo getline('.')
-- 			endif
-- <
-- 							*searchpair()*
-- searchpair({start}, {middle}, {end} [, {flags} [, {skip}
-- 				[, {stopline} [, {timeout}]]]])
-- 		Search for the match of a nested start-end pair.  This can be
-- 		used to find the "endif" that matches an "if", while other
-- 		if/endif pairs in between are ignored.
-- 		The search starts at the cursor.  The default is to search
-- 		forward, include 'b' in {flags} to search backward.
-- 		If a match is found, the cursor is positioned at it and the
-- 		line number is returned.  If no match is found 0 or -1 is
-- 		returned and the cursor doesn't move.  No error message is
-- 		given.
--
-- 		{start}, {middle} and {end} are patterns, see |pattern|.  They
-- 		must not contain \( \) pairs.  Use of \%( \) is allowed.  When
-- 		{middle} is not empty, it is found when searching from either
-- 		direction, but only when not in a nested start-end pair.  A
-- 		typical use is: >
-- 			searchpair('\<if\>', '\<else\>', '\<endif\>')
-- <		By leaving {middle} empty the "else" is skipped.
--
-- 		{flags} 'b', 'c', 'n', 's', 'w' and 'W' are used like with
-- 		|search()|.  Additionally:
-- 		'r'	Repeat until no more matches found; will find the
-- 			outer pair.  Implies the 'W' flag.
-- 		'm'	Return number of matches instead of line number with
-- 			the match; will be > 1 when 'r' is used.
-- 		Note: it's nearly always a good idea to use the 'W' flag, to
-- 		avoid wrapping around the end of the file.
--
-- 		When a match for {start}, {middle} or {end} is found, the
-- 		{skip} expression is evaluated with the cursor positioned on
-- 		the start of the match.  It should return non-zero if this
-- 		match is to be skipped.  E.g., because it is inside a comment
-- 		or a string.
-- 		When {skip} is omitted or empty, every match is accepted.
-- 		When evaluating {skip} causes an error the search is aborted
-- 		and -1 returned.
--  		{skip} can be a string, a lambda, a funcref or a partial.
-- 		Anything else makes the function fail.
--
-- 		For {stopline} and {timeout} see |search()|.
--
-- 		The value of 'ignorecase' is used.  'magic' is ignored, the
-- 		patterns are used like it's on.
--
-- 		The search starts exactly at the cursor.  A match with
-- 		{start}, {middle} or {end} at the next character, in the
-- 		direction of searching, is the first one found.  Example: >
-- 			if 1
-- 			  if 2
-- 			  endif 2
-- 			endif 1
-- <		When starting at the "if 2", with the cursor on the "i", and
-- 		searching forwards, the "endif 2" is found.  When starting on
-- 		the character just before the "if 2", the "endif 1" will be
-- 		found.  That's because the "if 2" will be found first, and
-- 		then this is considered to be a nested if/endif from "if 2" to
-- 		"endif 2".
-- 		When searching backwards and {end} is more than one character,
-- 		it may be useful to put "\zs" at the end of the pattern, so
-- 		that when the cursor is inside a match with the end it finds
-- 		the matching start.
--
-- 		Example, to find the "endif" command in a Vim script: >
--
-- 	:echo searchpair('\<if\>', '\<el\%[seif]\>', '\<en\%[dif]\>', 'W',
-- 			\ 'getline(".") =~ "^\\s*\""')
--
-- <		The cursor must be at or after the "if" for which a match is
-- 		to be found.  Note that single-quote strings are used to avoid
-- 		having to double the backslashes.  The skip expression only
-- 		catches comments at the start of a line, not after a command.
-- 		Also, a word "en" or "if" halfway through a line is considered
-- 		a match.
-- 		Another example, to search for the matching "{" of a "}": >
--
-- 	:echo searchpair('{', '', '}', 'bW')
--
-- <		This works when the cursor is at or before the "}" for which a
-- 		match is to be found.  To reject matches that syntax
-- 		highlighting recognized as strings: >
--
-- 	:echo searchpair('{', '', '}', 'bW',
-- 	     \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
-- <
-- 							*searchpairpos()*
-- searchpairpos({start}, {middle}, {end} [, {flags} [, {skip}
-- 				[, {stopline} [, {timeout}]]]])
-- 		Same as |searchpair()|, but returns a |List| with the line and
-- 		column position of the match. The first element of the |List|
-- 		is the line number and the second element is the byte index of
-- 		the column position of the match.  If no match is found,
-- 		returns [0, 0]. >
--
-- 			:let [lnum,col] = searchpairpos('{', '', '}', 'n')
-- <
-- 		See |match-parens| for a bigger and more useful example.
--- @return number
function vim.fn.searchdecl(name, global, thisblock) end

--- @return number
function vim.fn.searchpair(start, middle, _end, flags, ...) end

--- @return list
function vim.fn.searchpairpos(start, middle, _end, flags, ...) end

-- Send a reply string to {clientid}.  The most recent {clientid}
-- 		that sent a string can be retrieved with expand("<client>").
-- 		Note:
-- 		This id has to be stored before the next command can be
-- 		received.  I.e. before returning from the received command and
-- 		before calling any commands that waits for input.
-- 		See also |clientserver|.
-- 		Example: >
-- 			:echo server2client(expand("<client>"), "HELLO")
--- @return number
function vim.fn.server2client(clientid, string) end

-- Returns a list of server addresses, or empty if all servers
-- 		were stopped. |serverstart()| |serverstop()|
-- 		Example: >
-- 			:echo serverlist()
--- @return string
function vim.fn.serverlist() end

-- Set line {lnum} to {text} in buffer {expr}.  To insert
-- 		lines use |append()|.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		{lnum} is used like with |setline()|.
-- 		This works like |setline()| for the specified buffer.
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		If {expr} is not a valid buffer or {lnum} is not valid, an
-- 		error message is given.
--- @return number
function vim.fn.setbufline(expr, lnum, line) end

-- Set option or local variable {varname} in buffer {expr} to
-- 		{val}.
-- 		This also works for a global or local window option, but it
-- 		doesn't work for a global or local window variable.
-- 		For a local window option the global value is unchanged.
-- 		For the use of {expr}, see |bufname()| above.
-- 		Note that the variable name without "b:" must be used.
-- 		Examples: >
-- 			:call setbufvar(1, "&mod", 1)
-- 			:call setbufvar("todo", "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @return set
function vim.fn.setbufvar(expr, varname, val) end

-- Set the current character search information to {dict},
-- 		which contains one or more of the following entries:
--
-- 		    char	character which will be used for a subsequent
-- 				|,| or |;| command; an empty string clears the
-- 				character search
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to save/restore a user's character search
-- 		from a script: >
-- 			:let prevsearch = getcharsearch()
-- 			:" Perform a command which clobbers user's search
-- 			:call setcharsearch(prevsearch)
-- <		Also see |getcharsearch()|.
--- @param dict dictionary
--- @return dict
function vim.fn.setcharsearch(dict) end

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

-- Set the cursor position in the command line to byte position
-- 		{pos}.  The first position is 1.
-- 		Use |getcmdpos()| to obtain the current position.
-- 		Only works while editing the command line, thus you must use
-- 		|c_CTRL-\_e|, |c_CTRL-R_=| or |c_CTRL-R_CTRL-R| with '='.  For
-- 		|c_CTRL-\_e| and |c_CTRL-R_CTRL-R| with '=' the position is
-- 		set after the command line is set to the expression.  For
-- 		|c_CTRL-R_=| it is set after evaluating the expression but
-- 		before inserting the resulting text.
-- 		When the number is too big the cursor is put at the end of the
-- 		line.  A number smaller than one has undefined results.
-- 		Returns 0 when successful, 1 when not editing the command
-- 		line.
--- @return number
function vim.fn.setcmdpos(pos) end

-- Restores a list of matches saved by |getmatches() for the
-- 		current window|.  Returns 0 if successful, otherwise -1.  All
-- 		current matches are cleared before the list is restored.  See
-- 		example for |getmatches()|.
--- @param list any[]
--- @return number
function vim.fn.setmatches(list) end

-- Set tab-local variable {varname} to {val} in tab page {tabnr}.
-- 		|t:var|
-- 		Note that the variable name without "t:" must be used.
-- 		Tabs are numbered starting with one.
-- 		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabvar(nr, varname, val) end

-- Set option or local variable {varname} in window {winnr} to
-- 		{val}.
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |setwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global or local buffer option, but it
-- 		doesn't work for a global or local buffer variable.
-- 		For a local buffer option the global value is unchanged.
-- 		Note that the variable name without "w:" must be used.
-- 		Examples: >
-- 			:call settabwinvar(1, 1, "&list", 0)
-- 			:call settabwinvar(3, 2, "myvar", "foobar")
-- <		This function is not available in the |sandbox|.
--- @return set
function vim.fn.settabwinvar(tabnr, winnr, varname, val) end

-- Return the current character search information as a {dict}
-- 		with the following entries:
--
-- 		    char	character previously used for a character
-- 				search (|t|, |f|, |T|, or |F|); empty string
-- 				if no character search has been performed
-- 		    forward	direction of character search; 1 for forward,
-- 				0 for backward
-- 		    until	type of character search; 1 for a |t| or |T|
-- 				character search, 0 for an |f| or |F|
-- 				character search
--
-- 		This can be useful to always have |;| and |,| search
-- 		forward/backward regardless of the direction of the previous
-- 		character search: >
-- 			:nnoremap <expr> ; getcharsearch().forward ? ';' : ','
-- 			:nnoremap <expr> , getcharsearch().forward ? ',' : ';'
-- <		Also see |setcharsearch()|.
--- @return dict
function vim.fn.getcharsearch() end

-- Returns a String with 64 hex characters, which is the SHA256
-- 		checksum of {string}.
--- @return string
function vim.fn.sha256(string) end

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

-- Return a list of signs placed in a buffer or all the buffers.
-- 		This is similar to the |:sign-place-list| command.
--
-- 		If the optional buffer name {expr} is specified, then only the
-- 		list of signs placed in that buffer is returned.  For the use
-- 		of {expr}, see |bufname()|. The optional {dict} can contain
-- 		the following entries:
-- 		   group	select only signs in this group
-- 		   id		select sign with this identifier
-- 		   lnum		select signs placed in this line. For the use
-- 				of {lnum}, see |line()|.
-- 		If {group} is '*', then signs in all the groups including the
-- 		global group are returned. If {group} is not supplied or is an
-- 		empty string, then only signs in the global group are
-- 		returned.  If no arguments are supplied, then signs in the
-- 		global group placed in all the buffers are returned.
-- 		See |sign-group|.
--
-- 		Each list item in the returned value is a dictionary with the
-- 		following entries:
-- 			bufnr	number of the buffer with the sign
-- 			signs	list of signs placed in {bufnr}. Each list
-- 				item is a dictionary with the below listed
-- 				entries
--
-- 		The dictionary for each sign contains the following entries:
-- 			group	sign group. Set to '' for the global group.
-- 			id	identifier of the sign
-- 			lnum	line number where the sign is placed
-- 			name	name of the defined sign
-- 			priority	sign priority
--
-- 		The returned signs in a buffer are ordered by their line
-- 		number and priority.
--
-- 		Returns an empty list on failure or if there are no placed
-- 		signs.
--
-- 		Examples: >
-- 			" Get a List of signs placed in eval.c in the
-- 			" global group
-- 			echo sign_getplaced("eval.c")
--
-- 			" Get a List of signs in group 'g1' placed in eval.c
-- 			echo sign_getplaced("eval.c", {'group' : 'g1'})
--
-- 			" Get a List of signs placed at line 10 in eval.c
-- 			echo sign_getplaced("eval.c", {'lnum' : 10})
--
-- 			" Get sign with identifier 10 placed in a.py
-- 			echo sign_getplaced("a.py", {'id' : 10})
--
-- 			" Get sign with id 20 in group 'g1' placed in a.py
-- 			echo sign_getplaced("a.py", {'group' : 'g1',
-- 							\  'id' : 20})
--
-- 			" Get a List of all the placed signs
-- 			echo sign_getplaced()
-- <
--- @param dict dictionary
--- @return list
function vim.fn.sign_getplaced(expr, dict) end

-- Open the buffer {expr} or jump to the window that contains
-- 		{expr} and position the cursor at sign {id} in group {group}.
-- 		This is similar to the |:sign-jump| command.
--
-- 		For the use of {expr}, see |bufname()|.
--
-- 		Returns the line number of the sign. Returns -1 if the
-- 		arguments are invalid.
--
-- 		Example: >
-- 			" Jump to sign 10 in the current buffer
-- 			call sign_jump(10, '', '')
-- <
--- @return number
function vim.fn.sign_jump(id, group, expr) end

-- Without an argument returns the name of the normal font being
-- 		used.  Like what is used for the Normal highlight group
-- 		|hl-Normal|.
-- 		With an argument a check is done whether {name} is a valid
-- 		font name.  If not then an empty string is returned.
-- 		Otherwise the actual font name is returned, or {name} if the
-- 		GUI does not support obtaining the real name.
-- 		Only works when the GUI is running, thus not in your vimrc or
-- 		gvimrc file.  Use the |GUIEnter| autocommand to use this
-- 		function just after the GUI has started.
--- @return string
function vim.fn.getfontname(name) end

-- The result is a String, which is the read, write, and execute
-- 		permissions of the given file {fname}.
-- 		If {fname} does not exist or its directory cannot be read, an
-- 		empty string is returned.
-- 		The result is of the form "rwxrwxrwx", where each group of
-- 		"rwx" flags represent, in turn, the permissions of the owner
-- 		of the file, the group the file belongs to, and other users.
-- 		If a user does not have a given permission the flag for this
-- 		is replaced with the string "-".  Examples: >
-- 			:echo getfperm("/etc/passwd")
-- 			:echo getfperm(expand("~/.config/nvim/init.vim"))
-- <		This will hopefully (from a security point of view) display
-- 		the string "rw-r--r--" or even "rw-------".
--
-- 		For setting permissions use |setfperm()|.
--- @return string
function vim.fn.getfperm(fname) end

-- The result is a Number, which is the size in bytes of the
-- 		given file {fname}.
-- 		If {fname} is a directory, 0 is returned.
-- 		If the file {fname} can't be found, -1 is returned.
-- 		If the size of {fname} is too big to fit in a Number then -2
-- 		is returned.
--- @return number
function vim.fn.getfsize(fname) end

-- Simplify the file name as much as possible without changing
-- 		the meaning.  Shortcuts (on MS-Windows) or symbolic links (on
-- 		Unix) are not resolved.  If the first path component in
-- 		{filename} designates the current directory, this will be
-- 		valid for the result as well.  A trailing path separator is
-- 		not removed either.
-- 		Example: >
-- 			simplify("./dir/.././/file/") == "./file/"
-- <		Note: The combination "dir/.." is only removed if "dir" is
-- 		a searchable directory or does not exist.  On Unix, it is also
-- 		removed when "dir" is a symbolic link within the same
-- 		directory.  In order to resolve all the involved symbolic
-- 		links before simplifying the path name, use |resolve()|.
--- @return string
function vim.fn.simplify(filename) end

-- The result is a String, which is a description of the kind of
-- 		file of the given file {fname}.
-- 		If {fname} does not exist an empty string is returned.
-- 		Here is a table over different kinds of files and their
-- 		results:
-- 			Normal file		"file"
-- 			Directory		"dir"
-- 			Symbolic link		"link"
-- 			Block device		"bdev"
-- 			Character device	"cdev"
-- 			Socket			"socket"
-- 			FIFO			"fifo"
-- 			All other		"other"
-- 		Example: >
-- 			getftype("/home")
-- <		Note that a type such as "link" will only be returned on
-- 		systems that support it.  On some systems only "dir" and
-- 		"file" are returned.
--- @return string
function vim.fn.getftype(fname) end

-- Returns the |jumplist| for the specified window.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		{winnr} can also be a |window-ID|.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
--
-- 		The returned list contains two entries: a list with the jump
-- 		locations and the last used jump position number in the list.
-- 		Each entry in the jump location list is a dictionary with
-- 		the following entries:
-- 			bufnr		buffer number
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			filename	filename if available
-- 			lnum		line number
--- @return list
function vim.fn.getjumplist(winnr, tabnr) end

-- Return the sound-folded equivalent of {word}.  Uses the first
-- 		language in 'spelllang' for the current window that supports
-- 		soundfolding.  'spell' must be set.  When no sound folding is
-- 		possible the {word} is returned unmodified.
-- 		This can be used for making spelling suggestions.  Note that
-- 		the method can be quite slow.
--- @return string
function vim.fn.soundfold(word) end

-- Returns a list with all the entries in the location list for
-- 		window {nr}.  {nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero the current window is used.
--
-- 		For a location list window, the displayed location list is
-- 		returned.  For an invalid window number {nr}, an empty list is
-- 		returned. Otherwise, same as |getqflist()|.
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		returns the items listed in {what} as a dictionary. Refer to
-- 		|getqflist()| for the supported items in {what}.
-- 		If {what} contains 'filewinid', then returns the id of the
-- 		window used to display files from the location list. This
-- 		field is applicable only when called from a location list
-- 		window.
--- @return list
function vim.fn.getloclist(nr, what) end

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

-- Returns a |List| with all matches previously defined for the
-- 		current window by |matchadd()| and the |:match| commands.
-- 		|getmatches()| is useful in combination with |setmatches()|,
-- 		as |setmatches()| can restore a list of matches saved by
-- 		|getmatches()|.
-- 		Example: >
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:let m = getmatches()
-- 			:call clearmatches()
-- 			:echo getmatches()
-- <			[] >
-- 			:call setmatches(m)
-- 			:echo getmatches()
-- <			[{'group': 'MyGroup1', 'pattern': 'TODO',
-- 			'priority': 10, 'id': 1}, {'group': 'MyGroup2',
-- 			'pattern': 'FIXME', 'priority': 10, 'id': 2}] >
-- 			:unlet m
-- <
--- @return list
function vim.fn.getmatches() end

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

-- The result is a String, which is type of register {regname}.
-- 		The value will be one of:
-- 		    "v"			for |charwise| text
-- 		    "V"			for |linewise| text
-- 		    "<CTRL-V>{width}"	for |blockwise-visual| text
-- 		    ""			for an empty or unknown register
-- 		<CTRL-V> is one character with value 0x16.
-- 		If {regname} is not specified, |v:register| is used.
--- @return string
function vim.fn.getregtype(regname) end

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

-- Get the value of a tab-local variable {varname} in tab page
-- 		{tabnr}. |t:var|
-- 		Tabs are numbered starting with one.
-- 		When {varname} is empty a dictionary with all tab-local
-- 		variables is returned.
-- 		Note that the name without "t:" must be used.
-- 		When the tab or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
function vim.fn.gettabvar(nr, varname, def) end

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

-- Get the value of window-local variable {varname} in window
-- 		{winnr} in tab page {tabnr}.
-- 		When {varname} is empty a dictionary with all window-local
-- 		variables is returned.
-- 		When {varname} is equal to "&" get the values of all
-- 		window-local options in a Dictionary.
-- 		Otherwise, when {varname} starts with "&" get the value of a
-- 		window-local option.
-- 		Note that {varname} must be the name without "w:".
-- 		Tabs are numbered starting with one.  For the current tabpage
-- 		use |getwinvar()|.
-- 		{winnr} can be the window number or the |window-ID|.
-- 		When {winnr} is zero the current window is used.
-- 		This also works for a global option, buffer-local option and
-- 		window-local option, but it doesn't work for a global variable
-- 		or buffer-local variable.
-- 		When the tab, window or variable doesn't exist {def} or an
-- 		empty string is returned, there is no error message.
-- 		Examples: >
-- 			:let list_is_on = gettabwinvar(1, 2, '&list')
-- 			:echo "myvar = " . gettabwinvar(3, 1, 'myvar')
-- <
-- 		To obtain all window-local variables use: >
-- 			gettabwinvar({tabnr}, {winnr}, '&')
function vim.fn.gettabwinvar(tabnr, winnr, name, def) end

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

-- The result is a Dict, which is the tag stack of window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is not specified, the current window is used.
-- 		When window {nr} doesn't exist, an empty Dict is returned.
--
-- 		The returned dictionary contains the following entries:
-- 			curidx		Current index in the stack. When at
-- 					top of the stack, set to (length + 1).
-- 					Index of bottom of the stack is 1.
-- 			items		List of items in the stack. Each item
-- 					is a dictionary containing the
-- 					entries described below.
-- 			length		Number of entries in the stack.
--
-- 		Each item in the stack is a dictionary with the following
-- 		entries:
-- 			bufnr		buffer number of the current jump
-- 			from		cursor position before the tag jump.
-- 					See |getpos()| for the format of the
-- 					returned list.
-- 			matchnr		current matching tag number. Used when
-- 					multiple matching tags are found for a
-- 					name.
-- 			tagname		name of the tag
--
-- 		See |tagstack| for more information about the tag stack.
--- @return dict
function vim.fn.gettagstack(nr) end

-- Return the current time, measured as seconds since 1st Jan
-- 		1970.  See also |strftime()| and |getftime()|.
--- @return number
function vim.fn.localtime() end

-- The result is a copy of the String given, with all lowercase
-- 		characters turned into uppercase (just like applying |gU| to
-- 		the string).
--- @return string
function vim.fn.toupper(expr) end

-- the left hand side of the GUI Vim window.  The result will be
-- 		-1 if the information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposx() end

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- {expr} in bytes.
-- 		If the argument is a Number it is first converted to a String.
-- 		For other types an error is given.
-- 		If you want to count the number of multi-byte characters use
-- 		|strchars()|.
-- 		Also see |len()|, |strdisplaywidth()| and |strwidth()|.
--- @return number
function vim.fn.strlen(expr) end

-- position given with {expr}.  The accepted positions are:
-- 		    .	    the cursor position
-- 		    $	    the last line in the current buffer
-- 		    'x	    position of mark x (if the mark is not set, 0 is
-- 			    returned)
-- 		    w0	    first line visible in current window (one if the
-- 			    display isn't updated, e.g. in silent Ex mode)
-- 		    w$	    last line visible in current window (this is one
-- 			    less than "w0" if no lines are visible)
-- 		    v	    In Visual mode: the start of the Visual area (the
-- 			    cursor is the end).  When not in Visual mode
-- 			    returns the cursor position.  Differs from |'<| in
-- 			    that it's updated right away.
-- 		Note that a mark in another file can be used.  The line number
-- 		then applies to another buffer.
-- 		To get the column number use |col()|.  To get both use
-- 		|getpos()|.
-- 		Examples: >
-- 			line(".")		line number of the cursor
-- 			line("'t")		line number of mark t
-- 			line("'" . marker)	line number of mark marker
--- @return number
function vim.fn.line(expr) end

-- Return a list of command-line completion matches. {type}
-- 		specifies what for.  The following completion types are
-- 		supported:
--
-- 		arglist		file names in argument list
-- 		augroup		autocmd groups
-- 		buffer		buffer names
-- 		behave		:behave suboptions
-- 		cmdline		|cmdline-completion|
-- 		color		color schemes
-- 		command		Ex command (and arguments)
-- 		compiler	compilers
-- 		cscope		|:cscope| suboptions
-- 		dir		directory names
-- 		environment	environment variable names
-- 		event		autocommand events
-- 		expression	Vim expression
-- 		file		file and directory names
-- 		file_in_path	file and directory names in |'path'|
-- 		filetype	filetype names |'filetype'|
-- 		function	function name
-- 		help		help subjects
-- 		highlight	highlight groups
-- 		history		:history suboptions
-- 		locale		locale names (as output of locale -a)
-- 		mapclear        buffer argument
-- 		mapping		mapping name
-- 		menu		menus
-- 		messages	|:messages| suboptions
-- 		option		options
-- 		packadd		optional package |pack-add| names
-- 		shellcmd	Shell command
-- 		sign		|:sign| suboptions
-- 		syntax		syntax file names |'syntax'|
-- 		syntime		|:syntime| suboptions
-- 		tag		tags
-- 		tag_listfiles	tags, file names
-- 		user		user names
-- 		var		user variables
--
-- 		If {pat} is an empty string then all matches are returned.
-- 		Otherwise only items matching {pat} are returned. See
-- 		|wildcards| for the use of special characters in {pat}.
--
-- 		If the optional {filtered} flag is set to 1, then 'wildignore'
-- 		is applied to filter the results.  Otherwise all the matches
-- 		are returned. The 'wildignorecase' option always applies.
--
-- 		If there are no matches, an empty list is returned.  An
-- 		invalid value for {type} produces an error.
--- @return list
function vim.fn.getcompletion(pat, type, filtered) end

-- Convert a file pattern, as used by glob(), into a search
-- 		pattern.  The result can be used to match with a string that
-- 		is a file name.  E.g. >
-- 			if filename =~ glob2regpat('Make*.mak')
-- <		This is equivalent to: >
-- 			if filename =~ '^Make.*\.mak$'
-- <		When {expr} is an empty string the result is "^$", match an
-- 		empty string.
-- 		Note that the result depends on the system.  On MS-Windows
-- 		a backslash usually means a path separator.
--- @return string
function vim.fn.glob2regpat(expr) end

-- Perform glob() on all directories in {path} and concatenate
-- 		the results.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim")
-- <
-- 		{path} is a comma-separated list of directory names.  Each
-- 		directory name is prepended to {expr} and expanded like with
-- 		|glob()|.  A path separator is inserted when needed.
-- 		To add a comma inside a directory name escape it with a
-- 		backslash.  Note that on MS-Windows a directory may have a
-- 		trailing backslash, remove it if you put a comma after it.
-- 		If the expansion fails for one of the directories, there is no
-- 		error message.
--
-- 		Unless the optional {nosuf} argument is given and is |TRUE|,
-- 		the 'suffixes' and 'wildignore' options apply: Names matching
-- 		one of the patterns in 'wildignore' will be skipped and
-- 		'suffixes' affect the ordering of matches.
--
-- 		When {list} is present and it is |TRUE| the result is a List
-- 		with all matching files. The advantage of using a List is, you
-- 		also get filenames containing newlines correctly. Otherwise
-- 		the result is a String and when there are several matches,
-- 		they are separated by <NL> characters.  Example: >
-- 			:echo globpath(&rtp, "syntax/c.vim", 0, 1)
-- <
-- 		{allinks} is used as with |glob()|.
--
-- 		The "**" item can be used to search in a directory tree.
-- 		For example, to find all "README.txt" files in the directories
-- 		in 'runtimepath' and below: >
-- 			:echo globpath(&rtp, "**/README.txt")
-- <		Upwards search and limiting the depth of "**" is not
-- 		supported, thus using 'path' will not always work properly.
--- @param list any[]
--- @return string
function vim.fn.globpath(path, expr, nosuf, list, alllinks) end

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

-- This is a unique number, until Vim exits.
--- @return number
function vim.fn.getpid() end

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

-- Add the String {item} to the history {history} which can be
-- 		one of:					*hist-names*
-- 			"cmd"	 or ":"	  command line history
-- 			"search" or "/"   search pattern history
-- 			"expr"	 or "="   typed expression history
-- 			"input"  or "@"	  input line history
-- 			"debug"  or ">"   debug command history
-- 			empty		  the current or last used history
-- 		The {history} string does not need to be the whole name, one
-- 		character is sufficient.
-- 		If {item} does already exist in the history, it will be
-- 		shifted to become the newest entry.
-- 		The result is a Number: 1 if the operation was successful,
-- 		otherwise 0 is returned.
--
-- 		Example: >
-- 			:call histadd("input", strftime("%Y %b %d"))
-- 			:let date=input("Enter date: ")
-- <		This function is not available in the |sandbox|.
--- @return string
function vim.fn.histadd(history, item) end

-- Clear {history}, i.e. delete all its entries.  See |hist-names|
-- 		for the possible values of {history}.
--
-- 		If the parameter {item} evaluates to a String, it is used as a
-- 		regular expression.  All entries matching that expression will
-- 		be removed from the history (if there are any).
-- 		Upper/lowercase must match, unless "\c" is used |/\c|.
-- 		If {item} evaluates to a Number, it will be interpreted as
-- 		an index, see |:history-indexing|.  The respective entry will
-- 		be removed if it exists.
--
-- 		The result is a Number: 1 for a successful operation,
-- 		otherwise 0 is returned.
--
-- 		Examples:
-- 		Clear expression register history: >
-- 			:call histdel("expr")
-- <
-- 		Remove all entries starting with "*" from the search history: >
-- 			:call histdel("/", '^\*')
-- <
-- 		The following three are equivalent: >
-- 			:call histdel("search", histnr("search"))
-- 			:call histdel("search", -1)
-- 			:call histdel("search", '^'.histget("search", -1).'$')
-- <
-- 		To delete the last search pattern and use the last-but-one for
-- 		the "n" command and 'hlsearch': >
-- 			:call histdel("search", -1)
-- 			:let @/ = histget("search", -1)
--- @return string
function vim.fn.histdel(history, item) end

-- The result is a List with currently three items:
-- 		1. The first item in the list is 0 if the character at the
-- 		   position {lnum} and {col} is not part of a concealable
-- 		   region, 1 if it is.
-- 		2. The second item in the list is a string. If the first item
-- 		   is 1, the second item contains the text which will be
-- 		   displayed in place of the concealed text, depending on the
-- 		   current setting of 'conceallevel' and 'listchars'.
-- 		3. The third and final item in the list is a number
-- 		   representing the specific syntax region matched in the
-- 		   line. When the character is not concealed the value is
-- 		   zero. This allows detection of the beginning of a new
-- 		   concealable region if there are two consecutive regions
-- 		   with the same replacement character.  For an example, if
-- 		   the text is "123456" and both "23" and "45" are concealed
-- 		   and replaced by the character "X", then:
-- 			call			returns ~
-- 		   	synconcealed(lnum, 1)   [0, '', 0]
-- 		   	synconcealed(lnum, 2)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 3)   [1, 'X', 1]
-- 		   	synconcealed(lnum, 4)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 5)   [1, 'X', 2]
-- 		   	synconcealed(lnum, 6)   [0, '', 0]
--- @return list
function vim.fn.synconcealed(lnum, col) end

-- The result is a String, which is the name of the machine on
-- 		which Vim is currently running.  Machine names greater than
-- 		256 characters long are truncated.
--- @return string
function vim.fn.hostname() end

-- Get character {index} from {str}.  This uses a character
-- 		index, not a byte index.  Composing characters are considered
-- 		separate characters here.
-- 		Also see |strcharpart()| and |strchars()|.
--- @return number
function vim.fn.strgetchar(str, index) end

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

