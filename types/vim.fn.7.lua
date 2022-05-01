--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Call function {func} with the items in |List| {arglist} as
-- 		arguments.
-- 		{func} can either be a |Funcref| or the name of a function.
-- 		a:firstline and a:lastline are set to the cursor line.
-- 		Returns the return value of the called function.
-- 		{dict} is for functions with the "dict" attribute.  It will be
-- 		used to set the local variable "self". |Dictionary-function|
--- @param dict dictionary
function vim.fn.call(func, arglist, dict) end

-- Change properties of an existing text property type.  If a
-- 		property with this name does not exist an error is given.
-- 		The {props} argument is just like |prop_type_add()|.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_change(props)
--- @return none
function vim.fn.prop_type_change(name, props) end

-- Set environment variable {name} to {val}.
-- 		When {val} is |v:null| the environment variable is deleted.
-- 		See also |expr-env|.
--- @return none
function vim.fn.setenv(name, val) end

-- Return the hyperbolic tangent of {expr} as a |Float| in the
-- 		range [-1, 1].
-- 		{expr} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo tanh(0.5)
-- <			0.462117 >
-- 			:echo tanh(-1)
-- <			-0.761594
--- @return float
function vim.fn.tanh(expr) end

-- Evaluate Ruby expression {expr} and return its result
-- 		converted to Vim data structures.
-- 		Numbers, floats and strings are returned as they are (strings
-- 		are copied though).
-- 		Arrays are represented as Vim |List| type.
-- 		Hashes are represented as Vim |Dictionary| type.
-- 		Other objects are represented as strings resulted from their
-- 		"Object#to_s" method.
--
-- 		Can also be used as a |method|: >
-- 			GetRubyExpr()->rubyeval()
--
-- <		{only available when compiled with the |+ruby| feature}
function vim.fn.rubyeval(expr) end

-- Return the arc tangent of {expr1} / {expr2}, measured in
-- 		radians, as a |Float| in the range [-pi, pi].
-- 		{expr1} and {expr2} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo atan2(-1, 1)
-- <			-0.785398 >
-- 			:echo atan2(1, -1)
-- <			2.356194
--- @return float
function vim.fn.atan2(expr, expr) end

-- Return the power of {x} to the exponent {y} as a |Float|.
-- 		{x} and {y} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo pow(3, 3)
-- <			27.0 >
-- 			:echo pow(2, 16)
-- <			65536.0 >
-- 			:echo pow(32, 0.20)
-- <			2.0
--- @return float
function vim.fn.pow(x, y) end

-- Return the remainder of {expr1} / {expr2}, even if the
-- 		division is not representable.  Returns {expr1} - i * {expr2}
-- 		for some integer i such that if {expr2} is non-zero, the
-- 		result has the same sign as {expr1} and magnitude less than
-- 		the magnitude of {expr2}.  If {expr2} is zero, the value
-- 		returned is zero.  The value returned is a |Float|.
-- 		{expr1} and {expr2} must evaluate to a |Float| or a |Number|.
-- 		Examples: >
-- 			:echo fmod(12.33, 1.22)
-- <			0.13 >
-- 			:echo fmod(-12.33, 1.22)
-- <			-0.13
--- @return float
function vim.fn.fmod(expr1, expr2) end

-- The result is a String that contains the base character and
-- 		any composing characters at position [row, col] on the screen.
-- 		This is like |screenchars()| but returning a String with the
-- 		characters.
-- 		This is mainly to be used for testing.
-- 		Returns an empty String when row or col is out of range.
--
-- 		Can also be used as a |method|: >
-- 			GetRow()->screenstring(col)
--- @return string
function vim.fn.screenstring(row, col) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the minimum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
-- 		an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.min(expr) end

--- @param list any[]
--- @return list
function vim.fn.sign_placelist(list) end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- Like `sound_playevent()` but play sound file {path}.  {path}
-- 		must be a full path.  On Ubuntu you may find files to play
-- 		with this command: >
-- 		    :!find /usr/share/sounds -type f | grep -v index.theme
--
-- <		Can also be used as a |method|: >
-- 			GetSoundPath()->sound_playfile()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return number
function vim.fn.sound_playfile(path, callback) end

-- Stop playing sound {id}.  {id} must be previously returned by
-- 		`sound_playevent()` or `sound_playfile()`.
--
-- 		On MS-Windows, this does not work for event sound started by
-- 		`sound_playevent()`. To stop event sounds, use `sound_clear()`.
--
-- 		Can also be used as a |method|: >
-- 			soundid->sound_stop()
--
-- <		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_stop(id) end

-- Set the size of terminal {buf}. The size of the window
-- 		containing the terminal will also be adjusted, if possible.
-- 		If {rows} or {cols} is zero or negative, that dimension is not
-- 		changed.
--
-- 		{buf} must be the buffer number of a terminal window.  Use an
-- 		empty string for the current buffer.  If the buffer does not
-- 		exist or is not a terminal window, an error is given.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setsize(rows, cols)
--- @return none
function vim.fn.term_setsize(buf, rows, cols) end

-- Initialize seed used by |rand()|:
-- 		- If {expr} is not given, seed values are initialized by
-- 		  reading from /dev/urandom, if possible, or using time(NULL)
-- 		  a.k.a. epoch time otherwise; this only has second accuracy.
-- 		- If {expr} is given it must be a Number.  It is used to
-- 		  initialize the seed values.  This is useful for testing or
-- 		  when a predictable sequence is intended.
--
-- 		Examples: >
-- 			:let seed = srand()
-- 			:let seed = srand(userinput)
-- 			:echo rand(seed)
--- @return list
function vim.fn.srand(expr) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

-- Open a new window displaying the difference between the two
-- 		files.  The files must have been created with
-- 		|term_dumpwrite()|.
-- 		Returns the buffer number or zero when the diff fails.
-- 		Also see |terminal-diff|.
-- 		NOTE: this does not work with double-width characters yet.
--
-- 		The top part of the buffer contains the contents of the first
-- 		file, the bottom part of the buffer contains the contents of
-- 		the second file.  The middle part shows the differences.
-- 		The parts are separated by a line of equals.
--
-- 		If the {options} argument is present, it must be a Dict with
-- 		these possible members:
-- 		   "term_name"	     name to use for the buffer name, instead
-- 				     of the first file name.
-- 		   "term_rows"	     vertical size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "term_cols"	     horizontal size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "vertical"	     split the window vertically
-- 		   "curwin"	     use the current window, do not split the
-- 				     window; fails if the current buffer
-- 				     cannot be |abandon|ed
-- 		   "bufnr"	     do not create a new buffer, use the
-- 				     existing buffer "bufnr".  This buffer
-- 				     must have been previously created with
-- 				     term_dumpdiff() or term_dumpload() and
-- 				     visible in a window.
-- 		   "norestore"	     do not add the terminal window to a
-- 				     session file
--
-- 		Each character in the middle part indicates a difference. If
-- 		there are multiple differences only the first in this list is
-- 		used:
-- 			X	different character
-- 			w	different width
-- 			f	different foreground color
-- 			b	different background color
-- 			a	different attribute
-- 			+	missing position in first file
-- 			-	missing position in second file
--
-- 		Using the "s" key the top and bottom parts are swapped.  This
-- 		makes it easy to spot a difference.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpdiff(otherfile)
-- <
--- @return number
function vim.fn.term_dumpdiff(filename, filename, options) end

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- Get the cursor position of terminal {buf}. Returns a list with
-- 		two numbers and a dictionary: [row, col, dict].
--
-- 		"row" and "col" are one based, the first screen cell is row
-- 		1, column 1.  This is the cursor position of the terminal
-- 		itself, not of the Vim window.
--
-- 		"dict" can have these members:
-- 		   "visible"	one when the cursor is visible, zero when it
-- 				is hidden.
-- 		   "blink"	one when the cursor is blinking, zero when it
-- 				is not blinking.
-- 		   "shape"	1 for a block cursor, 2 for underline and 3
-- 				for a vertical bar.
-- 		   "color"	color of the cursor, e.g. "green"
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getcursor()
--- @return list
function vim.fn.term_getcursor(buf) end

-- Get a line of text from the terminal window of {buf}.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		The first line has {row} one.  When {row} is "." the cursor
-- 		line is used.  When {row} is invalid an empty string is
-- 		returned.
--
-- 		To get attributes of each character use |term_scrape()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getline(row)
--- @return string
function vim.fn.term_getline(buf, row) end

-- Return the position of the cursor in the command line as a
-- 		byte count.  The first column is 1.
-- 		Only works when editing the command line, thus requires use of
-- 		|c_CTRL-\_e| or |c_CTRL-R_=| or an expression mapping.
-- 		Returns 0 otherwise.
-- 		Also see |getcmdtype()|, |setcmdpos()| and |getcmdline()|.
--- @return number
function vim.fn.getcmdpos() end

-- Return byte index of the {nr}'th character in the string
-- 		{expr}.  Use zero for the first character, it returns zero.
-- 		This function is only useful when there are multibyte
-- 		characters, otherwise the returned value is equal to {nr}.
-- 		Composing characters are not counted separately, their byte
-- 		length is added to the preceding base character.  See
-- 		|byteidxcomp()| below for counting composing characters
-- 		separately.
-- 		Example : >
-- 			echo matchstr(str, ".", byteidx(str, 3))
-- <		will display the fourth character.  Another way to do the
-- 		same: >
-- 			let s = strpart(str, byteidx(str, 3))
-- 			echo strpart(s, 0, byteidx(s, 1))
-- <		Also see |strgetchar()| and |strcharpart()|.
--
-- 		If there are less than {nr} characters -1 is returned.
-- 		If there are exactly {nr} characters the length of the string
-- 		in bytes is returned.
--- @return number
function vim.fn.byteidx(expr, nr) end

-- Get the size of terminal {buf}. Returns a list with two
-- 		numbers: [rows, cols].  This is the size of the terminal, not
-- 		the window containing the terminal.
--
-- 		{buf} must be the buffer number of a terminal window.  Use an
-- 		empty string for the current buffer.  If the buffer does not
-- 		exist or is not a terminal window, an empty list is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getsize()
--- @return list
function vim.fn.term_getsize(buf) end

-- Get the status of terminal {buf}. This returns a comma
-- 		separated list of these items:
-- 			running		job is running
-- 			finished	job has finished
-- 			normal		in Terminal-Normal mode
-- 		One of "running" or "finished" is always present.
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		string is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getstatus()
--- @return string
function vim.fn.term_getstatus(buf) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the maximum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
--                 an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.max(expr) end

-- Get the title of terminal {buf}. This is the title that the
-- 		job in the terminal has set.
--
-- 		{buf} must be the buffer number of a terminal window. If the
-- 		buffer does not exist or is not a terminal window, an empty
-- 		string is returned.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_gettitle()
--- @return string
function vim.fn.term_gettitle(buf) end

-- includes an extra item in the list:
-- 		    [bufnum, lnum, col, off, curswant] ~
--  		The "curswant" number is the preferred column when moving the
-- 		cursor vertically.  Also see |getpos()|.
--
--  		This can be used to save and restore the cursor position: >
--  			let save_cursor = getcurpos()
--  			MoveTheCursorAround
--  			call setpos('.', save_cursor)
-- <		Note that this only works within the window.  See
-- 		|winrestview()| for restoring more state.
--- @return list
function vim.fn.getcurpos() end

-- Get the name of the controlling terminal associated with
-- 		terminal window {buf}.  {buf} is used as with |term_getsize()|.
--
-- 		When {input} is omitted or 0, return the name for writing
-- 		(stdout). When {input} is 1 return the name for reading
-- 		(stdin). On UNIX, both return same name.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_gettty()
--- @return string
function vim.fn.term_gettty(buf, input) end

-- Like |settabwinvar()| for the current tab page.
-- 		Examples: >
-- 			:call setwinvar(1, "&list", 0)
-- 			:call setwinvar(2, "myvar", "foobar")
--- @return set
function vim.fn.setwinvar(nr, varname, val) end

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

