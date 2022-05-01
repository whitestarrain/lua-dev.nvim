--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

-- Returns the effective value of 'shiftwidth'. This is the
-- 		'shiftwidth' value unless it is zero, in which case it is the
-- 		'tabstop' value.  To be backwards compatible in indent
-- 		plugins, use this: >
-- 			if exists('*shiftwidth')
-- 			  func s:sw()
-- 			    return shiftwidth()
-- 			  endfunc
-- 			else
-- 			  func s:sw()
-- 			    return &sw
-- 			  endfunc
-- 			endif
-- <		And then use s:sw() instead of &sw.
--- @return number
function vim.fn.shiftwidth() end

-- Convert a list of VimL objects to msgpack. Returned value is
-- 		|readfile()|-style list. Example: >
-- 			call writefile(msgpackdump([{}]), 'fname.mpack', 'b')
-- <		This will write the single 0x80 byte to `fname.mpack` file
-- 		(dictionary with zero items is represented by 0x80 byte in
-- 		messagepack).
--
-- 		Limitations:				*E5004* *E5005*
-- 		1. |Funcref|s cannot be dumped.
-- 		2. Containers that reference themselves cannot be dumped.
-- 		3. Dictionary keys are always dumped as STR strings.
-- 		4. Other strings are always dumped as BIN strings.
-- 		5. Points 3. and 4. do not apply to |msgpack-special-dict|s.
--- @param list any[]
--- @return list
function vim.fn.msgpackdump(list) end

-- Returns |standard-path| locations of various default files and
-- 		directories.
--
-- 		{what}       Type    Description ~
-- 		cache        String  Cache directory. Arbitrary temporary
-- 		                     storage for plugins, etc.
-- 		config       String  User configuration directory. The
-- 		                     |init.vim| is stored here.
-- 		config_dirs  List    Additional configuration directories.
-- 		data         String  User data directory. The |shada-file|
-- 		                     is stored here.
-- 		data_dirs    List    Additional data directories.
--
-- 		Example: >
-- 			:echo stdpath("config")
--- @return string/list
function vim.fn.stdpath(what) end

-- Set a callback for buffer {buf} to {expr}.  When {expr} is an
-- 		empty string the callback is removed.  This has only effect if
-- 		{buf} has 'buftype' set to "prompt".
--
-- 		This callback will be invoked when pressing CTRL-C in Insert
-- 		mode.  Without setting a callback Vim will exit Insert mode,
-- 		as in any buffer.
--- @return none
function vim.fn.prompt_setinterrupt(buf, text) end

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

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers and strings are returned as they are (strings are
-- 		copied though, Unicode strings are additionally converted to
-- 		UTF-8).
-- 		Lists are represented as Vim |List| type.
-- 		Dictionaries are represented as Vim |Dictionary| type with
-- 		keys converted to strings.
function vim.fn.py3eval(expr) end

-- Evaluate Python expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Uses Python 2 or 3, see |python_x| and 'pyxversion'.
-- 		See also: |pyeval()|, |py3eval()|
function vim.fn.pyxeval(expr) end

-- Check for a key typed while looking for completion matches.
-- 		This is to be used when looking for matches takes some time.
-- 		Returns |TRUE| when searching for matches is to be aborted,
-- 		zero otherwise.
-- 		Only to be used by the function specified with the
-- 		'completefunc' option.
--- @return number
function vim.fn.complete_check() end

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

-- Return the name of the undo file that would be used for a file
-- 		with name {name} when writing.  This uses the 'undodir'
-- 		option, finding directories that exist.  It does not check if
-- 		the undo file exists.
-- 		{name} is always expanded to the full path, since that is what
-- 		is used internally.
-- 		If {name} is empty undofile() returns an empty string, since a
-- 		buffer without a file name will not write an undo file.
-- 		Useful in combination with |:wundo| and |:rundo|.
-- 		When compiled without the |+persistent_undo| option this always
-- 		returns an empty string.
--- @return string
function vim.fn.undofile(name) end

-- Return a Float that represents the time value of {time}.
-- 		Unit of time is seconds.
-- 		Example:
-- 			let start = reltime()
-- 			call MyFunction()
-- 			let seconds = reltimefloat(reltime(start))
-- 		See the note of reltimestr() about overhead.
--  		Also see |profiling|.
--- @return float
function vim.fn.reltimefloat(time) end

-- The result is a Number, which is 1 when a file with the
-- 		name {file} exists, and can be written.  If {file} doesn't
-- 		exist, or is not writable, the result is 0.  If {file} is a
-- 		directory, and we can write to it, the result is 2.
--- @return number
function vim.fn.filewritable(file) end

-- The result is a list with two numbers, the result of
-- 		getwinposx() and getwinposy() combined:
-- 			[x-pos, y-pos]
-- 		{timeout} can be used to specify how long to wait in msec for
-- 		a response from the terminal.  When omitted 100 msec is used.
--- @return list
function vim.fn.getwinpos(timeout) end

-- Send the {string} to {server}.  The string is sent as an
-- 		expression and the result is returned after evaluation.
-- 		The result must be a String or a |List|.  A |List| is turned
-- 		into a String by joining the items with a line break in
-- 		between (not at the end), like with join(expr, "\n").
-- 		If {idvar} is present and not empty, it is taken as the name
-- 		of a variable and a {serverid} for later use with
-- 		|remote_read()| is stored there.
-- 		If {timeout} is given the read times out after this many
-- 		seconds.  Otherwise a timeout of 600 seconds is used.
-- 		See also |clientserver| |RemoteReply|.
-- 		This function is not available in the |sandbox|.
-- 		Note: Any errors will cause a local error message to be issued
-- 		and the result will be the empty string.
--
-- 		Variables will be evaluated in the global namespace,
-- 		independent of a function currently being active.  Except
-- 		when in debug mode, then local function variables and
-- 		arguments can be evaluated.
--
-- 		Examples: >
-- 			:echo remote_expr("gvim", "2+2")
-- 			:echo remote_expr("gvim1", "b:current_syntax")
-- <
--- @return string
function vim.fn.remote_expr(server, string, idvar, timeout) end

--- @param list any[]
--- @return list
function vim.fn.sign_placelist(list) end

-- Move the Vim server with the name {server} to the foreground.
-- 		This works like: >
-- 			remote_expr({server}, "foreground()")
-- <		Except that on Win32 systems the client does the work, to work
-- 		around the problem that the OS doesn't always allow the server
-- 		to bring itself to the foreground.
-- 		Note: This does not restore the window if it was minimized,
-- 		like foreground() does.
-- 		This function is not available in the |sandbox|.
-- 		{only in the Win32 GUI and the Win32 console version}
--- @return number
function vim.fn.remote_foreground(server) end

