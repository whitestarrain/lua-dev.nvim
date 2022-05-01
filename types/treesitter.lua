--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

--- @class vim.treesitter.LanguageTree
vim.treesitter.LanguageTree = {}

-- Adds a child language to this tree.
--- @param lang any #The language to add.
function vim.treesitter.LanguageTree:add_child(lang) end

-- Returns a map of language to child tree.
function vim.treesitter.LanguageTree:children() end

-- Determines whether {range} is contained in this language tree
--- @param range any #A range, that is a `{ start_line, start_col,
---              end_line, end_col }` table.
function vim.treesitter.LanguageTree:contains(range) end

-- Destroys this language tree and all its children.
function vim.treesitter.LanguageTree:destroy() end

-- Invokes the callback for each LanguageTree and it's children
-- recursively
--- @param fn fun(...) #The function to invoke. This is invoked
---                     with arguments (tree: LanguageTree, lang:
---                     string)
--- @param include_self any #Whether to include the invoking tree in
---                     the results.
function vim.treesitter.LanguageTree:for_each_child(fn, include_self) end

-- Invokes the callback for each treesitter trees recursively.
--- @param fn fun(...) #The callback to invoke. The callback is invoked
---             with arguments (tree: TSTree, languageTree:
---             LanguageTree)
function vim.treesitter.LanguageTree:for_each_tree(fn) end

-- Gets the set of included regions
function vim.treesitter.LanguageTree:included_regions() end

-- Invalidates this parser and all its children
function vim.treesitter.LanguageTree:invalidate(reload) end

-- Determines whether this tree is valid. If the tree is invalid,
-- call `parse()` . This will return the updated tree.
function vim.treesitter.LanguageTree:is_valid() end

-- Gets the language of this tree node.
function vim.treesitter.LanguageTree:lang() end

-- Gets the appropriate language that contains {range}
--- @param range any #A text range, see |LanguageTree:contains|
function vim.treesitter.LanguageTree:language_for_range(range) end

-- Parses all defined regions using a treesitter parser for the
-- language this tree represents. This will run the injection
-- query for this language to determine if any child languages
-- should be created.
function vim.treesitter.LanguageTree:parse() end

-- Registers callbacks for the parser.
--- @param cbs any #table An |nvim_buf_attach()|-like table argument
---             with the following keys :
---             • `on_bytes` : see |nvim_buf_attach()|, but this will be
---               called after the parsers callback.
---             • `on_changedtree` : a callback that will be
---               called every time the tree has syntactical
---               changes. It will only be passed one argument,
---               which is a table of the ranges (as node ranges)
---               that changed.
---             • `on_child_added` : emitted when a child is added
---               to the tree.
---             • `on_child_removed` : emitted when a child is
---               removed from the tree.
function vim.treesitter.LanguageTree:register_cbs(cbs) end

-- Removes a child language from this tree.
--- @param lang any #The language to remove.
function vim.treesitter.LanguageTree:remove_child(lang) end

-- Sets the included regions that should be parsed by this
-- parser. A region is a set of nodes and/or ranges that will be
-- parsed in the same context.
--- @param regions any #A list of regions this tree should manage and
---                parse.
function vim.treesitter.LanguageTree:set_included_regions(regions) end

-- Returns the source content of the language tree (bufnr or
-- string).
function vim.treesitter.LanguageTree:source() end

-- Returns all trees this language tree contains. Does not
-- include child languages.
function vim.treesitter.LanguageTree:trees() end

--- @class vim.treesitter.Query
vim.treesitter.Query = {}

-- Iterate over all captures from all matches inside {node}
--- @param node any #The node under which the search will occur
--- @param source any #The source buffer or string to extract text from
--- @param start any #The starting line of the search
--- @param stop any #The stopping line of the search (end-exclusive)
--- @return any #The matching capture id
--- @return any #The captured node
function vim.treesitter.Query:iter_captures(node, source, start, stop) end

-- Iterates the matches of self on a given range.
--- @param node any #The node under which the search will occur
--- @param source any #The source buffer or string to search
--- @param start any #The starting line of the search
--- @param stop any #The stopping line of the search (end-exclusive)
--- @return any #The matching pattern id
--- @return any #The matching match
function vim.treesitter.Query:iter_matches(node, source, start, stop) end

--- @class vim.treesitter.TSHighlighter
vim.treesitter.TSHighlighter = {}

-- Removes all internal references to the highlighter
function vim.treesitter.TSHighlighter:destroy() end

-- Gets the query used for
--- @param lang any #A language used by the highlighter.
function vim.treesitter.TSHighlighter:get_query(lang) end

-- Gets the parser for this bufnr / ft combination.
--- @param bufnr any #The buffer the parser should be tied to
--- @param lang any #The filetype of this parser
--- @param opts any #Options object to pass to the created language
---              tree
--- @return any #The parser
function vim.treesitter.get_parser(bufnr, lang, opts) end

-- Gets a string parser
--- @param str any #The string to parse
--- @param lang any #The language of this string
--- @param opts any #Options to pass to the created language tree
function vim.treesitter.get_string_parser(str, lang, opts) end

-- Inspects the provided language.
--- @param lang any #The language.
function vim.treesitter.inspect_language(lang) end

-- Represents a single treesitter parser for a language. The
-- language can contain child languages with in its range, hence
-- the tree.
--- @param source any #Can be a bufnr or a string of text to
---                        parse
--- @param lang any #The language this tree represents
--- @param opts any #Options table
function vim.treesitter.new(source, lang, opts) end

-- Adds a new directive to be used in queries
--- @param name any #the name of the directive, without leading #
--- @param handler any #the handler function to be used signature will
---                be (match, pattern, bufnr, predicate)
function vim.treesitter.query.add_directive(name, handler, force) end

-- Adds a new predicate to be used in queries
--- @param name any #the name of the predicate, without leading #
--- @param handler any #the handler function to be used signature will
---                be (match, pattern, bufnr, predicate)
function vim.treesitter.query.add_predicate(name, handler, force) end

-- Gets the text corresponding to a given node
--- @param node any #the node
--- @param source any #The buffer or string from which the node is
---               extracted
function vim.treesitter.query.get_node_tex(node, source) end

-- Returns the runtime query {query_name} for {lang}.
--- @param lang any #The language to use for the query
--- @param query_name any #The name of the query (i.e. "highlights")
--- @return any #The corresponding query, parsed.
function vim.treesitter.query.get_query(lang, query_name) end

-- Gets the list of files used to make up a query
--- @param lang any #The language
--- @param query_name any #The name of the query to load
--- @param is_included any #Internal parameter, most of the time left
---                    as `nil`
function vim.treesitter.query.get_query_files(lang, query_name, is_included) end

--- @return any #The list of supported directives.
function vim.treesitter.query.list_directives() end

--- @return any #The list of supported predicates.
function vim.treesitter.query.list_predicates() end

-- Parse {query} as a string. (If the query is in a file, the
-- caller should read the contents into a string before calling).
--- @param lang any #string The language
--- @param query any #string A string containing the query (s-expr
---              syntax)
--- @return any #The query
function vim.treesitter.query.parse_query(lang, query) end

-- The explicitly set queries from
-- |vim.treesitter.query.set_query()|.
--- @param lang any #string: The language to use for the query
--- @param query_name any #string: The name of the query (i.e.
---                   "highlights")
--- @param text any #string: The query text (unparsed).
function vim.treesitter.query.set_query(lang, query_name, text) end

-- Asserts that the provided language is installed, and
-- optionally provide a path for the parser
--- @param lang any #The language the parser should parse
--- @param path any #Optional path the parser is located at
--- @param silent any #Don't throw an error if language not found
function vim.treesitter.require_language(lang, path, silent) end

