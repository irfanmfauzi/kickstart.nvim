return {
	'nvim-treesitter/nvim-treesitter-context',
	config = function()
		vim.keymap.set("n", "<leader>jc", function()
			require("treesitter-context").go_to_context()
		end, { desc = "Jump to Context", silent = true })
	end
}
