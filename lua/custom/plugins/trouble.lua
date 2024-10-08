return {
	'folke/trouble.nvim',
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
		vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
	end
}
