local telescope = require("telescope")
telescope.load_extension("hoogle")
vim.diagnostic.config({
	virtual_lines = { only_current_line = true },
	virtual_text = false,
})

vim.api.nvim_create_autocmd("User", {
	pattern = { "TelescopePreviewerLoaded" },
	callback = function()
		vim.api.nvim_set_option_value("number", true, { scope = "local" })
	end,
})

require("outline").setup({})
vim.lsp.config('hls', {})
vim.lsp.config('lua_ls', {
  settings = {
    Lua = { diagnostics = { globals = { 'vim' } } }
  }
})
vim.lsp.enable({ 'hls', 'lua_ls' })
