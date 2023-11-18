return {
	"olexsmir/gopher.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function ()
		require("gopher").setup {
			commands = {
				go = "go",
				gomodifytags = "gomodifytags",
				gotests = "~/go/bin/gotests", -- also you can set custom command path
				impl = "impl",
				iferr = "iferr",
			},
		}
		vim.keymap.set("n", "<leader>gsj","<cmd> GoTagAdd json <CR>", { desc = "Add json tag to Go Struct" } )
		vim.keymap.set("n", "<leader>ie", "<cmd> GoIfErr <CR>", { desc = "Add if err boiler plate" })
	end,
	build = function ()
		vim.cmd [[silent! GoInstallDeps]]
	end
}
