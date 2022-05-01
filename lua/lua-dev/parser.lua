local uv = vim.loop
local M = {}

function M.comment(str, comment_str)
    comment_str = comment_str or "--"
    return comment_str .. " " .. vim.fn.trim(str):gsub("[\n]", "\n" .. comment_str .. " "):gsub("%s+\n", "\n")
end

function M.infer_type(param)
    local type = param.type or "any"
    if type == "" then
        type = "any"
    end
    if type == "any" then
        if param.name == "fn" then
            type = "fun(...)"
        elseif param.name == "args" or param.name == "list" then
            type = "any[]"
        elseif param.name == "dict" then
            type = "dictionary"
        end
    end
    if type == "arrayof(string)" then
        type = "string[]"
    elseif type == "arrayof(integer, 2)" then
        type = "number[]"
    elseif type == "dictionaryof(luaref)" then
        type = "table<string, luaref>"
    end
    return type
end

function M.emmy_param(param, is_return)
    local type = M.infer_type(param)
    local parts = {}
    if param.name and param.name ~= "..." then
        table.insert(parts, param.name)
    end
    if type then
        table.insert(parts, type)
    end
    if param.doc then
        table.insert(parts, "#" .. param.doc)
    end

    if not param.doc and type == "any" then
        return ""
    end
    local ret = table.concat(parts, " ")
    if is_return then
        return M.comment("@return " .. ret, "---") .. "\n"
    elseif param.name == "..." then
        return M.comment("@vararg " .. ret, "---") .. "\n"
    else
        return M.comment("@param " .. ret, "---") .. "\n"
    end
end

--- @return ApiFunction
function M.process(name, fun, prefix)
    --- @class ApiFunction
    local ret = {
        doc = (fun.doc and fun.doc[1]) and fun.doc[1] or "",
        name = name,
        fqname = prefix .. "." .. name,
        params = {},
        ["return"] = {},
    }

    for _, r in pairs(fun["return"]) do
        table.insert(ret["return"], { doc = r })
    end

    local param_docs = {}
    for param, doc in pairs(fun.parameters_doc or {}) do
        param_docs[param] = doc
    end

    for i, p in ipairs(fun.parameters or {}) do
        local type, pname = unpack(p)
        local param = { name = pname }
        if type ~= "" then
            param.type = type:lower()
        end
        if param_docs[pname] then
            param.doc = param_docs[pname]
        end
        if param.name == "end" then
            param.name = "end_"
        end
        -- only include err param if it's documented
        -- most nvim_ functions have an err param at the end, but these should not be included
        local skip = i == #fun.parameters and (pname == "err" or pname == "error")
        -- skip self params
        if param.name == "self" or param.name == "" then
            skip = true
        end
        if not skip then
            table.insert(ret.params, param)
        end
    end
    return ret
end

--- @param fun ApiFunction
function M.emmy(fun)
    local ret = ""
    if fun.doc ~= "" then
        ret = ret .. (M.comment(fun.doc)) .. "\n"
    end

    local params = {}

    for _, param in pairs(fun.params) do
        table.insert(params, param.name)
        ret = ret .. M.emmy_param(param)
    end
    for _, r in pairs(fun["return"]) do
        ret = ret .. M.emmy_param(r, true)
    end

    local signature = "function %s(%s) end"

    ret = ret .. signature:format(fun.fqname, table.concat(params, ", "))
    return ret .. "\n\n"
end

function M.intro(fd)
    uv.fs_write(
        fd,
        [[
--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

]],
        -1
    )
end

local vim_modules = {
    ["match"] = "filetype.match",
    ["add"] = "filetype.add",
    ["select"] = "ui.select",
    ["input"] = "ui.input",
    ["set"] = "keymap.set",
    ["del"] = "keymap.del",
    ["add_directive"] = "query.add_directive",
    ["add_predicate"] = "query.add_predicate",
    ["get_node_text"] = "query.get_node_tex",
    ["get_query"] = "query.get_query",
    ["get_query_files"] = "query.get_query_files",
    ["list_directives"] = "query.list_directives",
    ["list_predicates"] = "query.list_predicates",
    ["parse_query"] = "query.parse_query",
    ["set_query"] = "query.set_query",
}

function M.get_functions(mpack)
    mpack = "data/" .. mpack
    local data = vim.fn.msgpackparse(vim.fn.readfile(mpack, "b"))
    local ret = {}
    for _, functions in pairs(data) do
        for name, fun in pairs(functions) do
            if vim.tbl_contains(vim.tbl_keys(vim_modules), name) then
                name = vim_modules[name]
                print(name)
            end
            table.insert(ret, { name, fun })
        end
    end
    table.sort(ret, function(a, b)
        return a[1] < b[1]
    end)
    return ret
end

function M.parse(mpack, prefix, exclude)
    print(prefix)
    -- exclude signatures for functions that are existing lua sources
    local skip = {}
    for _, value in pairs(exclude or {}) do
        for key, _ in pairs(require(value)) do
            print("skipping " .. value .. ": " .. key)
            skip[key] = true
        end
    end
    prefix = prefix or "vim"
    local fname = vim.fn.fnamemodify(mpack, ":t:r")

    local writer = M.writer("types/" .. fname)
    local classes = {}
    for _, f in pairs(M.get_functions(mpack)) do
        local name, fun = unpack(f)
        if not skip[name] then
            local parts = vim.fn.split(name, ":")
            if #parts > 1 and not classes[parts[1]] then
                writer.write(([[
--- @class %s
%s = {}

]]):format(prefix .. "." .. parts[1], prefix .. "." .. parts[1]))
                classes[parts[1]] = true
            end
            local emmy = M.emmy(M.process(name, fun, prefix))
            writer.write(emmy)
        end
    end
    writer.close()
end

function M.options()
    local data = vim.fn.json_decode(vim.fn.readfile("data/builtin-docs.json"))
    local docs = data.documents.options

    local ret = { o = {}, wo = {}, bo = {} }
    for name, option in pairs(vim.api.nvim_get_all_options_info()) do
        if option.scope == "buf" then
            ret.bo[name] = option.default
        elseif option.scope == "win" then
            ret.wo[name] = option.default
        end
        if option.scope == "global" or option.global_local then
            ret.o[name] = option.default
        end
    end

    local writer = M.writer("types/options")
    for scope, options in pairs(ret) do
        for key, value in pairs(options) do
            local str = ("vim.%s.%s = %q\n"):format(scope, key, value)
            local doc = docs[key] and table.concat(docs[key], "\n") or nil
            if doc then
                str = M.comment(doc) .. "\n" .. str
            end
            writer.write(str)
        end
    end
    writer.close()
end

function M.writer(file)
    local fd = uv.fs_open(file .. ".lua", "w+", 420)
    local size = 0
    local fnum = 0
    M.intro(fd)
    return {
        write = function(str)
            uv.fs_write(fd, str, -1)
            size = size + #str
            if size > 1024 * 50 then
                uv.fs_close(fd)
                fnum = fnum + 1
                size = 0
                fd = uv.fs_open(file .. "." .. fnum .. ".lua", "w+", 420)
                M.intro(fd)
            end
        end,
        close = function()
            uv.fs_close(fd)
        end,
    }
end

function M.functions()
    local data = vim.fn.json_decode(vim.fn.readfile("data/builtin-docs.json"))
    local functions = data.signatureHelp
    local docs = data.documents.functions

    local writer = M.writer("types/vim.fn")
    local exclude = { ["or"] = true, ["and"] = true, ["repeat"] = true, ["function"] = true, ["end"] = true }
    for name, props in pairs(functions) do
        if vim.fn[name] and not vim.api[name] and not exclude[name] then
            local fun = {
                name = name,
                fqname = "vim.fn." .. name,
                doc = table.concat(docs[name] or {}, "\n"),
                params = {},
                ["return"] = {},
            }
            if props[2] ~= "" then
                fun["return"] = { { type = props[2]:lower() } }
            end
            if props[1] ~= "" then
                for _, param in pairs(vim.split(props[1], ",")) do
                    param = vim.trim(param:gsub("[{}%]%[]", ""))
                    param = param:gsub("-", "_")
                    if exclude[param] or tonumber(param) ~= nil then
                        param = "_" .. param
                    end
                    if param:find("%.%.%.") then
                        param = "..."
                    end
                    table.insert(fun.params, { name = param })
                end
            end
            writer.write(M.emmy(fun))
        end
    end
    writer.close()
end

function M.clean()
    for _, f in pairs(vim.fn.expand("types/*.lua", false, true)) do
        if f ~= "types/vim.lua" then
            uv.fs_unlink(f)
        end
    end
end

function M.build()
    M.clean()
    M.functions()
    M.options()
    -- M.parse("lua.mpack", "vim", { "vim.uri", "vim.inspect" })
    M.parse("lua.mpack", "vim", {})
    -- M.parse("diagnostic.mpack", "vim.diagnostic")
    M.parse("api.mpack", "vim.api")
    -- M.parse("lsp.mpack", "vim.lsp", { "vim.lsp" })
    M.parse("lsp.mpack", "vim.lsp", {})
    -- M.parse("treesitter.mpack", "vim.treesitter", { "vim.treesitter" })
    M.parse("treesitter.mpack", "vim.treesitter", {})
end

M.build()

return M
