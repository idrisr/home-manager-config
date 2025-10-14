local telescope = require("telescope")
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
