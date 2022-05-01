--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- {expr1} and {expr2} must be both |Lists| or both
-- 		|Dictionaries|.
--
-- 		If they are |Lists|: Append {expr2} to {expr1}.
-- 		If {expr3} is given insert the items of {expr2} before item
-- 		{expr3} in {expr1}.  When {expr3} is zero insert before the
-- 		first item.  When {expr3} is equal to len({expr1}) then
-- 		{expr2} is appended.
-- 		Examples: >
-- 			:echo sort(extend(mylist, [7, 5]))
-- 			:call extend(mylist, [2, 3], 1)
-- <		When {expr1} is the same List as {expr2} then the number of
-- 		items copied is equal to the original length of the List.
-- 		E.g., when {expr3} is 1 you get N new copies of the first item
-- 		(where N is the original length of the List).
-- 		Use |add()| to concatenate one item to a list.  To concatenate
-- 		two lists into a new list use the + operator: >
-- 			:let newlist = [1, 2, 3] + [4, 5]
-- <
-- 		If they are |Dictionaries|:
-- 		Add all entries from {expr2} to {expr1}.
-- 		If a key exists in both {expr1} and {expr2} then {expr3} is
-- 		used to decide what to do:
-- 		{expr3} = "keep": keep the value of {expr1}
-- 		{expr3} = "force": use the value of {expr2}
-- 		{expr3} = "error": give an error message		*E737*
-- 		When {expr3} is omitted then "force" is assumed.
--
-- 		{expr1} is changed when {expr2} is not empty.  If necessary
-- 		make a copy of {expr1} first.
-- 		{expr2} remains unchanged.
-- 		When {expr1} is locked and {expr2} is not empty the operation
-- 		fails.
-- 		Returns {expr1}.
--- @return list/dict
function vim.fn.extend(expr1, expr2, expr3) end

-- {expr} can be a list or a dictionary.  For a dictionary,
-- 		it returns the maximum of all values in the dictionary.
-- 		If {expr} is neither a list nor a dictionary, or one of the
-- 		items in {expr} cannot be used as a Number this results in
--                 an error.  An empty |List| or |Dictionary| results in zero.
--- @return number
function vim.fn.max(expr) end

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

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

-- Cleanup unused |Lists| and |Dictionaries| that have circular
-- 		references.
--
-- 		There is hardly ever a need to invoke this function, as it is
-- 		automatically done when Vim runs out of memory or is waiting
-- 		for the user to press a key after 'updatetime'.  Items without
-- 		circular references are always freed when they become unused.
-- 		This is useful if you have deleted a very big |List| and/or
-- 		|Dictionary| with circular references in a script that runs
-- 		for a long time.
--
-- 		When the optional {atexit} argument is one, garbage
-- 		collection will also be done when exiting Vim, if it wasn't
-- 		done before.  This is useful when checking for memory leaks.
--
-- 		The garbage collection is not done immediately but only when
-- 		it's safe to perform.  This is when waiting for the user to
-- 		type a character.
--- @return none
function vim.fn.garbagecollect(atexit) end

-- FileType event has been triggered at least once.  Can be used
-- 		to avoid triggering the FileType event again in the scripts
-- 		that detect the file type. |FileType|
-- 		Returns |FALSE| when `:setf FALLBACK` was used.
-- 		When editing another file, the counter is reset, thus this
-- 		really checks if the FileType event has been triggered for the
-- 		current buffer.  This allows an autocommand that starts
-- 		editing another buffer to set 'filetype' and load a syntax
-- 		file.
--- @return number
function vim.fn.did_filetype() end

-- Returns the number of filler lines above line {lnum}.
-- 		These are the lines that were inserted at this point in
-- 		another diff'ed window.  These filler lines are shown in the
-- 		display but don't exist in the buffer.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Returns 0 if the current window is not in diff mode.
--- @return number
function vim.fn.diff_filler(lnum) end

-- The result is a Number, which is 1 if |Dictionary| {dict} has
-- 		an entry with key {key}.  Zero otherwise.
--- @param dict dictionary
--- @return number
function vim.fn.has_key(dict, key) end

-- Returns 1 if the terminal of {buf} is using the alternate
-- 		screen.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getaltscreen()
--- @return number
function vim.fn.term_getaltscreen(buf) end

-- Return a pseudo-random Number generated with an xoshiro128**
-- 		algorithm using seed {expr}.  The returned number is 32 bits,
-- 		also on 64 bits systems, for consistency.
-- 		{expr} can be initialized by |srand()| and will be updated by
-- 		rand().  If {expr} is omitted, an internal seed value is used
-- 		and updated.
--
-- 		Examples: >
-- 			:echo rand()
-- 			:let seed = srand()
-- 			:echo rand(seed)
-- 			:echo rand(seed) % 16  " random number 0 - 15
-- <
--- @return number
function vim.fn.rand(expr) end

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

-- Filter that can be used for a popup. It handles only the keys
-- 		'y', 'Y' and 'n' or 'N'.  Invokes the "callback" of the
-- 		popup menu with the 1 for 'y' or 'Y' and zero for 'n' or 'N'
-- 		as the second argument.  Pressing Esc and 'x' works like
-- 		pressing 'n'.  CTRL-C invokes the callback with -1.  Other
-- 		keys are ignored.
-- 		See the example here: |popup_dialog-example|
--- @return number
function vim.fn.popup_filter_yesno(id, key) end

-- Return a String with {fmt}, where "%" items are replaced by
-- 		the formatted form of their respective arguments.  Example: >
-- 			printf("%4d: E%d %.30s", lnum, errno, msg)
-- <		May result in:
-- 			"  99: E42 asdfasdfasdfasdfasdfasdfasdfas" ~
--
-- 		Often used items are:
-- 		  %s	string
-- 		  %6S	string right-aligned in 6 display cells
-- 		  %6s	string right-aligned in 6 bytes
-- 		  %.9s	string truncated to 9 bytes
-- 		  %c	single byte
-- 		  %d	decimal number
-- 		  %5d	decimal number padded with spaces to 5 characters
-- 		  %b	binary number
-- 		  %08b	binary number padded with zeros to at least 8 characters
-- 		  %B	binary number using upper case letters
-- 		  %x	hex number
-- 		  %04x	hex number padded with zeros to at least 4 characters
-- 		  %X	hex number using upper case letters
-- 		  %o	octal number
-- 		  %f	floating point number as 12.23, inf, -inf or nan
-- 		  %F	floating point number as 12.23, INF, -INF or NAN
-- 		  %e	floating point number as 1.23e3, inf, -inf or nan
-- 		  %E	floating point number as 1.23E3, INF, -INF or NAN
-- 		  %g	floating point number, as %f or %e depending on value
-- 		  %G	floating point number, as %F or %E depending on value
-- 		  %%	the % character itself
-- 		  %p	representation of the pointer to the container
--
-- 		Conversion specifications start with '%' and end with the
-- 		conversion type.  All other characters are copied unchanged to
-- 		the result.
--
-- 		The "%" starts a conversion specification.  The following
-- 		arguments appear in sequence:
--
-- 			%  [flags]  [field-width]  [.precision]  type
--
-- 		flags
-- 			Zero or more of the following flags:
--
-- 		    #	      The value should be converted to an "alternate
-- 			      form".  For c, d, and s conversions, this option
-- 			      has no effect.  For o conversions, the precision
-- 			      of the number is increased to force the first
-- 			      character of the output string to a zero (except
-- 			      if a zero value is printed with an explicit
-- 			      precision of zero).
-- 			      For x and X conversions, a non-zero result has
-- 			      the string "0x" (or "0X" for X conversions)
-- 			      prepended to it.
--
-- 		    0 (zero)  Zero padding.  For all conversions the converted
-- 			      value is padded on the left with zeros rather
-- 			      than blanks.  If a precision is given with a
-- 			      numeric conversion (d, o, x, and X), the 0 flag
-- 			      is ignored.
--
-- 		    -	      A negative field width flag; the converted value
-- 			      is to be left adjusted on the field boundary.
-- 			      The converted value is padded on the right with
-- 			      blanks, rather than on the left with blanks or
-- 			      zeros.  A - overrides a 0 if both are given.
--
-- 		    ' ' (space)  A blank should be left before a positive
-- 			      number produced by a signed conversion (d).
--
-- 		    +	      A sign must always be placed before a number
-- 			      produced by a signed conversion.  A + overrides
-- 			      a space if both are used.
--
-- 		field-width
-- 			An optional decimal digit string specifying a minimum
-- 			field width.  If the converted value has fewer bytes
-- 			than the field width, it will be padded with spaces on
-- 			the left (or right, if the left-adjustment flag has
-- 			been given) to fill out the field width.
--
-- 		.precision
-- 			An optional precision, in the form of a period '.'
-- 			followed by an optional digit string.  If the digit
-- 			string is omitted, the precision is taken as zero.
-- 			This gives the minimum number of digits to appear for
-- 			d, o, x, and X conversions, or the maximum number of
-- 			bytes to be printed from a string for s conversions.
-- 			For floating point it is the number of digits after
-- 			the decimal point.
--
-- 		type
-- 			A character that specifies the type of conversion to
-- 			be applied, see below.
--
-- 		A field width or precision, or both, may be indicated by an
-- 		asterisk '*' instead of a digit string.  In this case, a
-- 		Number argument supplies the field width or precision.  A
-- 		negative field width is treated as a left adjustment flag
-- 		followed by a positive field width; a negative precision is
-- 		treated as though it were missing.  Example: >
-- 			:echo printf("%d: %.*s", nr, width, line)
-- <		This limits the length of the text used from "line" to
-- 		"width" bytes.
--
-- 		The conversion specifiers and their meanings are:
--
-- 				*printf-d* *printf-b* *printf-B* *printf-o* *printf-x* *printf-X*
-- 		dbBoxX	The Number argument is converted to signed decimal (d),
-- 			unsigned binary (b and B), unsigned octal (o), or
-- 			unsigned hexadecimal (x and X) notation.  The letters
-- 			"abcdef" are used for x conversions; the letters
-- 			"ABCDEF" are used for X conversions.  The precision, if
-- 			any, gives the minimum number of digits that must
-- 			appear; if the converted value requires fewer digits, it
-- 			is padded on the left with zeros.  In no case does a
-- 			non-existent or small field width cause truncation of a
-- 			numeric field; if the result of a conversion is wider
-- 			than the field width, the field is expanded to contain
-- 			the conversion result.
-- 			The 'h' modifier indicates the argument is 16 bits.
-- 			The 'l' modifier indicates the argument is 32 bits.
-- 			The 'L' modifier indicates the argument is 64 bits.
-- 			Generally, these modifiers are not useful. They are
-- 			ignored when type is known from the argument.
--
-- 		i	alias for d
-- 		D	alias for ld
-- 		U	alias for lu
-- 		O	alias for lo
--
-- 							*printf-c*
-- 		c	The Number argument is converted to a byte, and the
-- 			resulting character is written.
--
-- 							*printf-s*
-- 		s	The text of the String argument is used.  If a
-- 			precision is specified, no more bytes than the number
-- 			specified are used.
-- 			If the argument is not a String type, it is
-- 			automatically converted to text with the same format
-- 			as ":echo".
-- 							*printf-S*
-- 		S	The text of the String argument is used.  If a
-- 			precision is specified, no more display cells than the
-- 			number specified are used.
--
-- 							*printf-f* *E807*
-- 		f F	The Float argument is converted into a string of the
-- 			form 123.456.  The precision specifies the number of
-- 			digits after the decimal point.  When the precision is
-- 			zero the decimal point is omitted.  When the precision
-- 			is not specified 6 is used.  A really big number
-- 			(out of range or dividing by zero) results in "inf"
-- 			 or "-inf" with %f (INF or -INF with %F).
-- 			 "0.0 / 0.0" results in "nan" with %f (NAN with %F).
-- 			Example: >
-- 				echo printf("%.2f", 12.115)
-- <				12.12
-- 			Note that roundoff depends on the system libraries.
-- 			Use |round()| when in doubt.
--
-- 							*printf-e* *printf-E*
-- 		e E	The Float argument is converted into a string of the
-- 			form 1.234e+03 or 1.234E+03 when using 'E'.  The
-- 			precision specifies the number of digits after the
-- 			decimal point, like with 'f'.
--
-- 							*printf-g* *printf-G*
-- 		g G	The Float argument is converted like with 'f' if the
-- 			value is between 0.001 (inclusive) and 10000000.0
-- 			(exclusive).  Otherwise 'e' is used for 'g' and 'E'
-- 			for 'G'.  When no precision is specified superfluous
-- 			zeroes and '+' signs are removed, except for the zero
-- 			immediately after the decimal point.  Thus 10000000.0
-- 			results in 1.0e7.
--
-- 							*printf-%*
-- 		%	A '%' is written.  No argument is converted.  The
-- 			complete conversion specification is "%%".
--
-- 		When a Number argument is expected a String argument is also
-- 		accepted and automatically converted.
-- 		When a Float or String argument is expected a Number argument
-- 		is also accepted and automatically converted.
-- 		Any other argument type results in an error message.
--
-- 							*E766* *E767*
-- 		The number of {exprN} arguments must exactly match the number
-- 		of "%" items.  If there are not sufficient or too many
-- 		arguments an error is given.  Up to 18 arguments can be used.
--- @return string
function vim.fn.printf(fmt, ...) end

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

-- The result is a Number, which is the number of display cells
-- 		String {expr} occupies.  A Tab character is counted as one
-- 		cell, alternatively use |strdisplaywidth()|.
-- 		When {expr} contains characters with East Asian Width Class
-- 		Ambiguous, this function's return value depends on 'ambiwidth'.
-- 		Also see |strlen()|, |strdisplaywidth()| and |strchars()|.
--- @return number
function vim.fn.strwidth(expr) end

-- Get the Job associated with terminal window {buf}.
-- 		{buf} is used as with |term_getsize()|.
-- 		Returns |v:null| when there is no job.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getjob()
--- @return job
function vim.fn.term_getjob(buf) end

-- Convert {expr} into a JSON string.  Accepts
-- 		|msgpack-special-dict| as the input.  Will not convert
-- 		|Funcref|s, mappings with non-string keys (can be created as
-- 		|msgpack-special-dict|), values with self-referencing
-- 		containers, strings which contain non-UTF-8 characters,
-- 		pseudo-UTF-8 strings which contain codepoints reserved for
-- 		surrogate pairs (such strings are not valid UTF-8 strings).
-- 		Non-printable characters are converted into "\u1234" escapes
-- 		or special escapes like "\t", other are dumped as-is.
--- @return string
function vim.fn.json_encode(expr) end

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

-- the top of the GUI Vim window.  The result will be -1 if the
-- 		information is not available.
-- 		The value can be used with `:winpos`.
--- @return number
function vim.fn.getwinposy() end

-- Return the number of lines that scrolled to above the top of
-- 		terminal {buf}.  This is the offset between the row number
-- 		used for |term_getline()| and |getline()|, so that: >
-- 			term_getline(buf, N)
-- <		is equal to: >
-- 			getline(N + term_getscrolled(buf))
-- <		(if that line exists).
--
-- 		{buf} is used as with |term_getsize()|.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_getscrolled()
--- @return number
function vim.fn.term_getscrolled(buf) end

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

-- Like |append()| but append the text in buffer {expr}.
--
-- 		For the use of {expr}, see |bufname()|.
--
-- 		{lnum} is used like with |append()|.  Note that using |line()|
-- 		would use the current buffer, not the one appending to.
-- 		Use "$" to append at the end of the buffer.
--
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		If {expr} is not a valid buffer or {lnum} is not valid, an
-- 		error message is given. Example: >
-- 			:let failed = appendbufline(13, 0, "# THE START")
-- <
--- @return number
function vim.fn.appendbufline(expr, lnum, text) end

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

-- Open a new window displaying the contents of {filename}
-- 		The file must have been created with |term_dumpwrite()|.
-- 		Returns the buffer number or zero when it fails.
-- 		Also see |terminal-diff|.
--
-- 		For {options} see |term_dumpdiff()|.
--
-- 		Can also be used as a |method|: >
-- 			GetFilename()->term_dumpload()
-- <
--- @return number
function vim.fn.term_dumpload(filename, options) end

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

-- Return a List with all text properties in line {lnum}.
--
-- 		When {props} contains a "bufnr" item, use this buffer instead
-- 		of the current buffer.
--
-- 		The properties are ordered by starting column and priority.
-- 		Each property is a Dict with these entries:
-- 		   col		starting column
-- 		   length	length in bytes, one more if line break is
-- 				included
-- 		   id		property ID
-- 		   type		name of the property type, omitted if
-- 				the type was deleted
-- 		   start	when TRUE property starts in this line
-- 		   end		when TRUE property ends in this line
--
-- 		When "start" is zero the property started in a previous line,
-- 		the current one is a continuation.
-- 		When "end" is zero the property continues in the next line.
-- 		The line break after this line is included.
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetLnum()->prop_list()
-- <
--- @return list
function vim.fn.prop_list(lnum, props) end

-- Return a list with the buffer numbers of all buffers for
-- 		terminal windows.
--- @return list
function vim.fn.term_list() end

-- Find directory {name} in {path}.  Supports both downwards and
-- 		upwards recursive directory searches.  See |file-searching|
-- 		for the syntax of {path}.
-- 		Returns the path of the first found match.  When the found
-- 		directory is below the current directory a relative path is
-- 		returned.  Otherwise a full path is returned.
-- 		If {path} is omitted or empty then 'path' is used.
-- 		If the optional {count} is given, find {count}'s occurrence of
-- 		{name} in {path} instead of the first one.
-- 		When {count} is negative return all the matches in a |List|.
-- 		This is quite similar to the ex-command |:find|.
--- @return string
function vim.fn.finddir(name, path, count) end

-- Get the contents of {row} of terminal screen of {buf}.
-- 		For {buf} see |term_getsize()|.
--
-- 		The first line has {row} one.  When {row} is "." the cursor
-- 		line is used.  When {row} is invalid an empty string is
-- 		returned.
--
-- 		Return a List containing a Dict for each screen cell:
-- 		    "chars"	character(s) at the cell
-- 		    "fg"	foreground color as #rrggbb
-- 		    "bg"	background color as #rrggbb
-- 		    "attr"	attributes of the cell, use |term_getattr()|
-- 				to get the individual flags
-- 		    "width"	cell width: 1 or 2
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_scrape(row)
--- @return list
function vim.fn.term_scrape(buf, row) end

-- Just like |finddir()|, but find a file instead of a directory.
-- 		Uses 'suffixesadd'.
-- 		Example: >
-- 			:echo findfile("tags.vim", ".;")
-- <		Searches from the directory of the current file upwards until
-- 		it finds the file "tags.vim".
--- @return string
function vim.fn.findfile(name, path, count) end

-- Send keystrokes {keys} to terminal {buf}.
-- 		{buf} is used as with |term_getsize()|.
--
-- 		{keys} are translated as key sequences. For example, "\<c-x>"
-- 		means the character CTRL-X.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_sendkeys(keys)
--- @return none
function vim.fn.term_sendkeys(buf, keys) end

-- Convert {expr} to a Number by omitting the part after the
-- 		decimal point.
-- 		{expr} must evaluate to a |Float| or a Number.
-- 		When the value of {expr} is out of range for a |Number| the
-- 		result is truncated to 0x7fffffff or -0x7fffffff (or when
-- 		64-bit Number support is enabled, 0x7fffffffffffffff or
-- 		-0x7fffffffffffffff).  NaN results in -0x80000000 (or when
-- 		64-bit Number support is enabled, -0x8000000000000000).
-- 		Examples: >
-- 			echo float2nr(3.95)
-- <			3  >
-- 			echo float2nr(-23.45)
-- <			-23  >
-- 			echo float2nr(1.0e100)
-- <			2147483647  (or 9223372036854775807) >
-- 			echo float2nr(-1.0e150)
-- <			-2147483647 (or -9223372036854775807) >
-- 			echo float2nr(1.0e-100)
-- <			0
--- @return number
function vim.fn.float2nr(expr) end

-- Set the function name prefix to be used for the |terminal-api|
-- 		function in terminal {buf}.  For example: >
-- 		    :call term_setapi(buf, "Myapi_")
-- 		    :call term_setapi(buf, "")
-- <
-- 		The default is "Tapi_".  When {expr} is an empty string then
-- 		no |terminal-api| function can be used for {buf}.
--- @return none
function vim.fn.term_setapi(buf, expr) end

-- Make a copy of {expr}.  For Numbers and Strings this isn't
-- 		different from using {expr} directly.
-- 		When {expr} is a |List| a full copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  When an item is a |List|, a copy for it
-- 		is made, recursively.  Thus changing an item in the copy does
-- 		not change the contents of the original |List|.
-- 		When {noref} is omitted or zero a contained |List| or
-- 		|Dictionary| is only copied once.  All references point to
-- 		this single copy.  With {noref} set to 1 every occurrence of a
-- 		|List| or |Dictionary| results in a new copy.  This also means
-- 		that a cyclic reference causes deepcopy() to fail.
-- 								*E724*
-- 		Nesting is possible up to 100 levels.  When there is an item
-- 		that refers back to a higher level making a deep copy with
-- 		{noref} set to 1 will fail.
-- 		Also see |copy()|.
function vim.fn.deepcopy(expr, noref) end

-- Set the ANSI color palette used by terminal {buf}.
-- 		{colors} must be a List of 16 valid color names or hexadecimal
-- 		color codes, like those accepted by |highlight-guifg|.
-- 		Also see |term_getansicolors()| and |g:terminal_ansi_colors|.
--
-- 		The colors normally are:
-- 			0    black
-- 			1    dark red
-- 			2    dark green
-- 			3    brown
-- 			4    dark blue
-- 			5    dark magenta
-- 			6    dark cyan
-- 			7    light grey
-- 			8    dark grey
-- 			9    red
-- 			10   green
-- 			11   yellow
-- 			12   blue
-- 			13   magenta
-- 			14   cyan
-- 			15   white
--
-- 		These colors are used in the GUI and in the terminal when
-- 		'termguicolors' is set.  When not using GUI colors (GUI mode
-- 		or 'termguicolors'), the terminal window always uses the 16
-- 		ANSI colors of the underlying terminal.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setansicolors(colors)
--
-- <		{only available with GUI enabled and/or the |+termguicolors|
-- 		feature}
--- @return none
function vim.fn.term_setansicolors(buf, colors) end

-- When exiting Vim or trying to close the terminal window in
-- 		another way, {how} defines whether the job in the terminal can
-- 		be stopped.
-- 		When {how} is empty (the default), the job will not be
-- 		stopped, trying to exit will result in |E947|.
-- 		Otherwise, {how} specifies what signal to send to the job.
-- 		See |job_stop()| for the values.
--
-- 		After sending the signal Vim will wait for up to a second to
-- 		check that the job actually stopped.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setkill(how)
--- @return none
function vim.fn.term_setkill(buf, how) end

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

-- Set the command to write in a session file to restore the job
-- 		in this terminal.  The line written in the session file is: >
-- 			terminal ++curwin ++cols=%d ++rows=%d {command}
-- <		Make sure to escape the command properly.
--
-- 		Use an empty {command} to run 'shell'.
-- 		Use "NONE" to not restore this window.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_setrestore(command)
--- @return none
function vim.fn.term_setrestore(buf, command) end

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

-- Returns the text that is displayed for the closed fold at line
-- 		{lnum}.  Evaluates 'foldtext' in the appropriate context.
-- 		When there is no closed fold at {lnum} an empty string is
-- 		returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		Useful when exporting folded text, e.g., to HTML.
--- @return string
function vim.fn.foldtextresult(lnum) end

-- Open a terminal window and run {cmd} in it.
--
-- 		{cmd} can be a string or a List, like with |job_start()|. The
-- 		string "NONE" can be used to open a terminal window without
-- 		starting a job, the pty of the terminal can be used by a
-- 		command like gdb.
--
-- 		Returns the buffer number of the terminal window.  If {cmd}
-- 		cannot be executed the window does open and shows an error
-- 		message.
-- 		If opening the window fails zero is returned.
--
-- 		{options} are similar to what is used for |job_start()|, see
-- 		|job-options|.  However, not all options can be used.  These
-- 		are supported:
-- 		   all timeout options
-- 		   "stoponexit", "cwd", "env"
-- 		   "callback", "out_cb", "err_cb", "exit_cb", "close_cb"
-- 		   "in_io", "in_top", "in_bot", "in_name", "in_buf"
-- 		   "out_io", "out_name", "out_buf", "out_modifiable", "out_msg"
-- 		   "err_io", "err_name", "err_buf", "err_modifiable", "err_msg"
-- 		However, at least one of stdin, stdout or stderr must be
-- 		connected to the terminal.  When I/O is connected to the
-- 		terminal then the callback function for that part is not used.
--
-- 		There are extra options:
-- 		   "term_name"	     name to use for the buffer name, instead
-- 				     of the command name.
-- 		   "term_rows"	     vertical size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "term_cols"	     horizontal size to use for the terminal,
-- 				     instead of using 'termwinsize'
-- 		   "vertical"	     split the window vertically; note that
-- 				     other window position can be defined with
-- 				     command modifiers, such as |:belowright|.
-- 		   "curwin"	     use the current window, do not split the
-- 				     window; fails if the current buffer
-- 				     cannot be |abandon|ed
-- 		   "hidden"	     do not open a window
-- 		   "norestore"	     do not add the terminal window to a
-- 				     session file
-- 		   "term_kill"	     what to do when trying to close the
-- 				     terminal window, see |term_setkill()|
-- 		   "term_finish"     What to do when the job is finished:
-- 					"close": close any windows
-- 					"open": open window if needed
-- 				     Note that "open" can be interruptive.
-- 				     See |term++close| and |term++open|.
-- 		   "term_opencmd"    command to use for opening the window when
-- 				     "open" is used for "term_finish"; must
-- 				     have "%d" where the buffer number goes,
-- 				     e.g. "10split|buffer %d"; when not
-- 				     specified "botright sbuf %d" is used
-- 		   "eof_chars"	     Text to send after all buffer lines were
-- 				     written to the terminal.  When not set
-- 				     CTRL-D is used on MS-Windows. For Python
-- 				     use CTRL-Z or "exit()". For a shell use
-- 				     "exit".  A CR is always added.
-- 		   "ansi_colors"     A list of 16 color names or hex codes
-- 				     defining the ANSI palette used in GUI
-- 				     color modes.  See |g:terminal_ansi_colors|.
-- 		   "tty_type"	     (MS-Windows only): Specify which pty to
-- 				     use.  See 'termwintype' for the values.
-- 		   "term_api"	     function name prefix for the
-- 				     |terminal-api| function.  See
-- 				     |term_setapi()|.
--
-- 		Can also be used as a |method|: >
-- 			GetCommand()->term_start()
--- @return number
function vim.fn.term_start(cmd, options) end

-- Stop playing all sounds.
-- 		{only available when compiled with the |+sound| feature}
--- @return none
function vim.fn.sound_clear() end

-- Wait for pending updates of {buf} to be handled.
-- 		{buf} is used as with |term_getsize()|.
-- 		{time} is how long to wait for updates to arrive in msec.  If
-- 		not set then 10 msec will be used.
--
-- 		Can also be used as a |method|: >
-- 			GetBufnr()->term_wait()
--- @return number
function vim.fn.term_wait(buf, time) end

-- The result is a Number, which is |TRUE| when a directory
-- 		with the name {directory} exists.  If {directory} doesn't
-- 		exist, or isn't a directory, the result is |FALSE|.  {directory}
-- 		is any expression, which is used as a String.
--- @return number
function vim.fn.isdirectory(directory) end

-- This is for testing: If the memory allocation with {id} is
-- 		called, then decrement {countdown}, and when it reaches zero
-- 		let memory allocation fail {repeat} times.  When {repeat} is
-- 		smaller than one it fails one time.
--
-- 		Can also be used as a |method|: >
-- 			GetAllocId()->test_alloc_fail()
--- @return none
function vim.fn.test_alloc_fail(id, countdown, _repeat) end

-- Add a text property type {name}.  If a property type with this
-- 		name already exists an error is given.  Nothing is returned.
-- 		{props} is a dictionary with these optional fields:
-- 		   bufnr	define the property only for this buffer; this
-- 				avoids name collisions and automatically
-- 				clears the property types when the buffer is
-- 				deleted.
-- 		   highlight	name of highlight group to use
-- 		   priority	when a character has multiple text
-- 				properties the one with the highest priority
-- 				will be used; negative values can be used, the
-- 				default priority is zero
-- 		   combine	when TRUE combine the highlight with any
-- 				syntax highlight; when omitted or FALSE syntax
-- 				highlight will not be used
-- 		   start_incl	when TRUE inserts at the start position will
-- 				be included in the text property
-- 		   end_incl	when TRUE inserts at the end position will be
-- 				included in the text property
--
-- 		See |text-properties| for information about text properties.
--
-- 		Can also be used as a |method|: >
-- 			GetPropName()->prop_type_add(props)
--- @return none
function vim.fn.prop_type_add(name, props) end

-- Set a flag to enable the effect of 'autochdir' before Vim
-- 		startup has finished.
--- @return none
function vim.fn.test_autochdir() end

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

-- Characters in {string} are queued for processing as if they
-- 		were typed by the user. This uses a low level input buffer.
-- 		This function works only when with |+unix| or GUI is running.
--
-- 		Can also be used as a |method|: >
-- 			GetText()->test_feedinput()
--- @return none
function vim.fn.test_feedinput(string) end

-- Place the sign defined as {name} at line {lnum} in file {expr}
-- 		and assign {id} and {group} to sign.  This is similar to the
-- 		|:sign-place| command.
--
-- 		If the sign identifier {id} is zero, then a new identifier is
-- 		allocated.  Otherwise the specified number is used. {group} is
-- 		the sign group name. To use the global sign group, use an
-- 		empty string.  {group} functions as a namespace for {id}, thus
-- 		two groups can use the same IDs. Refer to |sign-identifier|
-- 		for more information.
--
-- 		{name} refers to a defined sign.
-- 		{expr} refers to a buffer name or number. For the accepted
-- 		values, see |bufname()|.
--
-- 		The optional {dict} argument supports the following entries:
-- 			lnum		line number in the buffer {expr} where
-- 					the sign is to be placed. For the
-- 					accepted values, see |line()|.
-- 			priority	priority of the sign. See
-- 					|sign-priority| for more information.
--
-- 		If the optional {dict} is not specified, then it modifies the
-- 		placed sign {id} in group {group} to use the defined sign
-- 		{name}.
--
-- 		Returns the sign identifier on success and -1 on failure.
--
-- 		Examples: >
-- 			" Place a sign named sign1 with id 5 at line 20 in
-- 			" buffer json.c
-- 			call sign_place(5, '', 'sign1', 'json.c',
-- 							\ {'lnum' : 20})
--
-- 			" Updates sign 5 in buffer json.c to use sign2
-- 			call sign_place(5, '', 'sign2', 'json.c')
--
-- 			" Place a sign named sign3 at line 30 in
-- 			" buffer json.c with a new identifier
-- 			let id = sign_place(0, '', 'sign3', 'json.c',
-- 							\ {'lnum' : 30})
--
-- 			" Place a sign named sign4 with id 10 in group 'g3'
-- 			" at line 40 in buffer json.c with priority 90
-- 			call sign_place(10, 'g3', 'sign4', 'json.c',
-- 					\ {'lnum' : 40, 'priority' : 90})
--- @param dict dictionary
--- @return number
function vim.fn.sign_place(id, group, name, expr, dict) end

-- Set the flag to call the garbagecollector as if in the main
-- 		loop.  Only to be used in tests.
--- @return none
function vim.fn.test_garbagecollect_soon() end

-- The result is the value of option or local buffer variable
-- 		{varname} in buffer {expr}.  Note that the name without "b:"
-- 		must be used.
-- 		When {varname} is empty returns a dictionary with all the
-- 		buffer-local variables.
-- 		When {varname} is equal to "&" returns a dictionary with all
-- 		the buffer-local options.
-- 		Otherwise, when {varname} starts with "&" returns the value of
-- 		a buffer-local option.
-- 		This also works for a global or buffer-local option, but it
-- 		doesn't work for a global variable, window-local variable or
-- 		window-local option.
-- 		For the use of {expr}, see |bufname()| above.
-- 		When the buffer or variable doesn't exist {def} or an empty
-- 		string is returned, there is no error message.
-- 		Examples: >
-- 			:let bufmodified = getbufvar(1, "&mod")
-- 			:echo "todo myvar = " . getbufvar("todo", "myvar")
function vim.fn.getbufvar(expr, varname, def) end

-- Get the value of an internal variable.  These values for
-- 		{name} are supported:
-- 			need_fileinfo
--
-- 		Can also be used as a |method|: >
-- 			GetName()->test_getvalue()
function vim.fn.test_getvalue(string) end

-- Returns the |changelist| for the buffer {expr}. For the use
-- 		of {expr}, see |bufname()| above. If buffer {expr} doesn't
-- 		exist, an empty list is returned.
--
-- 		The returned list contains two entries: a list with the change
-- 		locations and the current position in the list.  Each
-- 		entry in the change list is a dictionary with the following
-- 		entries:
-- 			col		column number
-- 			coladd		column offset for 'virtualedit'
-- 			lnum		line number
-- 		If buffer {expr} is the current buffer, then the current
-- 		position refers to the position in the list. For other
-- 		buffers, it is set to the length of the list.
--- @return list
function vim.fn.getchangelist(expr) end

-- Ignore any error containing {expr}.  A normal message is given
-- 		instead.
-- 		This is only meant to be used in tests, where catching the
-- 		error with try/catch cannot be used (because it skips over
-- 		following code).
-- 		{expr} is used literally, not as a pattern.
-- 		When the {expr} is the string "RESET" then the list of ignored
-- 		errors is made empty.
--
-- 		Can also be used as a |method|: >
-- 			GetErrorText()->test_ignore_error()
--- @return none
function vim.fn.test_ignore_error(expr) end

-- Return the arc sine of {expr} measured in radians, as a |Float|
-- 		in the range of [-pi/2, pi/2].
-- 		{expr} must evaluate to a |Float| or a |Number| in the range
-- 		[-1, 1].
-- 		Examples: >
-- 			:echo asin(0.8)
-- <			0.927295 >
-- 			:echo asin(-0.5)
-- <			-0.523599
--- @return float
function vim.fn.asin(expr) end

-- Return a |Blob| that is null. Only useful for testing.
--- @return blob
function vim.fn.test_null_blob() end

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

-- Return a |Channel| that is null. Only useful for testing.
-- 		{only available when compiled with the +channel feature}
--- @return channel
function vim.fn.test_null_channel() end

-- Get a list of defined signs and their attributes.
-- 		This is similar to the |:sign-list| command.
--
-- 		If the {name} is not supplied, then a list of all the defined
-- 		signs is returned. Otherwise the attribute of the specified
-- 		sign is returned.
--
-- 		Each list item in the returned value is a dictionary with the
-- 		following entries:
-- 			icon	full path to the bitmap file of the sign
-- 			linehl	highlight group used for the whole line the
-- 				sign is placed in.
-- 			name	name of the sign
-- 			text	text that is displayed when there is no icon
-- 				or the GUI is not being used.
-- 			texthl	highlight group used for the text item
-- 			numhl	highlight group used for 'number' column at the
-- 				associated line. Overrides |hl-LineNr|,
-- 				|hl-CursorLineNr|.
--
-- 		Returns an empty List if there are no signs and when {name} is
-- 		not found.
--
-- 		Examples: >
-- 			" Get a list of all the defined signs
-- 			echo sign_getdefined()
--
-- 			" Get the attribute of the sign named mySign
-- 			echo sign_getdefined("mySign")
--- @return list
function vim.fn.sign_getdefined(name) end

-- Return a |Dict| that is null. Only useful for testing.
--- @return dict
function vim.fn.test_null_dict() end

-- Shorten directory names in the path {expr} and return the
-- 		result.  The tail, the file name, is kept as-is.  The other
-- 		components in the path are reduced to single letters.  Leading
-- 		'~' and '.' characters are kept.  Example: >
-- 			:echo pathshorten('~/.config/nvim/autoload/file1.vim')
-- <			~/.c/n/a/file1.vim ~
-- 		It doesn't matter if the path exists or not.
--- @return string
function vim.fn.pathshorten(expr) end

-- Return a |Job| that is null. Only useful for testing.
-- 		{only available when compiled with the +job feature}
--- @return job
function vim.fn.test_null_job() end

-- Return the current |command-line-window| type. Possible return
-- 		values are the same as |getcmdtype()|. Returns an empty string
-- 		when not in the command-line window.
--- @return string
function vim.fn.getcmdwintype() end

-- The result is a Number, which is the last modification time of
-- 		the given file {fname}.  The value is measured as seconds
-- 		since 1st Jan 1970, and may be passed to strftime().  See also
-- 		|localtime()| and |strftime()|.
-- 		If the file {fname} can't be found -1 is returned.
--- @return number
function vim.fn.getftime(fname) end

-- Call function {funcname} in the run-time library {libname}
-- 		with single argument {argument}.
-- 		This is useful to call functions in a library that you
-- 		especially made to be used with Vim.  Since only one argument
-- 		is possible, calling standard library functions is rather
-- 		limited.
-- 		The result is the String returned by the function.  If the
-- 		function returns NULL, this will appear as an empty string ""
-- 		to Vim.
-- 		If the function returns a number, use libcallnr()!
-- 		If {argument} is a number, it is passed to the function as an
-- 		int; if {argument} is a string, it is passed as a
-- 		null-terminated string.
-- 		This function will fail in |restricted-mode|.
--
-- 		libcall() allows you to write your own 'plug-in' extensions to
-- 		Vim without having to recompile the program.  It is NOT a
-- 		means to call system functions!  If you try to do so Vim will
-- 		very probably crash.
--
-- 		For Win32, the functions you write must be placed in a DLL
-- 		and use the normal C calling convention (NOT Pascal which is
-- 		used in Windows System DLLs).  The function must take exactly
-- 		one parameter, either a character pointer or a long integer,
-- 		and must return a character pointer or NULL.  The character
-- 		pointer returned must point to memory that will remain valid
-- 		after the function has returned (e.g. in static data in the
-- 		DLL).  If it points to allocated memory, that memory will
-- 		leak away.  Using a static buffer in the function should work,
-- 		it's then freed when the DLL is unloaded.
--
-- 		WARNING: If the function returns a non-valid pointer, Vim may
-- 		crash!	This also happens if the function returns a number,
-- 		because Vim thinks it's a pointer.
-- 		For Win32 systems, {libname} should be the filename of the DLL
-- 		without the ".DLL" suffix.  A full path is only required if
-- 		the DLL is not in the usual places.
-- 		For Unix: When compiling your own plugins, remember that the
-- 		object code must be compiled as position-independent ('PIC').
-- 		Examples: >
-- 			:echo libcall("libc.so", "getenv", "HOME")
-- <
--- @return string
function vim.fn.libcall(lib, func, arg) end

-- Return a |Partial| that is null. Only useful for testing.
--- @return funcref
function vim.fn.test_null_partial() end

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

-- Return a |String| that is null. Only useful for testing.
--- @return string
function vim.fn.test_null_string() end

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

-- Reset the flag that indicates option {name} was set.  Thus it
-- 		looks like it still has the default value. Use like this: >
-- 			set ambiwidth=double
-- 			call test_option_not_set('ambiwidth')
-- <		Now the 'ambiwidth' option behaves like it was never changed,
-- 		even though the value is "double".
-- 		Only to be used for testing!
--
-- 		Can also be used as a |method|: >
-- 			GetOptionName()->test_option_not_set()
--- @return none
function vim.fn.test_option_not_set(name) end

