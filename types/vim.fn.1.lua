--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Activates UI events on the channel.
--
--                 Entry point of all UI clients. Allows |--embed| to continue
--                 startup. Implies that the client is ready to show the UI. Adds
--                 the client to the list of UIs. |nvim_list_uis()|
--
--                 Note:
--                     If multiple UI clients are attached, the global screen
--                     dimensions degrade to the smallest client. E.g. if client
--                     A requests 80x40 but client B requests 200x100, the global
--                     screen has size 80x40.
--
--                 Parameters: ~
--                     {width}    Requested screen columns
--                     {height}   Requested screen rows
--                     {options}  |ui-option| map
function vim.fn.nvim_ui_attach(width, height, options) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

-- Create or replace or add to the location list for window {nr}.
-- 		{nr} can be the window number or the |window-ID|.
-- 		When {nr} is zero the current window is used.
--
-- 		For a location list window, the displayed location list is
-- 		modified.  For an invalid window number {nr}, -1 is returned.
-- 		Otherwise, same as |setqflist()|.
-- 		Also see |location-list|.
--
-- 		If the optional {what} dictionary argument is supplied, then
-- 		only the items listed in {what} are set. Refer to |setqflist()|
-- 		for the list of supported keys in {what}.
--- @param list any[]
--- @return number
function vim.fn.setloclist(nr, list, action, what) end

-- When {pattern} does not match {actual} an error message is
-- 		added to |v:errors|.  Also see |assert-return|.
--
-- 		{pattern} is used as with |=~|: The matching is always done
-- 		like 'magic' was set and 'cpoptions' is empty, no matter what
-- 		the actual value of 'magic' or 'cpoptions' is.
--
-- 		{actual} is used as a string, automatic conversion applies.
-- 		Use "^" and "$" to match with the start and end of the text.
-- 		Use both to match the whole text.
--
-- 		When {msg} is omitted an error in the form
-- 		"Pattern {pattern} does not match {actual}" is produced.
-- 		Example: >
-- 	assert_match('^f.*o$', 'foobar')
-- <		Will result in a string to be added to |v:errors|:
-- 	test.vim line 12: Pattern '^f.*o$' does not match 'foobar' ~
--- @return number
function vim.fn.assert_match(pat, text, msg) end

-- Tells Nvim the number of elements displaying in the popumenu,
--                 to decide <PageUp> and <PageDown> movement.
--
--                 Parameters: ~
--                     {height}  Popupmenu height, must be greater than zero.
function vim.fn.nvim_ui_pum_set_height(height) end

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- TODO: Documentation
function vim.fn.nvim_ui_set_option(name, value) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

-- TODO: Documentation
function vim.fn.nvim_ui_try_resize(width, height) end

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @return number
function vim.fn.assert_report(msg) end

-- Tell Nvim to resize a grid. Triggers a grid_resize event with
--                 the requested grid size or the maximum size if it exceeds size
--                 limits.
--
--                 On invalid grid handle, fails with error.
--
--                 Parameters: ~
--                     {grid}    The handle of the grid to be changed.
--                     {width}   The new requested width.
--                     {height}  The new requested height.
function vim.fn.nvim_ui_try_resize_grid(grid, width, height) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @return number
function vim.fn.assert_true(actual, msg) end

-- Return the current text in the balloon.  Only for the string,
-- 		not used for the List.
--- @return string
function vim.fn.balloon_gettext() end

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

-- Show {expr} inside the balloon.  For the GUI {expr} is used as
-- 		a string.  For a terminal {expr} can be a list, which contains
-- 		the lines of the balloon.  If {expr} is not a list it will be
-- 		split with |balloon_split()|.
-- 		If {expr} is an empty string any existing balloon is removed.
--
-- 		Example: >
-- 			func GetBalloonContent()
-- 			   " ... initiate getting the content
-- 			   return ''
-- 			endfunc
-- 			set balloonexpr=GetBalloonContent()
--
-- 			func BalloonCallback(result)
-- 			  call balloon_show(a:result)
-- 			endfunc
-- <		Can also be used as a |method|: >
-- 			GetText()->balloon_show()
-- <
-- 		The intended use is that fetching the content of the balloon
-- 		is initiated from 'balloonexpr'.  It will invoke an
-- 		asynchronous method, in which a callback invokes
-- 		balloon_show().  The 'balloonexpr' itself can return an
-- 		empty string or a placeholder.
--
-- 		When showing a balloon is not possible nothing happens, no
-- 		error message.
-- 		{only available when compiled with the |+balloon_eval| or
-- 		|+balloon_eval_term| feature}
--- @return none
function vim.fn.balloon_show(expr) end

-- Split {msg} into lines to be displayed in a balloon.  The
-- 		splits are made for the current window size and optimize to
-- 		show debugger output.
-- 		Returns a |List| with the split lines.
-- 		Can also be used as a |method|: >
-- 			GetText()->balloon_split()->balloon_show()
--
-- <		{only available when compiled with the |+balloon_eval_term|
-- 		feature}
--- @return list
function vim.fn.balloon_split(msg) end

-- Return non-zero when there is something to read from {handle}.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		This is useful to read from a channel at a convenient time,
-- 		e.g. from a timer.
--
-- 		Note that messages are dropped when the channel does not have
-- 		a callback.  Add a close callback to avoid that.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_canread()
--- @return number
function vim.fn.ch_canread(handle) end

-- Return the line number of the first line at or above {lnum}
-- 		that is not blank.  Example: >
-- 			let ind = indent(prevnonblank(v:lnum - 1))
-- <		When {lnum} is invalid or there is no non-blank line at or
-- 		above it, zero is returned.
-- 		Also see |nextnonblank()|.
--- @return number
function vim.fn.prevnonblank(lnum) end

-- Close {handle}.  See |channel-close|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close()
--- @return none
function vim.fn.ch_close(handle) end

-- Close the "in" part of {handle}.  See |channel-close-in|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		A close callback is not invoked.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_close_in()
--- @return none
function vim.fn.ch_close_in(handle) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.  See |channel-use|.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 								*E917*
-- 		{options} must be a Dictionary.  It must not have a "callback"
-- 		entry.  It can have a "timeout" entry to specify the timeout
-- 		for this specific request.
--
-- 		ch_evalexpr() waits for a response and returns the decoded
-- 		expression.  When there is an error or timeout it returns an
-- 		empty string.
--
-- 		Note that while waiting for the response, Vim handles other
-- 		messages.  You need to make sure this doesn't cause trouble.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalexpr(expr)
function vim.fn.ch_evalexpr(handle, expr, options) end

-- Send {string} over {handle}.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Works like |ch_evalexpr()|, but does not encode the request or
-- 		decode the response.  The caller is responsible for the
-- 		correct contents.  Also does not add a newline for a channel
-- 		in NL mode, the caller must do that.  The NL in the response
-- 		is removed.
-- 		Note that Vim does not know when the text received on a raw
-- 		channel is complete, it may only return the first part and you
-- 		need to use |ch_readraw()| to fetch the rest.
-- 		See |channel-use|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_evalraw(rawstring)
function vim.fn.ch_evalraw(handle, string, options) end

-- Return the line number that contains the character at byte
-- 		count {byte} in the current buffer.  This includes the
-- 		end-of-line character, depending on the 'fileformat' option
-- 		for the current buffer.  The first character has byte count
-- 		one.
-- 		Also see |line2byte()|, |go| and |:goto|.
--- @return number
function vim.fn.byte2line(byte) end

-- Get the buffer number that {handle} is using for {what}.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		{what} can be "err" for stderr, "out" for stdout or empty for
-- 		socket output.
-- 		Returns -1 when there is no buffer.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getbufnr(what)
--- @return number
function vim.fn.ch_getbufnr(handle, what) end

-- Get the Job associated with {channel}.
-- 		If there is no job calling |job_status()| on the returned Job
-- 		will result in "fail".
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_getjob()
--- @return job
function vim.fn.ch_getjob(channel) end

-- Returns a Dictionary with information about {handle}.  The
-- 		items are:
-- 		   "id"		  number of the channel
-- 		   "status"	  "open", "buffered" or "closed", like
-- 				  ch_status()
-- 		When opened with ch_open():
-- 		   "hostname"	  the hostname of the address
-- 		   "port"	  the port of the address
-- 		   "sock_status"  "open" or "closed"
-- 		   "sock_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "sock_io"	  "socket"
-- 		   "sock_timeout" timeout in msec
-- 		When opened with job_start():
-- 		   "out_status"	  "open", "buffered" or "closed"
-- 		   "out_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "out_io"	  "null", "pipe", "file" or "buffer"
-- 		   "out_timeout"  timeout in msec
-- 		   "err_status"	  "open", "buffered" or "closed"
-- 		   "err_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "err_io"	  "out", "null", "pipe", "file" or "buffer"
-- 		   "err_timeout"  timeout in msec
-- 		   "in_status"	  "open" or "closed"
-- 		   "in_mode"	  "NL", "RAW", "JSON" or "JS"
-- 		   "in_io"	  "null", "pipe", "file" or "buffer"
-- 		   "in_timeout"	  timeout in msec
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_info()
--- @return string
function vim.fn.ch_info(handle) end

-- Return the number of the most recent change.  This is the same
-- 		number as what is displayed with |:undolist| and can be used
-- 		with the |:undo| command.
-- 		When a change was made it is the number of that change.  After
-- 		redo it is the number of the redone change.  After undo it is
-- 		one less than the number of the undone change.
--- @return number
function vim.fn.changenr() end

-- Write {msg} in the channel log file, if it was opened with
-- 		|ch_logfile()|.
-- 		When {handle} is passed the channel number is used for the
-- 		message.
-- 		{handle} can be a Channel or a Job that has a Channel.  The
-- 		Channel must be open for the channel number to be used.
--
-- 		Can also be used as a |method|: >
-- 			'did something'->ch_log()
--- @return none
function vim.fn.ch_log(msg, handle) end

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

-- Start logging channel activity to {fname}.
-- 		When {fname} is an empty string: stop logging.
--
-- 		When {mode} is omitted or "a" append to the file.
-- 		When {mode} is "w" start with an empty file.
--
-- 		Use |ch_log()| to write log messages.  The file is flushed
-- 		after every message, on Unix you can use "tail -f" to see what
-- 		is going on in real time.
--
-- 		This function is not available in the |sandbox|.
-- 		NOTE: the channel communication is stored in the file, be
-- 		aware that this may contain confidential and privacy sensitive
-- 		information, e.g. a password you type in a terminal window.
--
-- 		Can also be used as a |method|: >
-- 			'logfile'->ch_logfile('w')
--- @return none
function vim.fn.ch_logfile(fname, mode) end

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

-- Open a channel to {address}.  See |channel|.
-- 		Returns a Channel.  Use |ch_status()| to check for failure.
--
-- 		{address} has the form "hostname:port", e.g.,
-- 		"localhost:8765".
--
-- 		If {options} is given it must be a |Dictionary|.
-- 		See |channel-open-options|.
--
-- 		Can also be used as a |method|: >
-- 			GetAddress()->ch_open()
--- @return channel
function vim.fn.ch_open(address, options) end

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

-- Read from {handle} and return the received message.
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		For a NL channel this waits for a NL to arrive, except when
-- 		there is nothing more to read (channel was closed).
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_read()
--- @return string
function vim.fn.ch_read(handle, options) end

-- Clears all matches previously defined for the current window
-- 		by |matchadd()| and the |:match| commands.
--- @return none
function vim.fn.clearmatches() end

-- Like ch_read() but reads binary data and returns a |Blob|.
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readblob()
--- @return blob
function vim.fn.ch_readblob(handle, options) end

-- Like ch_read() but for a JS and JSON channel does not decode
-- 		the message.  For a NL channel it does not block waiting for
-- 		the NL to arrive, but otherwise works like ch_read().
-- 		See |channel-more|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_readraw()
--- @return string
function vim.fn.ch_readraw(handle, options) end

-- Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See |complete-functions| for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
--- @return number
function vim.fn.complete_add(expr) end

-- Send {expr} over {handle}.  The {expr} is encoded
-- 		according to the type of channel.  The function cannot be used
-- 		with a raw channel.
-- 		See |channel-use|.				*E912*
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendexpr(expr)
function vim.fn.ch_sendexpr(handle, expr, options) end

-- Float, String or a composition of them, then the result can be
-- 		parsed back with |eval()|.
-- 			{expr} type	result ~
-- 			String		'string'
-- 			Number		123
-- 			Float		123.123456 or 1.123456e8 or
-- 					`str2float('inf')`
-- 			Funcref		`function('name')`
-- 			List		[item, item]
-- 			Dictionary	{key: value, key: value}
-- 		Note that in String values the ' character is doubled.
-- 		Also see |strtrans()|.
-- 		Note 2: Output format is mostly compatible with YAML, except
-- 		for infinite and NaN floating-point values representations
-- 		which use |str2float()|.  Strings are also dumped literally,
-- 		only single quote is escaped, which does not allow using YAML
-- 		for parsing back binary strings.  |eval()| should always work for
-- 		strings and floats though and this is the only official
-- 		method, use |msgpackdump()| or |json_encode()| if you need to
-- 		share data with other application.
--- @return string
function vim.fn.string(expr) end

-- Send |String| or |Blob| {expr} over {handle}.
-- 		Works like |ch_sendexpr()|, but does not encode the request or
-- 		decode the response.  The caller is responsible for the
-- 		correct contents.  Also does not add a newline for a channel
-- 		in NL mode, the caller must do that.  The NL in the response
-- 		is removed.
-- 		See |channel-use|.
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_sendraw(rawexpr)
function vim.fn.ch_sendraw(handle, expr, options) end

-- Set options on {handle}:
-- 			"callback"	the channel callback
-- 			"timeout"	default read timeout in msec
-- 			"mode"		mode for the whole channel
-- 		See |ch_open()| for more explanation.
-- 		{handle} can be a Channel or a Job that has a Channel.
--
-- 		Note that changing the mode may cause queued messages to be
-- 		lost.
--
-- 		These options cannot be changed:
-- 			"waittime"	only applies to |ch_open()|
--
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_setoptions(options)
--- @return none
function vim.fn.ch_setoptions(handle, options) end

-- Return a list with file and directory names in {directory}.
-- 		You can also use |glob()| if you don't need to do complicated
-- 		things, such as limiting the number of matches.
--
-- 		When {expr} is omitted all entries are included.
-- 		When {expr} is given, it is evaluated to check what to do:
-- 			If {expr} results in -1 then no further entries will
-- 			be handled.
--- @return list
function vim.fn.readdir(dir, expr) end

-- Return the status of {handle}:
-- 			"fail"		failed to open the channel
-- 			"open"		channel can be used
-- 			"buffered"	channel can be read, not written to
-- 			"closed"	channel can not be used
-- 		{handle} can be a Channel or a Job that has a Channel.
-- 		"buffered" is used when the channel was closed but there is
-- 		still data that can be obtained with |ch_read()|.
--
-- 		If {options} is given it can contain a "part" entry to specify
-- 		the part of the channel to return the status for: "out" or
-- 		"err".  For example, to get the error status: >
-- 			ch_status(job, {"part": "err"})
-- <
-- 		Can also be used as a |method|: >
-- 			GetChannel()->ch_status()
--- @return string
function vim.fn.ch_status(handle, options) end

-- Returns the single letter name of the register being executed.
-- 		Returns an empty string when no register is being executed.
-- 		See |@|.
--- @return string
function vim.fn.reg_executing() end

-- The result is a Number representing the type of {expr}.
-- 		Instead of using the number directly, it is better to use the
-- 		v:t_ variable that has the value:
-- 		        Number:     0 (|v:t_number|)
-- 			String:     1 (|v:t_string|)
-- 			Funcref:    2 (|v:t_func|)
-- 			List:       3 (|v:t_list|)
-- 			Dictionary: 4 (|v:t_dict|)
-- 			Float:      5 (|v:t_float|)
-- 			Boolean:    6 (|v:true| and |v:false|)
-- 			Null:       7 (|v:null|)
-- 		For backward compatibility, this method can be used: >
-- 			:if type(myvar) == type(0)
-- 			:if type(myvar) == type("")
-- 			:if type(myvar) == type(function("tr"))
-- 			:if type(myvar) == type([])
-- 			:if type(myvar) == type({})
-- 			:if type(myvar) == type(0.0)
-- 			:if type(myvar) == type(v:true)
-- <		In place of checking for |v:null| type it is better to check
-- 		for |v:null| directly as it is the only value of this type: >
-- 			:if myvar is v:null
-- <               To check if the v:t_ variables exist use this: >
--                         :if exists('v:t_number')
--- @return number
function vim.fn.type(name) end

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

-- Like |input()|, but when the GUI is running and text dialogs
-- 		are supported, a dialog window pops up to input the text.
-- 		Example: >
-- 		   :let n = inputdialog("value for shiftwidth", shiftwidth())
-- 		   :if n != ""
-- 		   :  let &sw = n
-- 		   :endif
-- <		When the dialog is cancelled {cancelreturn} is returned.  When
-- 		omitted an empty string is returned.
-- 		Hitting <Enter> works like pressing the OK button.  Hitting
-- 		<Esc> works like pressing the Cancel button.
-- 		NOTE: Command-line completion is not supported.
--
-- 		Can also be used as a |method|: >
-- 			GetPrompt()->inputdialog()
--- @return string
function vim.fn.inputdialog(prompt, text, completion) end

-- Pushes the current editor state (|context|) on the
-- 		|context-stack|.
-- 		If {types} is given and is a |List| of |String|s, it specifies
-- 		which |context-types| to include in the pushed context.
-- 		Otherwise, all context types are included.
--- @return none
function vim.fn.ctxpush(types) end

-- Get the channel handle that {job} is using.
-- 		To check if the job has no channel: >
-- 			if string(job_getchannel()) == 'channel fail'
-- <
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_getchannel()
--- @return channel
function vim.fn.job_getchannel(job) end

-- Sets the |context| at {index} from the top of the
-- 		|context-stack| to that represented by {context}.
-- 		{context} is a Dictionary with context data (|context-dict|).
-- 		If {index} is not given, it is assumed to be 0 (i.e.: top).
--- @return none
function vim.fn.ctxset(context, index) end

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

-- Returns the size of the |context-stack|.
--- @return number
function vim.fn.ctxsize() end

-- Change options for {job}.  Supported are:
-- 		   "stoponexit"	|job-stoponexit|
-- 		   "exit_cb"	|job-exit_cb|
--
-- 		Can also be used as a |method|: >
-- 			GetJob()->job_setoptions(options)
--- @return none
function vim.fn.job_setoptions(job, options) end

-- Set the register {regname} to {value}.
-- 		{value} may be any value returned by |getreg()|, including
-- 		a |List|.
-- 		If {options} contains "a" or {regname} is upper case,
-- 		then the value is appended.
-- 		{options} can also contain a register type specification:
-- 		    "c" or "v"	      |charwise| mode
-- 		    "l" or "V"	      |linewise| mode
-- 		    "b" or "<CTRL-V>" |blockwise-visual| mode
-- 		If a number immediately follows "b" or "<CTRL-V>" then this is
-- 		used as the width of the selection - if it is not specified
-- 		then the width of the block is set to the number of characters
-- 		in the longest line (counting a <Tab> as 1 character).
-- 		If {options} contains "u" or '"', then the unnamed register is
-- 		set to point to register {regname}.
--
-- 		If {options} contains no register settings, then the default
-- 		is to use character mode unless {value} ends in a <NL> for
-- 		string {value} and linewise mode for list {value}. Blockwise
-- 		mode is never selected automatically.
-- 		Returns zero for success, non-zero for failure.
--
-- 							*E883*
-- 		Note: you may not use |List| containing more than one item to
-- 		      set search and expression registers. Lists containing no
-- 		      items act like empty strings.
--
-- 		Examples: >
-- 			:call setreg(v:register, @*)
-- 			:call setreg('*', @%, 'ac')
-- 			:call setreg('a', "1\n2\n3", 'b5')
--
-- <		This example shows using the functions to save and restore a
-- 		register: >
-- 			:let var_a = getreg('a', 1, 1)
-- 			:let var_amode = getregtype('a')
-- 			    ....
-- 			:call setreg('a', var_a, var_amode)
-- <		Note: you may not reliably restore register value
-- 		without using the third argument to |getreg()| as without it
-- 		newlines are represented as newlines AND Nul bytes are
-- 		represented as newlines as well, see |NL-used-for-Nul|.
--
-- 		You can also change the type of a register by appending
-- 		nothing: >
-- 			:call setreg('a', '', 'al')
--- @return number
function vim.fn.setreg(n, v, opt) end

-- Start a job and return a Job object.  Unlike |system()| and
-- 		|:!cmd| this does not wait for the job to finish.
-- 		To start a job in a terminal window see |term_start()|.
--
-- 		If the job fails to start then |job_status()| on the returned
-- 		Job object results in "fail" and none of the callbacks will be
-- 		invoked.
--
-- 		{command} can be a String.  This works best on MS-Windows.  On
-- 		Unix it is split up in white-separated parts to be passed to
-- 		execvp().  Arguments in double quotes can contain white space.
--
-- 		{command} can be a List, where the first item is the executable
-- 		and further items are the arguments.  All items are converted
-- 		to String.  This works best on Unix.
--
-- 		On MS-Windows, job_start() makes a GUI application hidden. If
-- 		want to show it, Use |:!start| instead.
--
-- 		The command is executed directly, not through a shell, the
-- 		'shell' option is not used.  To use the shell: >
-- 	let job = job_start(["/bin/sh", "-c", "echo hello"])
-- <		Or: >
-- 	let job = job_start('/bin/sh -c "echo hello"')
-- <		Note that this will start two processes, the shell and the
-- 		command it executes.  If you don't want this use the "exec"
-- 		shell command.
--
-- 		On Unix $PATH is used to search for the executable only when
-- 		the command does not contain a slash.
--
-- 		The job will use the same terminal as Vim.  If it reads from
-- 		stdin the job and Vim will be fighting over input, that
-- 		doesn't work.  Redirect stdin and stdout to avoid problems: >
-- 	let job = job_start(['sh', '-c', "myserver </dev/null >/dev/null"])
-- <
-- 		The returned Job object can be used to get the status with
-- 		|job_status()| and stop the job with |job_stop()|.
--
-- 		Note that the job object will be deleted if there are no
-- 		references to it.  This closes the stdin and stderr, which may
-- 		cause the job to fail with an error.  To avoid this keep a
-- 		reference to the job.  Thus instead of: >
-- 	call job_start('my-command')
-- <		use: >
-- 	let myjob = job_start('my-command')
-- <		and unlet "myjob" once the job is not needed or is past the
-- 		point where it would fail (e.g. when it prints a message on
-- 		startup).  Keep in mind that variables local to a function
-- 		will cease to exist if the function returns.  Use a
-- 		script-local variable if needed: >
-- 	let s:myjob = job_start('my-command')
-- <
-- 		{options} must be a Dictionary.  It can contain many optional
-- 		items, see |job-options|.
--
-- 		Can also be used as a |method|: >
-- 			BuildCommand()->job_start()
--- @return job
function vim.fn.job_start(command, options) end

-- Specifically used to interrupt a program being debugged.  It
-- 		will cause process {pid} to get a SIGTRAP.  Behavior for other
-- 		processes is undefined. See |terminal-debugger|.
-- 		{Sends a SIGINT to a process {pid} other than MS-Windows}
--- @return number
function vim.fn.debugbreak(pid) end

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

-- Delete lines {first} to {last} (inclusive) from buffer {expr}.
-- 		If {last} is omitted then delete line {first} only.
-- 		On success 0 is returned, on failure 1 is returned.
--
-- 		For the use of {expr}, see |bufname()| above.
--
-- 		{first} and {last} are used like with |setline()|. Note that
-- 		when using |line()| this refers to the current buffer. Use "$"
-- 		to refer to the last line in buffer {expr}.
--- @return number
function vim.fn.deletebufline(expr, first, last) end

-- This is similar to |json_decode()| with these differences:
-- 		- Object key names do not have to be in quotes.
-- 		- Strings can be in single quotes.
-- 		- Empty items in an array (between two commas) are allowed and
-- 		  result in v:none items.
--
-- 		Can also be used as a |method|: >
-- 			ReadObject()->js_decode()
function vim.fn.js_decode(string) end

-- Adds a watcher to a dictionary. A dictionary watcher is
-- 		identified by three components:
--
-- 		- A dictionary({dict});
-- 		- A key pattern({pattern}).
-- 		- A function({callback}).
--
-- 		After this is called, every change on {dict} and on keys
-- 		matching {pattern} will result in {callback} being invoked.
--
-- 		For example, to watch all global variables: >
-- 			silent! call dictwatcherdel(g:, '*', 'OnDictChanged')
-- 			function! OnDictChanged(d,k,z)
-- 			  echomsg string(a:k) string(a:z)
-- 			endfunction
-- 			call dictwatcheradd(g:, '*', 'OnDictChanged')
-- <
-- 		For now {pattern} only accepts very simple patterns that can
-- 		contain a '*' at the end of the string, in which case it will
-- 		match every key that begins with the substring before the '*'.
-- 		That means if '*' is not the last character of {pattern}, only
-- 		keys that are exactly equal as {pattern} will be matched.
--
-- 		The {callback} receives three arguments:
--
-- 		- The dictionary being watched.
-- 		- The key which changed.
-- 		- A dictionary containing the new and old values for the key.
--
-- 		The type of change can be determined by examining the keys
-- 		present on the third argument:
--
-- 		- If contains both `old` and `new`, the key was updated.
-- 		- If it contains only `new`, the key was added.
-- 		- If it contains only `old`, the key was deleted.
--
-- 		This function can be used by plugins to implement options with
-- 		validation and parsing logic.
--- @param dict dictionary
--- @return start
function vim.fn.dictwatcheradd(dict, pattern, callback) end

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

-- Removes a watcher added  with |dictwatcheradd()|. All three
-- 		arguments must match the ones passed to |dictwatcheradd()| in
-- 		order for the watcher to be successfully deleted.
--- @param dict dictionary
--- @return stop
function vim.fn.dictwatcherdel(dict, pattern, callback) end

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

-- Returns the highlight ID for diff mode at line {lnum} column
-- 		{col} (byte index).  When the current line does not have a
-- 		diff change zero is returned.
-- 		{lnum} is used like with |getline()|.  Thus "." is the current
-- 		line, "'m" mark m, etc.
-- 		{col} is 1 for the leftmost column, {lnum} is 1 for the first
-- 		line.
-- 		The highlight ID can be used with |synIDattr()| to obtain
-- 		syntax information about the highlighting.
--- @return number
function vim.fn.diff_hlID(lnum, col) end

-- Returns 1 when inside an event handler.  That is that Vim got
-- 		interrupted while waiting for the user to type a character,
-- 		e.g., when dropping a file on Vim.  This means interactive
-- 		commands cannot be used.  Otherwise zero is returned.
--- @return number
function vim.fn.eventhandler() end

-- Read file {fname} and return a |List|, each line of the file
-- 		as an item.  Lines are broken at NL characters.  Macintosh
-- 		files separated with CR will result in a single long line
-- 		(unless a NL appears somewhere).
-- 		All NUL characters are replaced with a NL character.
-- 		When {binary} contains "b" binary mode is used:
-- 		- When the last line ends in a NL an extra empty list item is
-- 		  added.
-- 		- No CR characters are removed.
-- 		Otherwise:
-- 		- CR characters that appear before a NL are removed.
-- 		- Whether the last line ends in a NL or not does not matter.
-- 		- Any UTF-8 byte order mark is removed from the text.
-- 		When {max} is given this specifies the maximum number of lines
-- 		to be read.  Useful if you only want to check the first ten
-- 		lines of a file: >
-- 			:for line in readfile(fname, '', 10)
-- 			:  if line =~ 'Date' | echo line | endif
-- 			:endfor
-- <		When {max} is negative -{max} lines from the end of the file
-- 		are returned, or as many as there are.
-- 		When {max} is zero the result is an empty list.
-- 		Note that without {max} the whole file is read into memory.
-- 		Also note that there is no recognition of encoding.  Read a
-- 		file into a buffer if you need to.
-- 		When the file can't be opened an error message is given and
-- 		the result is an empty list.
-- 		Also see |writefile()|.
--- @return list
function vim.fn.readfile(fname, binary, max) end

-- Convert {expr} from JSON object.  Accepts |readfile()|-style
-- 		list as the input, as well as regular string.  May output any
-- 		Vim value. In the following cases it will output
-- 		|msgpack-special-dict|:
-- 		1. Dictionary contains duplicate key.
-- 		2. Dictionary contains empty key.
-- 		3. String contains NUL byte.  Two special dictionaries: for
-- 		   dictionary and for string will be emitted in case string
-- 		   with NUL byte was a dictionary key.
--
-- 		Note: function treats its input as UTF-8 always.  The JSON
-- 		standard allows only a few encodings, of which UTF-8 is
-- 		recommended and the only one required to be supported.
-- 		Non-UTF-8 characters are an error.
function vim.fn.json_decode(expr) end

-- The result is a Number, which is |TRUE| when a file with the
-- 		name {file} exists, and can be read.  If {file} doesn't exist,
-- 		or is a directory, the result is |FALSE|.  {file} is any
-- 		expression, which is used as a String.
-- 		If you don't care about the file being readable you can use
-- 		|glob()|.
--- @return number
function vim.fn.filereadable(file) end

-- Spawns {cmd} as a job.
-- 		If {cmd} is a List it runs directly (no 'shell').
-- 		If {cmd} is a String it runs in the 'shell', like this: >
-- 		  :call jobstart(split(&shell) + split(&shellcmdflag) + ['{cmd}'])
-- <		(See |shell-unquoting| for details.)
--
-- 		Example: >
-- 		  :call jobstart('nvim -h', {'on_stdout':{j,d,e->append(line('.'),d)}})
-- <
-- 		Returns |job-id| on success, 0 on invalid arguments (or job
-- 		table is full), -1 if {cmd}[0] or 'shell' is not executable.
-- 		The returned job-id is a valid |channel-id| representing the
-- 		job's stdio streams. Use |chansend()| (or |rpcnotify()| and
-- 		|rpcrequest()| if "rpc" was enabled) to send data to stdin and
-- 		|chanclose()| to close the streams without stopping the job.
--
-- 		See |job-control| and |RPC|.
--
-- 		NOTE: on Windows if {cmd} is a List:
-- 		  - cmd[0] must be an executable (not a "built-in"). If it is
-- 		    in $PATH it can be called by name, without an extension: >
-- 		      :call jobstart(['ping', 'neovim.io'])
-- <		    If it is a full or partial path, extension is required: >
-- 		      :call jobstart(['System32\ping.exe', 'neovim.io'])
-- <		  - {cmd} is collapsed to a string of quoted args as expected
-- 		    by CommandLineToArgvW https://msdn.microsoft.com/bb776391
-- 		    unless cmd[0] is some form of "cmd.exe".
--
-- 							*jobstart-options*
-- 		{opts} is a dictionary with these keys:
-- 		  clear_env:  (boolean) `env` defines the job environment
-- 			      exactly, instead of merging current environment.
-- 		  cwd:	      (string, default=|current-directory|) Working
-- 			      directory of the job.
-- 		  detach:     (boolean) Detach the job process: it will not be
-- 			      killed when Nvim exits. If the process exits
-- 			      before Nvim, `on_exit` will be invoked.
-- 		  env:	      (dict) Map of environment variable name:value
-- 			      pairs extending (or replacing if |clear_env|)
-- 			      the current environment.
-- 		  height:     (number) Height of the `pty` terminal.
-- 		  |on_exit|:    (function) Callback invoked when the job exits.
-- 		  |on_stdout|:  (function) Callback invoked when the job emits
-- 			      stdout data.
-- 		  |on_stderr|:  (function) Callback invoked when the job emits
-- 			      stderr data.
-- 		  pty:	      (boolean) Connect the job to a new pseudo
-- 			      terminal, and its streams to the master file
-- 			      descriptor. Then  `on_stderr` is ignored,
-- 			      `on_stdout` receives all output.
-- 		  rpc:	      (boolean) Use |msgpack-rpc| to communicate with
-- 			      the job over stdio. Then `on_stdout` is ignored,
-- 			      but `on_stderr` can still be used.
-- 		  stderr_buffered: (boolean) Collect data until EOF (stream closed)
-- 			      before invoking `on_stderr`. |channel-buffered|
-- 		  stdout_buffered: (boolean) Collect data until EOF (stream
-- 			      closed) before invoking `on_stdout`. |channel-buffered|
-- 		  TERM:	      (string) Sets the `pty` $TERM environment variable.
-- 		  width:      (number) Width of the `pty` terminal.
--
-- 		{opts} is passed as |self| dictionary to the callback; the
-- 		caller may set other keys to pass application-specific data.
--
-- 		Returns:
-- 		  - |channel-id| on success
-- 		  - 0 on invalid arguments
-- 		  - -1 if {cmd}[0] is not executable.
-- 		See also |job-control|, |channel|, |msgpack-rpc|.
--- @return number
function vim.fn.jobstart(cmd, opts) end

-- The result is a Number, which is 1 when a file with the
-- 		name {file} exists, and can be written.  If {file} doesn't
-- 		exist, or is not writable, the result is 0.  If {file} is a
-- 		directory, and we can write to it, the result is 2.
--- @return number
function vim.fn.filewritable(file) end

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

-- Just like |finddir()|, but find a file instead of a directory.
-- 		Uses 'suffixesadd'.
-- 		Example: >
-- 			:echo findfile("tags.vim", ".;")
-- <		Searches from the directory of the current file upwards until
-- 		it finds the file "tags.vim".
--- @return string
function vim.fn.findfile(name, path, count) end

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

-- Insert {item} at the start of |List| {list}.
-- 		If {idx} is specified insert {item} before the item with index
-- 		{idx}.  If {idx} is zero it goes before the first item, just
-- 		like omitting {idx}.  A negative {idx} is also possible, see
-- 		|list-index|.  -1 inserts just before the last item.
-- 		Returns the resulting |List|.  Examples: >
-- 			:let mylist = insert([2, 3, 5], 1)
-- 			:call insert(mylist, 4, -1)
-- 			:call insert(mylist, 6, len(mylist))
-- <		The last example can be done simpler with |add()|.
-- 		Note that when {item} is a |List| it is inserted as a single
-- 		item.  Use |extend()| to concatenate |Lists|.
--- @param list any[]
--- @return list
function vim.fn.insert(list, item, idx) end

-- Without {end}: Remove the item at {idx} from |List| {list} and
-- 		return the item.
-- 		With {end}: Remove items from {idx} to {end} (inclusive) and
-- 		return a List with these items.  When {idx} points to the same
-- 		item as {end} a list with one item is returned.  When {end}
-- 		points to an item before {idx} this is an error.
-- 		See |list-index| for possible values of {idx} and {end}.
-- 		Example: >
-- 			:echo "last item: " . remove(mylist, -1)
-- 		Remove the entry from {dict} with key {key} and return it.
-- 		Example: >
-- 			:echo "removed " . remove(dict, "one")
-- <		If there is no {key} in {dict} this is an error.
--
-- 		Use |delete()| to remove a file.
--- @param dict dictionary
function vim.fn.remove(dict, key) end

