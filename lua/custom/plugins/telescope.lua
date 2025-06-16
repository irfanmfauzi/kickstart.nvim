return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require('telescope').setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
			},
		}

		pcall(require('telescope').load_extension, 'fzf')

		local function find_git_root()
			local current_file = vim.api.nvim_buf_get_name(0)
			local current_dir
			local cwd = vim.fn.getcwd()
			if current_file == "" then
				current_dir = cwd
			else
				current_dir = vim.fn.fnamemodify(current_file, ":h")
			end

			local git_root = vim.fn.systemlist("git -C " ..
				vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
			if vim.v.shell_error ~= 0 then
				print("Not a git repository. Searching on current working directory")
				return cwd
			end
			return git_root
		end

		-- Custom live_grep function to search in git root
		local function live_grep_git_root()
			local git_root = find_git_root()
			if git_root then
				require('telescope.builtin').live_grep({
					search_dirs = { git_root },
				})
			end
		end

		vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
			{ desc = '[?] Find recently opened files' })
		vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
			{ desc = '[ ] Find existing buffers' })
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })

		vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files,
			{ desc = 'Search [G]it [F]iles' })
		vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
			{ desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
		vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
			{ desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
		vim.keymap.set('n', '<leader>ep', function()
			local data = vim.fn.stdpath("data")
			if type(data) == "table" then
				data = table.concat(data, " ")
			end
			require('telescope.builtin').find_files {
				cwd = vim.fs.joinpath(data, "lazy")
			}
		end)
	end,

}
