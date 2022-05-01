--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

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

-- The result is a String, which is {expr} with all unprintable
-- 		characters translated into printable characters |'isprint'|.
-- 		Like they are shown in a window.  Example: >
-- 			echo strtrans(@a)
-- <		This displays a newline in register a as "^@" instead of
-- 		starting a new line.
--- @return string
function vim.fn.strtrans(expr) end

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

-- The result is a Number, which is the foldlevel of line {lnum}
-- 		in the current buffer.  For nested folds the deepest level is
-- 		returned.  If there is no fold at line {lnum}, zero is
-- 		returned.  It doesn't matter if the folds are open or closed.
-- 		When used while updating folds (from 'foldexpr') -1 is
-- 		returned for lines where folds are still to be updated and the
-- 		foldlevel is unknown.  As a special case the level of the
-- 		previous line is usually available.
--- @return number
function vim.fn.foldlevel(lnum) end

-- Remove a listener previously added with listener_add().
-- 		Returns zero when {id} could not be found, one when {id} was
-- 		removed.
--
-- 		Can also be used as a |method|: >
-- 			GetListenerId()->listener_remove()
--- @return none
function vim.fn.listener_remove(id) end

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

-- When {dict} is omitted or zero: Return the rhs of mapping
-- 		{name} in mode {mode}.  The returned String has special
-- 		characters translated like in the output of the ":map" command
-- 		listing.
--
-- 		When there is no mapping for {name}, an empty String is
-- 		returned.  When the mapping for {name} is empty, then "<Nop>"
-- 		is returned.
--
-- 		The {name} can have special key names, like in the ":map"
-- 		command.
--
-- 		{mode} can be one of these strings:
-- 			"n"	Normal
-- 			"v"	Visual (including Select)
-- 			"o"	Operator-pending
-- 			"i"	Insert
-- 			"c"	Cmd-line
-- 			"s"	Select
-- 			"x"	Visual
-- 			"l"	langmap |language-mapping|
-- 			"t"	Terminal
-- 			""	Normal, Visual and Operator-pending
-- 		When {mode} is omitted, the modes for "" are used.
--
-- 		When {abbr} is there and it is |TRUE| use abbreviations
-- 		instead of mappings.
--
-- 		When {dict} is there and it is |TRUE| return a dictionary
-- 		containing all the information of the mapping with the
-- 		following items:
-- 		  "lhs"	     The {lhs} of the mapping.
-- 		  "rhs"	     The {rhs} of the mapping as typed.
-- 		  "silent"   1 for a |:map-silent| mapping, else 0.
-- 		  "noremap"  1 if the {rhs} of the mapping is not remappable.
-- 		  "expr"     1 for an expression mapping (|:map-<expr>|).
-- 		  "buffer"   1 for a buffer local mapping (|:map-local|).
-- 		  "mode"     Modes for which the mapping is defined. In
-- 			     addition to the modes mentioned above, these
-- 			     characters will be used:
-- 			     " "     Normal, Visual and Operator-pending
-- 			     "!"     Insert and Commandline mode
-- 				     (|mapmode-ic|)
-- 		  "sid"	     The script local ID, used for <sid> mappings
-- 			     (|<SID>|).
-- 		  "lnum"     The line number in "sid", zero if unknown.
-- 		  "nowait"   Do not wait for other, longer mappings.
-- 			     (|:map-<nowait>|).
--
-- 		The mappings local to the current buffer are checked first,
-- 		then the global mappings.
-- 		This function can be used to map a key even when it's already
-- 		mapped, and have it do the original mapping too.  Sketch: >
-- 			exe 'nnoremap <Tab> ==' . maparg('<Tab>', 'n')
--- @param dict dictionary
--- @return string
function vim.fn.maparg(name, mode, abbr, dict) end

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

-- windows for the current tab and global popups.
--- @return none
function vim.fn.popup_clear() end

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

-- {expr1} must be a |List| or a |Dictionary|.
-- 		Replace each item in {expr1} with the result of evaluating
-- 		{expr2}. {expr2} must be a |string| or |Funcref|.
--
-- 		If {expr2} is a |string|, inside {expr2} |v:val| has the value
-- 		of the current item. For a |Dictionary| |v:key| has the key
-- 		of the current item and for a |List| |v:key| has the index of
-- 		the current item.
-- 		Example: >
-- 			:call map(mylist, '"> " . v:val . " <"')
-- <		This puts "> " before and " <" after each item in "mylist".
--
-- 		Note that {expr2} is the result of an expression and is then
-- 		used as an expression again.  Often it is good to use a
-- 		|literal-string| to avoid having to double backslashes.  You
-- 		still have to double ' quotes
--
-- 		If {expr2} is a |Funcref| it is called with two arguments:
-- 			1. The key or the index of the current item.
-- 			2. the value of the current item.
-- 		The function must return the new value of the item. Example
-- 		that changes each value by "key-value": >
-- 			func KeyValue(key, val)
-- 			  return a:key . '-' . a:val
-- 			endfunc
-- 			call map(myDict, function('KeyValue'))
-- <		It is shorter when using a |lambda|: >
-- 			call map(myDict, {key, val -> key . '-' . val})
-- <		If you do not use "val" you can leave it out: >
-- 			call map(myDict, {key -> 'item: ' . key})
-- <		If you do not use "key" you can use a short name: >
-- 			call map(myDict, {_, val -> 'item: ' . val})
-- <
-- 		The operation is done in-place.  If you want a |List| or
-- 		|Dictionary| to remain unmodified make a copy first: >
-- 			:let tlist = map(copy(mylist), ' v:val . "\t"')
--
-- <		Returns {expr1}, the |List| or |Dictionary| that was filtered.
-- 		When an error is encountered while evaluating {expr2} no
-- 		further items in {expr1} are processed. When {expr2} is a
-- 		Funcref errors inside a function are ignored, unless it was
-- 		defined with the "abort" flag.
--- @return list/dict
function vim.fn.map(expr1, expr2) end

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

-- Filter that can be used for a popup. These keys can be used:
-- 		    j <Down>		select item below
-- 		    k <Up>		select item above
-- 		    <Space> <Enter>	accept current selection
-- 		    x Esc CTRL-C	cancel the menu
-- 		Other keys are ignored.
--
-- 		A match is set on that line to highlight it, see
-- 		|popup_menu()|.
--
-- 		When the current selection is accepted the "callback" of the
-- 		popup menu is invoked with the index of the selected line as
-- 		the second argument.  The first entry has index one.
-- 		Cancelling the menu invokes the callback with -1.
--
-- 		To add shortcut keys, see the example here:
-- 		|popup_menu-shortcut-example|
--- @return number
function vim.fn.popup_filter_menu(id, key) end

-- The result is a Number, which is non-zero if a highlight group
-- 		called {name} exists.  This is when the group has been
-- 		defined in some way.  Not necessarily when highlighting has
-- 		been defined for it, it may also have been used for a syntax
-- 		item.
--- @return number
function vim.fn.hlexists(name) end

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

-- Get the |window-ID| for the popup info window, as it used by
-- 		the popup menu.  See |complete-popup|.  The info popup is
-- 		hidden when not used, it can be deleted with |popup_clear()|
-- 		and |popup_close()|.  Use |popup_show()| to reposition it to
-- 		the item in the popup menu.
-- 		Returns zero if there is none.
--- @return number
function vim.fn.popup_findinfo() end

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

-- The result is the number of a buffer, as it is displayed by
-- 		the ":ls" command.  For the use of {expr}, see |bufname()|
-- 		above.
-- 		If the buffer doesn't exist, -1 is returned.  Or, if the
-- 		{create} argument is present and not zero, a new, unlisted,
-- 		buffer is created and its number is returned.
-- 		bufnr("$") is the last buffer: >
-- 			:let last_buffer = bufnr("$")
-- <		The result is a Number, which is the highest buffer number
-- 		of existing buffers.  Note that not all buffers with a smaller
-- 		number necessarily exist, because ":bwipeout" may have removed
-- 		them.  Use bufexists() to test for the existence of a buffer.
--- @return number
function vim.fn.bufnr(expr, create) end

-- Set prompt callback for buffer {buf} to {expr}.  When {expr}
-- 		is an empty string the callback is removed.  This has only
-- 		effect if {buf} has 'buftype' set to "prompt".
--
-- 		The callback is invoked when pressing Enter.  The current
-- 		buffer will always be the prompt buffer.  A new line for a
-- 		prompt is added before invoking the callback, thus the prompt
-- 		for which the callback was invoked will be in the last but one
-- 		line.
-- 		If the callback wants to add text to the buffer, it must
-- 		insert it above the last line, since that is where the current
-- 		prompt is.  This can also be done asynchronously.
-- 		The callback is invoked with one argument, which is the text
-- 		that was entered at the prompt.  This can be an empty string
-- 		if the user only typed Enter.
-- 		Example: >
-- 		   call prompt_setcallback(bufnr(''), function('s:TextEntered'))
-- 		   func s:TextEntered(text)
-- 		     if a:text == 'exit' || a:text == 'quit'
-- 		       stopinsert
-- 		       close
-- 		     else
-- 		       call append(line('$') - 1, 'Entered: "' . a:text . '"')
-- 		       " Reset 'modified' to allow the buffer to be closed.
-- 		       set nomodified
-- 		     endif
-- 		   endfunc
--- @return none
function vim.fn.prompt_setcallback(buf, expr) end

-- Set prompt for buffer {buf} to {text}.  You most likely want
-- 		{text} to end in a space.
-- 		The result is only visible if {buf} has 'buftype' set to
-- 		"prompt".  Example: >
-- 			call prompt_setprompt(bufnr(''), 'command: ')
--- @return none
function vim.fn.prompt_setprompt(buf, text) end

-- Return the Number 1 if {expr} is empty, zero otherwise.
-- 		A |List| or |Dictionary| is empty when it does not have any
-- 		items.  A Number is empty when its value is zero.  Special
-- 		variable is empty when it is |v:false| or |v:null|.
--- @return number
function vim.fn.empty(expr) end

-- The result is a Number, which is the number of the first
-- 		window associated with buffer {expr}.  For the use of {expr},
-- 		see |bufname()| above.  If buffer {expr} doesn't exist or
-- 		there is no such window, -1 is returned.  Example: >
--
-- 	echo "A window containing buffer 1 is " . (bufwinnr(1))
--
-- <		The number can be used with |CTRL-W_w| and ":wincmd w"
-- 		|:wincmd|.
-- 		Only deals with the current tab page.
--- @return number
function vim.fn.bufwinnr(expr) end

-- Expand wildcards and the following special keywords in {expr}.
-- 		'wildignorecase' applies.
--
-- 		If {list} is given and it is |TRUE|, a List will be returned.
-- 		Otherwise the result is a String and when there are several
-- 		matches, they are separated by <NL> characters.
--
-- 		If the expansion fails, the result is an empty string.  A name
-- 		for a non-existing file is not included, unless {expr} does
-- 		not start with '%', '#' or '<', see below.
--
-- 		When {expr} starts with '%', '#' or '<', the expansion is done
-- 		like for the |cmdline-special| variables with their associated
-- 		modifiers.  Here is a short overview:
--
-- 			%		current file name
-- 			#		alternate file name
-- 			#n		alternate file name n
-- 			<cfile>		file name under the cursor
-- 			<afile>		autocmd file name
-- 			<abuf>		autocmd buffer number (as a String!)
-- 			<amatch>	autocmd matched name
-- 			<sfile>		sourced script file or function name
-- 			<slnum>		sourced script line number or function
-- 					line number
-- 			<sflnum>	script file line number, also when in
-- 					a function
-- 			<cword>		word under the cursor
-- 			<cWORD>		WORD under the cursor
-- 			<client>	the {clientid} of the last received
-- 					message |server2client()|
-- 		Modifiers:
-- 			:p		expand to full path
-- 			:h		head (last path component removed)
-- 			:t		tail (last path component only)
-- 			:r		root (one extension removed)
-- 			:e		extension only
--
-- 		Example: >
-- 			:let &tags = expand("%:p:h") . "/tags"
-- <		Note that when expanding a string that starts with '%', '#' or
-- 		'<', any following text is ignored.  This does NOT work: >
-- 			:let doesntwork = expand("%:h.bak")
-- <		Use this: >
-- 			:let doeswork = expand("%:h") . ".bak"
-- <		Also note that expanding "<cfile>" and others only returns the
-- 		referenced file name without further expansion.  If "<cfile>"
-- 		is "~/.cshrc", you need to do another expand() to have the
-- 		"~/" expanded into the path of the home directory: >
-- 			:echo expand(expand("<cfile>"))
-- <
-- 		There cannot be white space between the variables and the
-- 		following modifier.  The |fnamemodify()| function can be used
-- 		to modify normal file names.
--
-- 		When using '%' or '#', and the current or alternate file name
-- 		is not defined, an empty string is used.  Using "%:p" in a
-- 		buffer with no name, results in the current directory, with a
-- 		'/' added.
--
-- 		When {expr} does not start with '%', '#' or '<', it is
-- 		expanded like a file name is expanded on the command line.
-- 		'suffixes' and 'wildignore' are used, unless the optional
-- 		{nosuf} argument is given and it is |TRUE|.
-- 		Names for non-existing files are included.  The "**" item can
-- 		be used to search in a directory tree.  For example, to find
-- 		all "README" files in the current directory and below: >
-- 			:echo expand("**/README")
-- <
-- 		expand() can also be used to expand variables and environment
-- 		variables that are only known in a shell.  But this can be
-- 		slow, because a shell may be used to do the expansion.  See
-- 		|expr-env-expand|.
-- 		The expanded variable is still handled like a list of file
-- 		names.  When an environment variable cannot be expanded, it is
-- 		left unchanged.  Thus ":echo expand('$FOOBAR')" results in
-- 		"$FOOBAR".
--
-- 		See |glob()| for finding existing files.  See |system()| for
-- 		getting the raw output of an external command.
--- @param list any[]
function vim.fn.expand(expr, nosuf, list) end

-- current buffer.  The indent is counted in spaces, the value
-- 		of 'tabstop' is relevant.  {lnum} is used just like in
-- 		|getline()|.
-- 		When {lnum} is invalid -1 is returned.
--- @return number
function vim.fn.indent(lnum) end

-- Bitwise invert.  The argument is converted to a number.  A
-- 		List, Dict or Float argument causes an error.  Example: >
-- 			:let bits = invert(bits)
--- @return number
function vim.fn.invert(expr) end

-- Modify file name {fname} according to {mods}.  {mods} is a
-- 		string of characters like it is used for file names on the
-- 		command line.  See |filename-modifiers|.
-- 		Example: >
-- 			:echo fnamemodify("main.c", ":p:h")
-- <		results in: >
-- 			/home/mool/vim/vim/src
-- <		Note: Environment variables don't work in {fname}, use
-- 		|expand()| first then.
--- @return string
function vim.fn.fnamemodify(fname, mods) end

-- Return all of environment variables as dictionary. You can
-- 		check if an environment variable exists like this: >
-- 			:echo has_key(environ(), 'HOME')
-- <		Note that the variable name may be CamelCase; to ignore case
-- 		use this: >
-- 			:echo index(keys(environ()), 'HOME', 0, 1) != -1
--- @return dict
function vim.fn.environ() end

-- Escape the characters in {chars} that occur in {string} with a
-- 		backslash.  Example: >
-- 			:echo escape('c:\program files\vim', ' \')
-- <		results in: >
-- 			c:\\program\ files\\vim
-- <		Also see |shellescape()| and |fnameescape()|.
--- @return string
function vim.fn.escape(string, chars) end

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

-- Join the items in {list} together into one String.
-- 		When {sep} is specified it is put in between the items.  If
-- 		{sep} is omitted a single space is used.
-- 		Note that {sep} is not added at the end.  You might want to
-- 		add it there too: >
-- 			let lines = join(mylist, "\n") . "\n"
-- <		String items are used as-is.  |Lists| and |Dictionaries| are
-- 		converted into a string like with |string()|.
-- 		The opposite function is |split()|.
--- @param list any[]
--- @return string
function vim.fn.join(list, sep) end

-- Append the item {expr} to |List| {list}.  Returns the
-- 		resulting |List|.  Examples: >
-- 			:let alist = add([1, 2, 3], item)
-- 			:call add(mylist, "woodstock")
-- <		Note that when {expr} is a |List| it is appended as a single
-- 		item.  Use |extend()| to concatenate |Lists|.
-- 		Use |insert()| to add an item at another position.
--- @param list any[]
--- @return list
function vim.fn.add(list, item) end

-- Add a buffer to the buffer list with {name}.
-- 		If a buffer for file {name} already exists, return that buffer
-- 		number.  Otherwise return the buffer number of the newly
-- 		created buffer.  When {name} is an empty string then a new
-- 		buffer is always created.
-- 		The buffer will not have' 'buflisted' set.
--- @return number
function vim.fn.bufadd(name) end

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

-- Set line {lnum} of the current buffer to {text}.  To insert
-- 		lines use |append()|. To set lines in another buffer use
-- 		|setbufline()|.
--
-- 		{lnum} is used like with |getline()|.
-- 		When {lnum} is just below the last line the {text} will be
-- 		added as a new line.
--
-- 		If this succeeds, 0 is returned.  If this fails (most likely
-- 		because {lnum} is invalid) 1 is returned.
--
-- 		Example: >
-- 			:call setline(5, strftime("%c"))
--
-- <		When {text} is a |List| then line {lnum} and following lines
-- 		will be set to the items in the list.  Example: >
-- 			:call setline(5, ['aaa', 'bbb', 'ccc'])
-- <		This is equivalent to: >
-- 			:for [n, l] in [[5, 'aaa'], [6, 'bbb'], [7, 'ccc']]
-- 			:  call setline(n, l)
-- 			:endfor
--
-- <		Note: The '[ and '] marks are not set.
--- @return number
function vim.fn.setline(lnum, line) end

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

-- The result is the swap file path of the buffer {expr}.
-- 		For the use of {expr}, see |bufname()| above.
-- 		If buffer {expr} is the current buffer, the result is equal to
-- 		|:swapname| (unless no swap file).
-- 		If buffer {expr} has no swap file, returns an empty string.
--- @return string
function vim.fn.swapname(expr) end

-- {textlist} must be a |List| of strings.  This |List| is
-- 		displayed, one string per line.  The user will be prompted to
-- 		enter a number, which is returned.
-- 		The user can also select an item by clicking on it with the
-- 		mouse.  For the first string 0 is returned.  When clicking
-- 		above the first item a negative number is returned.  When
-- 		clicking on the prompt one more than the length of {textlist}
-- 		is returned.
-- 		Make sure {textlist} has less than 'lines' entries, otherwise
-- 		it won't work.  It's a good idea to put the entry number at
-- 		the start of the string.  And put a prompt in the first item.
-- 		Example: >
-- 			let color = inputlist(['Select color:', '1. red',
-- 				\ '2. green', '3. blue'])
--- @return number
function vim.fn.inputlist(textlist) end

-- Escape {string} for use as a shell command argument.
-- 		On Windows when 'shellslash' is not set, it
-- 		will enclose {string} in double quotes and double all double
-- 		quotes within {string}.
-- 		Otherwise, it will enclose {string} in single quotes and
-- 		replace all "'" with "'\''".
--
-- 		When the {special} argument is present and it's a non-zero
-- 		Number or a non-empty String (|non-zero-arg|), then special
-- 		items such as "!", "%", "#" and "<cword>" will be preceded by
-- 		a backslash.  This backslash will be removed again by the |:!|
-- 		command.
--
-- 		The "!" character will be escaped (again with a |non-zero-arg|
-- 		{special}) when 'shell' contains "csh" in the tail.  That is
-- 		because for csh and tcsh "!" is used for history replacement
-- 		even when inside single quotes.
--
-- 		With a |non-zero-arg| {special} the <NL> character is also
-- 		escaped.  When 'shell' containing "csh" in the tail it's
-- 		escaped a second time.
--
-- 		Example of use with a |:!| command: >
-- 		    :exe '!dir ' . shellescape(expand('<cfile>'), 1)
-- <		This results in a directory listing for the file under the
-- 		cursor.  Example of use with |system()|: >
-- 		    :call system("chmod +w -- " . shellescape(expand("%")))
-- <		See also |::S|.
--- @return string
function vim.fn.shellescape(string, special) end

-- Returns Dictionary of |api-metadata|.
--
-- 		View it in a nice human-readable format: >
-- 		       :lua print(vim.inspect(vim.fn.api_info()))
--- @return dict
function vim.fn.api_info() end

-- The result is the number of files in the argument list.  See
-- 		|arglist|.
-- 		If {winid} is not supplied, the argument list of the current
-- 		window is used.
-- 		If {winid} is -1, the global argument list is used.
-- 		Otherwise {winid} specifies the window of which the argument
-- 		list is used: either the window number or the window ID.
-- 		Returns -1 if the {winid} argument is invalid.
--- @return number
function vim.fn.argc(winid) end

-- The result is the {nr}th file in the argument list.  See
-- 		|arglist|.  "argv(0)" is the first one.  Example: >
-- 	:let i = 0
-- 	:while i < argc()
-- 	:  let f = escape(fnameescape(argv(i)), '.')
-- 	:  exe 'amenu Arg.' . f . ' :e ' . f . '<CR>'
-- 	:  let i = i + 1
-- 	:endwhile
-- <		Without the {nr} argument, or when {nr} is -1, a |List| with
-- 		the whole |arglist| is returned.
--
-- 		The {winid} argument specifies the window ID, see |argc()|.
--- @return list
function vim.fn.argv(_1, winid) end

-- the first file.  argc() - 1 is the last one.  See |arglist|.
--- @return number
function vim.fn.argidx() end

-- Return the argument list ID.  This is a number which
-- 		identifies the argument list being used.  Zero is used for the
-- 		global argument list.  See |arglist|.
-- 		Returns -1 if the arguments are invalid.
--
-- 		Without arguments use the current window.
-- 		With {winnr} only use this window in the current tab page.
-- 		With {winnr} and {tabnr} use the window in the specified tab
-- 		page.
-- 		{winnr} can be the window number or the |window-ID|.
--- @return number
function vim.fn.arglistid(winnr, tabnr) end

-- Return a |List| with all the key-value pairs of {dict}.  Each
-- 		|List| item is a list with two items: the key of a {dict}
-- 		entry and the value of this entry.  The |List| is in arbitrary
-- 		order.
--- @param dict dictionary
--- @return list
function vim.fn.items(dict) end

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

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce a beep or visual bell.
-- 		Also see |assert_fails()| and |assert-return|.
--- @return number
function vim.fn.assert_beeps(cmd) end

--- @param list any[]
--- @return list
function vim.fn.sign_unplacelist(list) end

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

-- When v:exception does not contain the string {error} an error
-- 		message is added to |v:errors|.  Also see |assert-return|.
-- 		This can be used to assert that a command throws an exception.
-- 		Using the error number, followed by a colon, avoids problems
-- 		with translations: >
-- 			try
-- 			  commandthatfails
-- 			  call assert_false(1, 'command should have failed')
-- 			catch
-- 			  call assert_exception('E492:')
-- 			endtry
--- @return number
function vim.fn.assert_exception(error, msg) end

-- Run {cmd} and add an error message to |v:errors| if it does
-- 		NOT produce an error.  Also see |assert-return|.
-- 		When {error} is given it must match in |v:errmsg|.
-- 		Note that beeping is not considered an error, and some failing
-- 		commands only beep.  Use |assert_beeps()| for those.
--- @return number
function vim.fn.assert_fails(cmd, error) end

-- When {actual} is not false an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is false when it is zero or |v:false|. When "{actual}"
-- 		is not a number or |v:false| the assert fails.
-- 		When {msg} is omitted an error in the form
-- 		"Expected False but got {actual}" is produced.
--- @return number
function vim.fn.assert_false(actual, msg) end

-- This asserts number and |Float| values.  When {actual}  is lower
-- 		than {lower} or higher than {upper} an error message is added
-- 		to |v:errors|.  Also see |assert-return|.
-- 		When {msg} is omitted an error in the form
-- 		"Expected range {lower} - {upper}, but got {actual}" is
-- 		produced.
--- @return number
function vim.fn.assert_inrange(lower, upper, actual, msg) end

-- Like |strpart()| but using character index and length instead
-- 		of byte index and length.
-- 		When a character index is used where a character does not
-- 		exist it is assumed to be one character.  For example: >
-- 			strcharpart('abc', -1, 2)
-- <		results in 'a'.
--- @return string
function vim.fn.strcharpart(str, start, len) end

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

-- The opposite of `assert_equal()`: add an error message to
-- 		|v:errors| when {expected} and {actual} are equal.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notequal(exp, act, msg) end

-- The opposite of `assert_match()`: add an error message to
-- 		|v:errors| when {pattern} matches {actual}.
-- 		Also see |assert-return|.
--- @return number
function vim.fn.assert_notmatch(pat, text, msg) end

-- Report a test failure directly, using {msg}.
-- 		Always returns one.
--- @return number
function vim.fn.assert_report(msg) end

-- When {actual} is not true an error message is added to
-- 		|v:errors|, like with |assert_equal()|.
-- 		Also see |assert-return|.
-- 		A value is |TRUE| when it is a non-zero number or |v:true|.
-- 		When {actual} is not a number or |v:true| the assert fails.
-- 		When {msg} is omitted an error in the form "Expected True but
-- 		got {actual}" is produced.
--- @return number
function vim.fn.assert_true(actual, msg) end

-- different from using {expr} directly.
-- 		When {expr} is a |List| a shallow copy is created.  This means
-- 		that the original |List| can be changed without changing the
-- 		copy, and vice versa.  But the items are identical, thus
-- 		changing an item changes the contents of both |Lists|.
-- 		A |Dictionary| is copied in a similar way as a |List|.
-- 		Also see |deepcopy()|.
function vim.fn.copy(expr) end

-- Returns a |String| which is a unique identifier of the
-- 		container type (|List|, |Dict| and |Partial|). It is
-- 		guaranteed that for the mentioned types `id(v1) ==# id(v2)`
-- 		returns true iff `type(v1) == type(v2) && v1 is v2` (note:
-- 		|v:_null_list| and |v:_null_dict| have the same `id()` with
-- 		different types because they are internally represented as
-- 		a NULL pointers). Currently `id()` returns a hexadecimal
-- 		representanion of the pointers to the containers (i.e. like
-- 		`0x994a40`), same as `printf("%p", {expr})`, but it is advised
-- 		against counting on exact format of return value.
--
-- 		It is not guaranteed that `id(no_longer_existing_container)`
-- 		will not be equal to some other `id()`: new containers may
-- 		reuse identifiers of the garbage-collected ones.
--- @return string
function vim.fn.id(expr) end

-- Returns a |List| with Numbers:
-- 		- If only {expr} is specified: [0, 1, ..., {expr} - 1]
-- 		- If {max} is specified: [{expr}, {expr} + 1, ..., {max}]
-- 		- If {stride} is specified: [{expr}, {expr} + {stride}, ...,
-- 		  {max}] (increasing {expr} with {stride} each time, not
-- 		  producing a value past {max}).
-- 		When the maximum is one before the start the result is an
-- 		empty list.  When the maximum is more than one before the
-- 		start this is an error.
-- 		Examples: >
-- 			range(4)		" [0, 1, 2, 3]
-- 			range(2, 4)		" [2, 3, 4]
-- 			range(2, 9, 3)		" [2, 5, 8]
-- 			range(2, -2, -1)	" [2, 1, 0, -1, -2]
-- 			range(0)		" []
-- 			range(2, 0)		" error!
-- <
--- @return list
function vim.fn.range(expr, max, stride) end

-- Returns a Dictionary with information about Insert mode
-- 		completion.  See |ins-completion|.
-- 		The items are:
-- 		   mode		Current completion mode name string.
-- 				See |complete_info_mode| for the values.
-- 		   pum_visible	|TRUE| if popup menu is visible.
-- 				See |pumvisible()|.
-- 		   items	List of completion matches.  Each item is a
-- 				dictionary containing the entries "word",
-- 				"abbr", "menu", "kind", "info" and "user_data".
-- 				See |complete-items|.
-- 		   selected	Selected item index.  First index is zero.
-- 				Index is -1 if no item is selected (showing
-- 				typed text only)
-- 		   inserted	Inserted string. [NOT IMPLEMENT YET]
--
-- 							*complete_info_mode*
-- 		mode values are:
-- 		   ""		     Not in completion mode
-- 		   "keyword"	     Keyword completion |i_CTRL-X_CTRL-N|
-- 		   "ctrl_x"	     Just pressed CTRL-X |i_CTRL-X|
-- 		   "whole_line"	     Whole lines |i_CTRL-X_CTRL-L|
-- 		   "files"	     File names |i_CTRL-X_CTRL-F|
-- 		   "tags"	     Tags |i_CTRL-X_CTRL-]|
-- 		   "path_defines"    Definition completion |i_CTRL-X_CTRL-D|
-- 		   "path_patterns"   Include completion |i_CTRL-X_CTRL-I|
-- 		   "dictionary"	     Dictionary |i_CTRL-X_CTRL-K|
-- 		   "thesaurus"	     Thesaurus |i_CTRL-X_CTRL-T|
-- 		   "cmdline"	     Vim Command line |i_CTRL-X_CTRL-V|
-- 		   "function"	     User defined completion |i_CTRL-X_CTRL-U|
-- 		   "omni"	     Omni completion |i_CTRL-X_CTRL-O|
-- 		   "spell"	     Spelling suggestions |i_CTRL-X_s|
-- 		   "eval"            |complete()| completion
-- 		   "unknown"	     Other internal modes
--
-- 		If the optional {what} list argument is supplied, then only
-- 		the items listed in {what} are returned.  Unsupported items in
-- 		{what} are silently ignored.
--
-- 		To get the position and size of the popup menu, see
-- 		|pum_getpos()|. It's also available in |v:event| during the
-- 		|CompleteChanged| event.
--
-- 		Examples: >
-- 			" Get all items
-- 			call complete_info()
-- 			" Get only 'mode'
-- 			call complete_info(['mode'])
-- 			" Get only 'mode' and 'pum_visible'
-- 			call complete_info(['mode', 'pum_visible'])
-- <
--- @return dict
function vim.fn.complete_info(what) end

-- Create a timer and return the timer ID.
--
-- 		{time} is the waiting time in milliseconds. This is the
-- 		minimum time before invoking the callback.  When the system is
-- 		busy or Vim is not waiting for input the time will be longer.
--
-- 		{callback} is the function to call.  It can be the name of a
-- 		function or a |Funcref|.  It is called with one argument, which
-- 		is the timer ID.  The callback is only invoked when Vim is
-- 		waiting for input.
--
-- 		{options} is a dictionary.  Supported entries:
-- 		   "repeat"	Number of times to repeat the callback.
-- 				-1 means forever.  Default is 1.
-- 				If the timer causes an error three times in a
-- 				row the repeat is cancelled.
--
-- 		Example: >
-- 			func MyHandler(timer)
-- 			  echo 'Handler called'
-- 			endfunc
-- 			let timer = timer_start(500, 'MyHandler',
-- 				\ {'repeat': 3})
-- <		This invokes MyHandler() three times at 500 msec intervals.
--- @return number
function vim.fn.timer_start(time, callback, options) end

-- Stop a timer.  The timer callback will no longer be invoked.
-- 		{timer} is an ID returned by timer_start(), thus it must be a
-- 		Number.  If {timer} does not exist there is no error.
--- @return none
function vim.fn.timer_stop(timer) end

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

-- Return a |List| with spelling suggestions to replace {word}.
-- 		When {max} is given up to this number of suggestions are
-- 		returned.  Otherwise up to 25 suggestions are returned.
--
-- 		When the {capital} argument is given and it's non-zero only
-- 		suggestions with a leading capital will be given.  Use this
-- 		after a match with 'spellcapcheck'.
--
-- 		{word} can be a badly spelled word followed by other text.
-- 		This allows for joining two words that were split.  The
-- 		suggestions also include the following text, thus you can
-- 		replace a line.
--
-- 		{word} may also be a good word.  Similar words will then be
-- 		returned.  {word} itself is not included in the suggestions,
-- 		although it may appear capitalized.
--
-- 		The spelling information for the current window is used.  The
-- 		'spell' option must be set and the values of 'spelllang' and
-- 		'spellsuggest' are used.
--- @return list
function vim.fn.spellsuggest(word, max, capital) end

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

