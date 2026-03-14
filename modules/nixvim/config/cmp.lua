local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
	local has_luasnip, luasnip = pcall(require, "luasnip")
	if has_luasnip then
		require("luasnip/loaders/from_vscode").lazy_load()
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				if has_luasnip then
					luasnip.lsp_expand(args.body)
				elseif vim.snippet and vim.snippet.expand then
					vim.snippet.expand(args.body)
				end
			end,
		},
		mapping = {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[NVIM_LUA]",
					ultisnips = "[Snippet]",
					buffer = "[Buffer]",
					path = "[Path]",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "ultisnips" },
			{ name = "buffer", keyword_length = 5 },
			{ name = "path" },
		},
		experimental = {
			ghost_text = true,
		},
	})
end
