vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
						{ text = { "%s" },                  click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	config = function() -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		local ufo = require('ufo')
		vim.keymap.set('n', 'zR', ufo.openAllFolds)
		vim.keymap.set('n', 'zM', ufo.closeAllFolds)

		ufo.setup({
			provider_selector = function()
				return { 'lsp', 'indent' }
			end,
		})
	end
}
