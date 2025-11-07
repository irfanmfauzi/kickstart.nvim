return {

	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-go",
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	ft = "go",
	config = function()
		-- get neotest namespace (api call creates or returns namespace)
		vim.api.nvim_set_keymap("n", "<leader>tq", ":lua require('neotest').output_panel.toggle()<CR>",
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>tr", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ noremap = true, silent = true })
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message =
					    diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " ")
					    :gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)
		require("neotest").setup({
			-- your neotest config here
			adapters = {
				require("neotest-go"),
			},
		})
	end
}
