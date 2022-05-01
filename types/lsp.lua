--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Add the folder at path to the workspace folders. If {path} is
-- not provided, the user will be prompted for a path using
-- |input()|.
function vim.lsp.add_workspace_folder(workspace_folder) end

-- Applies a `TextDocumentEdit`, which is a list of changes to a
-- single document.
--- @param text_document_edit any #table: a `TextDocumentEdit` object
--- @param index any #number: Optional index of the edit,
---                           if from a list of edits (or nil, if
---                           not from a list)
function vim.lsp.apply_text_document_edit(text_document_edit, index, offset_encoding) end

-- Applies a list of text edits to a buffer.
--- @param text_edits any #table list of `TextEdit` objects
--- @param bufnr any #number Buffer id
--- @param offset_encoding any #string utf-8|utf-16|utf-32
function vim.lsp.apply_text_edits(text_edits, bufnr, offset_encoding) end

-- Applies a `WorkspaceEdit`.
--- @param workspace_edit any #table `WorkspaceEdit`
--- @param offset_encoding any #string utf-8|utf-16|utf-32 (required)
function vim.lsp.apply_workspace_edit(workspace_edit, offset_encoding) end

-- Implements the `textDocument/did…` notifications required to
-- track a buffer for any language server.
--- @param bufnr any #(number) Buffer handle, or 0 for current
--- @param client_id any #(number) Client id
function vim.lsp.buf_attach_client(bufnr, client_id) end

-- Removes document highlights from a buffer.
--- @param bufnr any #number Buffer id
function vim.lsp.buf_clear_references(bufnr) end

-- Detaches client from the specified buffer. Note: While the
-- server is notified that the text document (buffer) was closed,
-- it is still able to send notifications should it ignore this
-- notification.
--- @param bufnr any #number Buffer handle, or 0 for current
--- @param client_id any #number Client id
function vim.lsp.buf_detach_client(bufnr, client_id) end

-- Gets a map of client_id:client pairs for the given buffer,
-- where each value is a |vim.lsp.client| object.
--- @param bufnr any #(optional, number): Buffer handle, or 0 for
---              current
function vim.lsp.buf_get_clients(bufnr) end

-- Shows a list of document highlights for a certain buffer.
--- @param bufnr any #number Buffer id
--- @param references any #table List of `DocumentHighlight`
---                        objects to highlight
--- @param offset_encoding any #string One of "utf-8", "utf-16",
---                        "utf-32".
function vim.lsp.buf_highlight_references(bufnr, references, offset_encoding) end

-- Checks if a buffer is attached for a particular client.
--- @param bufnr any #(number) Buffer handle, or 0 for current
--- @param client_id any #(number) the client id
function vim.lsp.buf_is_attached(bufnr, client_id) end

-- Send a notification to a server
--- @param bufnr any #[number] (optional): The number of the buffer
--- @param method any #[string]: Name of the request method
--- @param params any #[string]: Arguments to send to the server
--- @return any #true if any client returns true; false otherwise
function vim.lsp.buf_notify(bufnr, method, params) end

-- Sends an async request for all active clients attached to the
-- buffer.
--- @param bufnr any #(number) Buffer handle, or 0 for current.
--- @param method any #(string) LSP method name
--- @param params any #(optional, table) Parameters to send to the
---                server
--- @param handler any #(optional, function) See |lsp-handler| If nil,
---                follows resolution strategy defined in
---                |lsp-handler-configuration|
--- @return any #2-tuple:
---     • Map of client-id:request-id pairs for all successful
---       requests.
---     • Function which can be used to cancel all the requests.
---       You could instead iterate all clients and call their
---       `cancel_request()` methods.
function vim.lsp.buf_request(bufnr, method, params, handler) end

-- Sends an async request for all active clients attached to the
-- buffer. Executes the callback on the combined result.
-- Parameters are the same as |vim.lsp.buf_request()| but the
-- return result and callback are different.
--- @param bufnr any #(number) Buffer handle, or 0 for current.
--- @param method any #(string) LSP method name
--- @param params any #(optional, table) Parameters to send to the
---                 server
--- @param callback any #(function) The callback to call when all
---                 requests are finished.
--- @return any #(function) A function that will cancel all requests which
---     is the same as the one returned from `buf_request`.
function vim.lsp.buf_request_all(bufnr, method, params, callback) end

-- Sends a request to all server and waits for the response of
-- all of them.
--- @param bufnr any #(number) Buffer handle, or 0 for current.
--- @param method any #(string) LSP method name
--- @param params any #(optional, table) Parameters to send to the
---                   server
--- @param timeout_ms any #(optional, number, default=1000) Maximum
---                   time in milliseconds to wait for a result.
--- @return any #Map of client_id:request_result. On timeout, cancel or
---     error, returns `(nil, err)` where `err` is a string
---     describing the failure reason.
function vim.lsp.buf_request_sync(bufnr, method, params, timeout_ms) end

-- Returns the UTF-32 and UTF-16 offsets for a position in a
-- certain buffer.
--- @param buf any #buffer id (0 for current)
--- @param row any #0-indexed line
--- @param col any #0-indexed byte offset in line
--- @param offset_encoding any #string utf-8|utf-16|utf-32|nil defaults
---                        to `offset_encoding` of first client of
---                        `buf`
--- @return any #(number, number) `offset_encoding` index of the character
---     in line {row} column {col} in buffer {buf}
function vim.lsp.character_offset(buf, row, col, offset_encoding) end

-- Removes document highlights from current buffer.
function vim.lsp.clear_references() end

-- LSP client object. You can get an active client object via
-- |vim.lsp.get_client_by_id()| or
-- |vim.lsp.get_active_clients()|.
function vim.lsp.client() end

-- Checks whether a client is stopped.
--- @param client_id any #(Number)
--- @return any #true if client is stopped, false otherwise.
function vim.lsp.client_is_stopped(client_id) end

-- Selects a code action available at the current cursor
-- position.
--- @param options any #table|nil Optional table which holds the
---                following optional fields:
---                • context (table|nil): Corresponds to `CodeActionContext` of the LSP specification:
---                  • diagnostics (table|nil): LSP`Diagnostic[]` . Inferred from the current position if not
---                    provided.
---                  • only (string|nil): LSP `CodeActionKind`
---                    used to filter the code actions. Most
---                    language servers support values like
---                    `refactor` or `quickfix`.
---
---                • filter (function|nil): Predicate function
---                  taking an `CodeAction` and returning a
---                  boolean.
---                • apply (boolean|nil): When set to `true`, and
---                  there is just one remaining action (after
---                  filtering), the action is applied without
---                  user query.
function vim.lsp.code_action(options) end

-- Retrieves the completion items at the current cursor position.
-- Can only be called in Insert mode.
--- @param context any #(context support not yet implemented)
---                Additional information about the context in
---                which a completion was triggered (how it was
---                triggered, and by which trigger character, if
---                applicable)
function vim.lsp.completion(context) end

-- Returns the range table for the difference between prev and
-- curr lines
--- @param prev_lines any #table list of lines
--- @param curr_lines any #table list of lines
--- @param firstline any #number line to begin search for first
---                        difference
--- @param lastline any #number line to begin search in
---                        old_lines for last difference
--- @param new_lastline any #number line to begin search in
---                        new_lines for last difference
--- @param offset_encoding any #string encoding requested by language
---                        server
--- @return any #table TextDocumentContentChangeEvent see https://microsoft.github.io/language-server-protocol/specifications/specification-3-17/#textDocumentContentChangeEvent
function vim.lsp.compute_diff(prev_lines, curr_lines, firstline, lastline, new_lastline, offset_encoding, line_ending) end

-- Converts any of `MarkedString` | `MarkedString[]` |
-- `MarkupContent` into a list of lines containing valid
-- markdown. Useful to populate the hover window for
-- `textDocument/hover`, for parsing the result of
-- `textDocument/signatureHelp`, and potentially others.
--- @param input any #(`MarkedString` | `MarkedString[]` |
---                 `MarkupContent`)
--- @param contents any #(table, optional, default `{}`) List of
---                 strings to extend with converted lines
--- @return any #{contents}, extended with lines of converted markdown.
function vim.lsp.convert_input_to_markdown_lines(input, contents) end

-- Converts `textDocument/SignatureHelp` response to markdown
-- lines.
--- @param signature_help any #Response of `textDocument/SignatureHelp`
--- @param ft any #optional filetype that will be use as
---                       the `lang` for the label markdown code
---                       block
--- @param triggers any #optional list of trigger characters from
---                       the lsp server. used to better determine
---                       parameter offsets
--- @return any #list of lines of converted markdown.
function vim.lsp.convert_signature_help_to_markdown_lines(signature_help, ft, triggers) end

-- Jumps to the declaration of the symbol under the cursor.
-- Note:
--     Many servers do not implement this method. Generally, see
--     |vim.lsp.buf.definition()| instead.
function vim.lsp.declaration() end

-- Jumps to the definition of the symbol under the cursor.
function vim.lsp.definition() end

-- Display the lenses using virtual text
--- @param lenses any #table of lenses to display (`CodeLens[] |
---                  null`)
--- @param bufnr any #number
--- @param client_id any #number
function vim.lsp.display(lenses, bufnr, client_id) end

-- Send request to the server to resolve document highlights for
-- the current text document position. This request can be
-- triggered by a key mapping or by events such as `CursorHold`,
-- e.g.:
function vim.lsp.document_highlight() end

-- Lists all symbols in the current buffer in the quickfix
-- window.
function vim.lsp.document_symbol() end

-- Executes an LSP server command.
--- @param command_params any #table A valid `ExecuteCommandParams`
---                       object
function vim.lsp.execute_command(command_params) end

-- Can be used to extract the completion items from a `textDocument/completion` request, which may return one of `CompletionItem[]` , `CompletionList` or null.
--- @param result any #(table) The result of a
---               `textDocument/completion` request
--- @return any #(table) List of completion items
function vim.lsp.extract_completion_items(result) end

-- Invokes a function for each LSP client attached to a buffer.
--- @param bufnr any #number Buffer number
--- @param fn fun(...) #function Function to run on each client attached
---              to buffer {bufnr}. The function takes the client,
---              client ID, and buffer number as arguments.
---              Example: >
---
---                vim.lsp.for_each_buffer_client(0, function(client, client_id, bufnr)
---                  print(vim.inspect(client))
---                end)
---
--- <
function vim.lsp.for_each_buffer_client(bufnr, fn) end

-- Formats a buffer using the attached (and optionally filtered)
-- language server clients.
--- @param options any #table|nil Optional table which holds the
---                following optional fields:
---                • formatting_options (table|nil): Can be used
---                  to specify FormattingOptions. Some
---                  unspecified options will be automatically
---                  derived from the current Neovim options.
function vim.lsp.format(options) end

-- Mapping of error codes used by the client.
--- @return any #(string) The formatted error message
function vim.lsp.format_rpc_error() end

-- Provides an interface between the built-in client and a
-- `formatexpr` function.
--- @param opts any #table options for customizing the formatting
---             expression which takes the following optional
---             keys:
---             • timeout_ms (default 500ms). The timeout period
---               for the formatting request.
function vim.lsp.formatexpr(opts) end

-- Formats the current buffer.
--- @param options any #(table|nil) Can be used to specify
---                FormattingOptions. Some unspecified options
---                will be automatically derived from the current
---                Neovim options.
function vim.lsp.formatting(options) end

-- Formats the current buffer by sequentially requesting
-- formatting from attached clients.
--- @param options any #(table|nil) `FormattingOptions` entries
--- @param timeout_ms any #(number|nil) Request timeout
--- @param order any #(table|nil) List of client names. Formatting
---                   is requested from clients in the following
---                   order: first all clients that are not in the
---                   `order` list, then the remaining clients in
---                   the order as they occur in the `order` list.
function vim.lsp.formatting_seq_sync(options, timeout_ms, order) end

-- Performs |vim.lsp.buf.formatting()| synchronously.
--- @param options any #table|nil with valid `FormattingOptions`
---                   entries
--- @param timeout_ms any #(number) Request timeout
function vim.lsp.formatting_sync(options, timeout_ms) end

-- Return all lenses for the given buffer
--- @param bufnr any #number Buffer number. 0 can be used for the
---              current buffer.
--- @return any #table (`CodeLens[]`)
function vim.lsp.get(bufnr) end

-- Gets all active clients.
--- @return any #Table of |vim.lsp.client| objects
function vim.lsp.get_active_clients() end

-- Returns list of buffers attached to client_id.
--- @param client_id any #number client id
--- @return any #list of buffer ids
function vim.lsp.get_buffers_by_client_id(client_id) end

-- Gets a client by id, or nil if the id is invalid. The returned
-- client may not yet be fully initialized.
--- @param client_id any #number client id
--- @return any #|vim.lsp.client| object, or nil
function vim.lsp.get_client_by_id(client_id) end

-- Returns indentation size.
--- @param bufnr any #(number|nil): Buffer handle, defaults to current
--- @return any #(number) indentation size
function vim.lsp.get_effective_tabstop(bufnr) end

-- Returns the log filename.
--- @return any #(string) log filename
function vim.lsp.get_filename() end

-- Gets the current log level.
--- @return any #string current log level
function vim.lsp.get_level() end

-- Gets the path of the logfile used by the LSP client.
--- @return any #(String) Path to logfile.
function vim.lsp.get_log_path() end

-- Get the diagnostic namespace associated with an LSP client
-- |vim.diagnostic|.
--- @param client_id any #number The id of the LSP client
function vim.lsp.get_namespace(client_id) end

-- |lsp-handler| for the method "textDocument/hover" >
--
--  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--    vim.lsp.handlers.hover, {
--      -- Use a sharp border with `FloatBorder` highlights
--      border = "single"
--    }
--  )
--
-- <
--- @param config any #table Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |nvim_open_win()|
function vim.lsp.hover(_, result, ctx, config) end

-- Lists all the implementations for the symbol under the cursor
-- in the quickfix window.
function vim.lsp.implementation() end

-- Lists all the call sites of the symbol under the cursor in the
-- |quickfix| window. If the symbol can resolve to multiple
-- items, the user can pick one in the |inputlist|.
function vim.lsp.incoming_calls() end

-- Jumps to a location.
--- @param location any #table (`Location`|`LocationLink`)
--- @param offset_encoding any #string utf-8|utf-16|utf-32 (required)
--- @return any #`true` if the jump succeeded
function vim.lsp.jump_to_location(location, offset_encoding) end

-- List workspace folders.
function vim.lsp.list_workspace_folders() end

-- Returns the items with the byte position calculated correctly
-- and in sorted order, for display in quickfix and location
-- lists.
--- @param locations any #table list of `Location`s or
---                        `LocationLink`s
--- @param offset_encoding any #string offset_encoding for locations
---                        utf-8|utf-16|utf-32
--- @return any #(table) list of items
function vim.lsp.locations_to_items(locations, offset_encoding) end

-- Helper function to return nested values in language server
-- settings
--- @param settings any #a table of language server settings
--- @param section any #a string indicating the field of the settings
---                 table
--- @return any #(table or string) The value of settings accessed via
---     section
function vim.lsp.lookup_section(settings, section) end

-- Gets a new ClientCapabilities object describing the LSP client
-- capabilities.
function vim.lsp.make_client_capabilities() end

-- Creates a table with sensible default options for a floating
-- window. The table can be passed to |nvim_open_win()|.
--- @param width any #(number) window width (in character cells)
--- @param height any #(number) window height (in character cells)
--- @param opts any #(table, optional)
---               • offset_x (number) offset to add to `col`
---               • offset_y (number) offset to add to `row`
---               • border (string or table) override `border`
---               • focusable (string or table) override
---                 `focusable`
---               • zindex (string or table) override `zindex`,
---                 defaults to 50
--- @return any #(table) Options
function vim.lsp.make_floating_popup_options(width, height, opts) end

-- Creates a `DocumentFormattingParams` object for the current
-- buffer and cursor position.
--- @param options any #table|nil with valid `FormattingOptions`
---                entries
--- @return any #`DocumentFormattingParams` object
function vim.lsp.make_formatting_params(options) end

-- Using the given range in the current buffer, creates an object
-- that is similar to |vim.lsp.util.make_range_params()|.
--- @param start_pos any #({number, number}, optional)
---                        mark-indexed position. Defaults to the
---                        start of the last visual selection.
--- @param end_pos any #({number, number}, optional)
---                        mark-indexed position. Defaults to the
---                        end of the last visual selection.
--- @param bufnr any #(optional, number): buffer handle or 0
---                        for current, defaults to current
--- @param offset_encoding any #string utf-8|utf-16|utf-32|nil defaults
---                        to `offset_encoding` of first client of
---                        `bufnr`
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `start_position`, end = `end_position` } }
function vim.lsp.make_given_range_params(start_pos, end_pos, bufnr, offset_encoding) end

-- Creates a `TextDocumentPositionParams` object for the current
-- buffer and cursor position.
--- @param window any #(optional, number): window handle or 0
---                        for current, defaults to current
--- @param offset_encoding any #string utf-8|utf-16|utf-32|nil defaults
---                        to `offset_encoding` of first client of
---                        buffer of `window`
--- @return any #`TextDocumentPositionParams` object
function vim.lsp.make_position_params(window, offset_encoding) end

-- Using the current position in the current buffer, creates an
-- object that can be used as a building block for several LSP
-- requests, such as `textDocument/codeAction`,
-- `textDocument/colorPresentation`,
-- `textDocument/rangeFormatting`.
--- @param window any #(optional, number): window handle or 0
---                        for current, defaults to current
--- @param offset_encoding any #string utf-8|utf-16|utf-32|nil defaults
---                        to `offset_encoding` of first client of
---                        buffer of `window`
--- @return any #{ textDocument = { uri = `current_file_uri` }, range = {
---     start = `current_position`, end = `current_position` } }
function vim.lsp.make_range_params(window, offset_encoding) end

-- Creates a `TextDocumentIdentifier` object for the current
-- buffer.
--- @param bufnr any #(optional, number): Buffer handle, defaults to
---              current
--- @return any #`TextDocumentIdentifier`
function vim.lsp.make_text_document_params(bufnr) end

-- Create the workspace params
--- @param added any #
--- @param removed any #
function vim.lsp.make_workspace_params(added, removed) end

-- Sends a notification to the LSP server.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table): Parameters for the invoked LSP method
--- @return any #(bool) `true` if notification could be sent, `false` if
---     not
function vim.lsp.notify(method, params) end

-- Implements 'omnifunc' compatible LSP completion.
--- @param findstart any #0 or 1, decides behavior
--- @param base any #If findstart=0, text to match against
--- @return any #(number) Decided by {findstart}:
---     • findstart=0: column where the completion starts, or -2
---       or -3
---     • findstart=1: list of matches (actually just calls
---       |complete()|)
function vim.lsp.omnifunc(findstart, base) end

-- |lsp-handler| for the method `textDocument/codeLens`
function vim.lsp.on_codelens(err, result, ctx, _) end

-- |lsp-handler| for the method "textDocument/publishDiagnostics"
--- @param config any #table Configuration table (see
---               |vim.diagnostic.config()|).
function vim.lsp.on_publish_diagnostics(_, result, ctx, config) end

-- Shows contents in a floating window.
--- @param contents any #table of lines to show in window
--- @param syntax any #string of syntax to set for opened buffer
--- @param opts any #table with optional fields (additional keys
---                 are passed on to |vim.api.nvim_open_win()|)
---                 • height: (number) height of floating window
---                 • width: (number) width of floating window
---                 • wrap: (boolean, default true) wrap long
---                   lines
---                 • wrap_at: (string) character to wrap at for
---                   computing height when wrap is enabled
---                 • max_width: (number) maximal width of
---                   floating window
---                 • max_height: (number) maximal height of
---                   floating window
---                 • pad_top: (number) number of lines to pad
---                   contents at top
---                 • pad_bottom: (number) number of lines to pad
---                   contents at bottom
---                 • focus_id: (string) if a popup with this id
---                   is opened, then focus it
---                 • close_events: (table) list of events that
---                   closes the floating window
---                 • focusable: (boolean, default true) Make
---                   float focusable
---                 • focus: (boolean, default true) If `true`,
---                   and if {focusable} is also `true`, focus an
---                   existing floating window with the same
---                   {focus_id}
--- @return any #bufnr,winnr buffer and window number of the newly created
---     floating preview window
function vim.lsp.open_floating_preview(contents, syntax, opts) end

-- Lists all the items that are called by the symbol under the
-- cursor in the |quickfix| window. If the symbol can resolve to
-- multiple items, the user can pick one in the |inputlist|.
function vim.lsp.outgoing_calls() end

-- Parses snippets in a completion entry.
--- @param input any #string unparsed snippet
--- @return any #string parsed snippet
function vim.lsp.parse_snippet(input) end

-- Jump to new location (adjusting for UTF-16 encoding of
-- characters)
--- @param location any #a single `Location` or `LocationLink`
--- @return any #(bufnr,winnr) buffer and window number of floating window
---     or nil
function vim.lsp.preview_location(location, opts) end

-- Performs |vim.lsp.buf.code_action()| for a given range.
--- @param context any #table|nil `CodeActionContext` of the LSP specification:
---                  • diagnostics: (table|nil) LSP`Diagnostic[]` . Inferred from the current position if not
---                    provided.
---                  • only: (string|nil) LSP `CodeActionKind`
---                    used to filter the code actions. Most
---                    language servers support values like
---                    `refactor` or `quickfix`.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
function vim.lsp.range_code_action(context, start_pos, end_pos) end

-- Formats a given range.
--- @param options any #Table with valid `FormattingOptions` entries.
--- @param start_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the start of the last
---                  visual selection.
--- @param end_pos any #({number, number}, optional) mark-indexed
---                  position. Defaults to the end of the last
---                  visual selection.
function vim.lsp.range_formatting(options, start_pos, end_pos) end

-- Lists all the references to the symbol under the cursor in the
-- quickfix window.
--- @param context any #(table) Context for the request
function vim.lsp.references(context) end

-- Refresh the codelens for the current buffer
function vim.lsp.refresh() end

-- Remove the folder at path from the workspace folders. If
-- {path} is not provided, the user will be prompted for a path
-- using |input()|.
function vim.lsp.remove_workspace_folder(workspace_folder) end

-- Rename old_fname to new_fname
--- @param opts any #(table)
function vim.lsp.rename(old_fname, new_fname, opts) end

-- Sends a request to the LSP server and runs {callback} upon
-- response.
--- @param method any #(string) The invoked LSP method
--- @param params any #(table) Parameters for the
---                              invoked LSP method
--- @param callback any #(function) Callback to invoke
--- @param notify_reply_callback any #(function|nil) Callback to invoke
---                              as soon as a request is no longer
---                              pending
--- @return any #(bool, number) `(true, message_id)` if request could be
---     sent, `false` if not
function vim.lsp.request(method, params, callback, notify_reply_callback) end

-- Creates a normalized object describing LSP server
-- capabilities.
--- @param server_capabilities any #table Table of capabilities
---                            supported by the server
--- @return any #table Normalized table of capabilities
function vim.lsp.resolve_capabilities(server_capabilities) end

-- Creates an RPC response object/table.
--- @param code any #RPC error code defined in
---                `vim.lsp.protocol.ErrorCodes`
--- @param message any #(optional) arbitrary message to send to server
--- @param data any #(optional) arbitrary data to send to server
function vim.lsp.rpc_response_error(code, message, data) end

-- Run the code lens in the current line
function vim.lsp.run() end

-- Store lenses for a specific buffer and client
--- @param lenses any #table of lenses to store (`CodeLens[] |
---                  null`)
--- @param bufnr any #number
--- @param client_id any #number
function vim.lsp.save(lenses, bufnr, client_id) end

-- Checks whether the language servers attached to the current
-- buffer are ready.
--- @return any #`true` if server responds.
function vim.lsp.server_ready() end

-- Sets formatting function used to format logs
--- @param handle any #function function to apply to logging arguments,
---               pass vim.inspect for multi-line formatting
function vim.lsp.set_format_func(handle) end

-- Sets the current log level.
--- @param level any #(string or number) One of `vim.lsp.log.levels`
function vim.lsp.set_level(level) end

-- Replaces text in a range with new text.
--- @param lines any #(table) Original list of strings
--- @param A any #(table) Start position; a 2-tuple of {line,
---                  col} numbers
--- @param B any #(table) End position; a 2-tuple of {line,
---                  col} numbers
--- @param new_lines any #A list of strings to replace the original
--- @return any #(table) The modified {lines} object
function vim.lsp.set_lines(lines, A, B, new_lines) end

-- Sets the global log level for LSP logging.
--- @param level any #[number|string] the case insensitive level name
---              or number
function vim.lsp.set_log_level(level) end

-- Checks whether the level is sufficient for logging.
--- @param level any #number log level
--- @return any #(bool) true if would log, false if not
function vim.lsp.should_log(level) end

-- |lsp-handler| for the method "textDocument/signatureHelp". The
-- active parameter is highlighted with
-- |hl-LspSignatureActiveParameter|. >
--
--  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--    vim.lsp.handlers.signature_help, {
--      -- Use a sharp border with `FloatBorder` highlights
--      border = "single"
--    }
--  )
--
-- <
--- @param config any #table Configuration table.
---               • border: (default=nil)
---                 • Add borders to the floating window
---                 • See |vim.api.nvim_open_win()|
function vim.lsp.signature_help(_, result, ctx, config) end

-- Starts an LSP server process and create an LSP RPC client
-- object to interact with it. Communication with the server is
-- currently limited to stdio.
--- @param cmd any #(string) Command to start the LSP
---                           server.
--- @param cmd_args any #(table) List of additional string
---                           arguments to pass to {cmd}.
--- @param dispatchers any #(table, optional) Dispatchers for
---                           LSP message types. Valid dispatcher
---                           names are:
---                           • `"notification"`
---                           • `"server_request"`
---                           • `"on_error"`
---                           • `"on_exit"`
--- @param extra_spawn_params any #(table, optional) Additional context
---                           for the LSP server process. May
---                           contain:
---                           • {cwd} (string) Working directory
---                             for the LSP server process
---                           • {env} (table) Additional
---                             environment variables for LSP
---                             server process
--- @return any #Client RPC object.
--- @return any #Methods:
---     • `notify()` |vim.lsp.rpc.notify()|
---     • `request()` |vim.lsp.rpc.request()|
--- @return any #Members:
---     • {pid} (number) The LSP server's PID.
---     • {handle} A handle for low-level interaction with the LSP
---       server process |vim.loop|.
function vim.lsp.start(cmd, cmd_args, dispatchers, extra_spawn_params) end

-- Starts and initializes a client with the given configuration.
--- @return any #Client id. |vim.lsp.get_client_by_id()| Note: client may
---     not be fully initialized. Use `on_init` to do any actions
---     once the client has been initialized.
function vim.lsp.start_client(config) end

-- Stops a client(s).
--- @param client_id any #client id or |vim.lsp.client| object, or list
---                  thereof
--- @param force any #boolean (optional) shutdown forcefully
function vim.lsp.stop_client(client_id, force) end

-- Converts markdown into syntax highlighted regions by stripping
-- the code blocks and converting them into highlighted code.
-- This will by default insert a blank line separator after those
-- code block regions to improve readability.
--- @param contents any #table of lines to show in window
--- @param opts any #dictionary with optional fields
---                 • height of floating window
---                 • width of floating window
---                 • wrap_at character to wrap at for computing
---                   height
---                 • max_width maximal width of floating window
---                 • max_height maximal height of floating window
---                 • pad_top number of lines to pad contents at
---                   top
---                 • pad_bottom number of lines to pad contents
---                   at bottom
---                 • separator insert separator after code block
--- @return any #width,height size of float
function vim.lsp.stylize_markdown(bufnr, contents, opts) end

-- Converts symbols to quickfix list items.
--- @param symbols any #DocumentSymbol[] or SymbolInformation[]
function vim.lsp.symbols_to_items(symbols, bufnr) end

-- Provides an interface between the built-in client and
-- 'tagfunc'.
--- @return any #A list of matching tags
function vim.lsp.tagfunc(...) end

-- Turns the result of a `textDocument/completion` request into
-- vim-compatible |complete-items|.
--- @param result any #The result of a `textDocument/completion` call,
---               e.g. from |vim.lsp.buf.completion()|, which may
---               be one of `CompletionItem[]`, `CompletionList`
---               or `null`
--- @param prefix any #(string) the prefix to filter the completion
---               items
--- @return any #{ matches = complete-items table, incomplete = bool }
function vim.lsp.text_document_completion_list_to_complete_items(result, prefix) end

-- Removes empty lines from the beginning and end.
--- @param lines any #(table) list of lines to trim
--- @return any #(table) trimmed list of lines
function vim.lsp.trim_empty_lines(lines) end

-- Accepts markdown lines and tries to reduce them to a filetype
-- if they comprise just a single code block.
--- @param lines any #(table) list of lines
--- @return any #(string) filetype or 'markdown' if it was unchanged.
function vim.lsp.try_trim_markdown_code_blocks(lines) end

-- Jumps to the definition of the type of the symbol under the
-- cursor.
function vim.lsp.type_definition() end

-- Function to manage overriding defaults for LSP handlers.
--- @param handler any #(function) See |lsp-handler|
--- @param override_config any #(table) Table containing the keys to
---                        override behavior of the {handler}
function vim.lsp.with(handler, override_config) end

-- Lists all symbols in the current workspace in the quickfix
-- window.
--- @param query any #(string, optional)
function vim.lsp.workspace_symbol(query) end

