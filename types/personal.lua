-- Parse the Vim regex {re} and return **a regex object**. Regexes are
-- "magic" and case-insensitive by default, regardless of 'magic' and
-- 'ignorecase'.  The can be controlled with flags, see |/magic|.
-- Methods on the regex object:
--        regex:match_str({str})
--                Match the string against the regex. If the string should match the
--                regex precisely, surround the regex with `^` and `$`.
--                If the was a match, the byte indices for the beginning and end of
--                the match is returned. When there is no match, `nil` is returned.
--                As any integer is truth-y, `regex:match()` can be directly used
--                as a condition in an if-statement.
--        
--        regex:match_line({bufnr}, {line_idx}[, {start}, {end}])
--                Match line {line_idx} (zero-based) in buffer {bufnr}. If {start} and
--                {end} are supplied, match only this byte index range. Otherwise see
--                |regex:match_str()|. If {start} is used, then the returned byte
--                indices will be relative {start}.
-- @param re regex
function vim.regex(re) end

function vim.loop() end
