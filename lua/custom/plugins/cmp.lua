return {
	'saghen/blink.cmp',
	version = '1.*',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			dependencies = {
				'rafamadriz/friendly-snippets',
				config = function()
					require('luasnip.loaders.from_vscode').lazy_load()
				end,
			},
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		fuzzy = { implementation = 'prefer_rust' },
		snippets = {
			preset = 'luasnip',
		},
		keymap = { preset = 'default' },
		appearance = {
			nerd_font_variant = 'mono'
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		completion = {
			completion = { documentation = { auto_show = false } },
			menu = {
				draw = {
					columns = {
						{ "label",     "source_id", gap = 5, "label_description" },
						{ "kind_icon", gap = 3,     "kind" },
					},
				},
			},
		},
	},
}
