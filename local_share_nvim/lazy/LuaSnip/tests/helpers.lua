local helpers = require("test.functional.helpers")(after_each)
local exec_lua = helpers.exec_lua
local exec = helpers.exec
local assert = require("luassert")

local M = {}

function M.setup_jsregexp()
	-- append default-path.
	exec_lua(
		('package.cpath = "%s"'):format(os.getenv("JSREGEXP_PATH") .. "/?.so;;")
	)
end

function M.prevent_jsregexp()
	-- append default-path.
	exec_lua([[
		local old_require = require
		require = function(modulename)
			if modulename == "jsregexp" or modulename == "luasnip-jsregexp" then
				error("Disabled by `prevent_jsregexp`")
			end
			return old_require(modulename)
		end
	]])
end

function M.session_setup_luasnip(opts)
	opts = opts or {}
	local no_snip_globals = opts.no_snip_globals ~= nil and opts.no_snip_globals
		or false
	local setup_extend = opts.setup_extend ~= nil and opts.setup_extend or {}
	local setup_parsers
	if opts.setup_parsers ~= nil then
		setup_parsers = opts.setup_parsers
	else
		setup_parsers = false
	end

	-- stylua: ignore
	helpers.exec("set rtp+=" .. os.getenv("LUASNIP_SOURCE"))
	helpers.exec(
		("source %s/plugin/luasnip.vim"):format(os.getenv("LUASNIP_SOURCE"))
	)
	helpers.exec(
		("luafile %s/plugin/luasnip.lua"):format(os.getenv("LUASNIP_SOURCE"))
	)

	if setup_parsers then
		-- adding the lua-parser, is either a nop or adds the parser on
		-- versions where it does not exist by default.
		exec_lua([[
			ts_lang_add =
				(vim.treesitter.language and vim.treesitter.language.add)
				and function(lang, path)
						vim.treesitter.language.add(lang, {path = path})
					end
				or vim.treesitter.require_language

			-- this is a nop on new versions of neovim, where the lua-parser is shipped by default.
			ts_lang_add("lua", os.getenv("LUASNIP_SOURCE") .. "/tests/parsers/lua.so")

			ts_lang_add("json", os.getenv("LUASNIP_SOURCE") .. "/tests/parsers/json.so")
			ts_lang_add("jsonc", os.getenv("LUASNIP_SOURCE") .. "/tests/parsers/jsonc.so")
		]])
	end

	helpers.exec_lua(
		[[
		-- MYVIMRC might not be set when nvim is loaded like this.
		vim.env.MYVIMRC = "/.vimrc"

		ls = require("luasnip")
		ls.setup(vim.tbl_extend("force", {
			store_selection_keys = "<Tab>"
		}, ...))
	]],
		setup_extend
	)

	if not no_snip_globals then
		helpers.exec_lua([[
			s = ls.s
			sn = ls.sn
			t = ls.t
			i = ls.i
			f = ls.f
			c = ls.c
			d = ls.d
			isn = require("luasnip.nodes.snippet").ISN
			l = require'luasnip.extras'.lambda
			dl = require'luasnip.extras'.dynamic_lambda
			rep = require'luasnip.extras'.rep
			r = ls.restore_node
			p = require("luasnip.extras").partial
			types = require("luasnip.util.types")
			events = require("luasnip.util.events")
			fmt = require("luasnip.extras.fmt").fmt
			fmta = require("luasnip.extras.fmt").fmta
			parse = ls.parser.parse_snippet
			n = require("luasnip.extras").nonempty
			m = require("luasnip.extras").match
			ai = require("luasnip.nodes.absolute_indexer")
			sp = require("luasnip.nodes.snippetProxy")
			pf = require("luasnip.extras.postfix").postfix
			k = require("luasnip.nodes.key_indexer").new_key
		]])
	end
end

function M.static_docstring_test(snip_str, static, docstring)
	assert.are.same(
		static,
		exec_lua("return " .. snip_str .. ":get_static_text()")
	)
	assert.are.same(
		docstring,
		exec_lua("return " .. snip_str .. ":get_docstring()")
	)
end
function M.lsp_static_test(snip_str, static)
	assert.are.same(
		static,
		exec_lua(
			'return ls.parser.parse_snippet("trig", '
				.. snip_str
				.. "):get_static_text()"
		)
	)
end

M.loaders = {
	["vscode(rtp)"] = function()
		exec(
			"set rtp+="
				.. os.getenv("LUASNIP_SOURCE")
				.. "/tests/data/vscode-snippets"
		)
		exec_lua('require("luasnip.loaders.from_vscode").load()')
	end,
	["vscode(path)"] = function()
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_vscode").load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE") .. "/tests/data/vscode-snippets"
			)
		)
	end,
	["vscode(lazy)"] = function()
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_vscode").lazy_load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE") .. "/tests/data/vscode-snippets"
			)
		)
	end,

	["snipmate(rtp)"] = function()
		exec(
			"set rtp+="
				.. os.getenv("LUASNIP_SOURCE")
				.. "/tests/data/snipmate-snippets"
		)
		exec_lua('require("luasnip.loaders.from_snipmate").load()')
	end,
	["snipmate(path)"] = function(dir)
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_snipmate").load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE")
					.. "/tests/data/snipmate-snippets/"
					.. dir
			)
		)
	end,
	["snipmate(lazy)"] = function(dir)
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_snipmate").lazy_load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE")
					.. "/tests/data/snipmate-snippets/"
					.. dir
			)
		)
	end,

	["lua(rtp)"] = function()
		exec(
			"set rtp+="
				.. os.getenv("LUASNIP_SOURCE")
				.. "/tests/data/lua-snippets"
		)
		exec_lua('require("luasnip.loaders.from_lua").load()')
	end,
	["lua(path)"] = function()
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_lua").load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE")
					.. "/tests/data/lua-snippets/luasnippets"
			)
		)
	end,
	["lua(lazy)"] = function()
		exec_lua(
			string.format(
				[[require("luasnip.loaders.from_lua").lazy_load({paths="%s"})]],
				os.getenv("LUASNIP_SOURCE")
					.. "/tests/data/lua-snippets/luasnippets"
			)
		)
	end,
}

function M.check_global_node_refs(test_name, resolve_map, fn)
	for _, index_strategy in ipairs({ "absolute_indexer", "key_indexer" }) do
		getfenv(2).it(("%s (%s)."):format(test_name, index_strategy), function()
			exec_lua(
				[[
				resolve_map, strategy = ...
				function _luasnip_test_resolve(key)
					if strategy == "absolute_indexer" then
						return ai(resolve_map[key][1])
					else
						return k(resolve_map[key][2])
					end
				end
			]],
				resolve_map,
				index_strategy
			)
			fn()
		end)
	end
end

return M
