-- You can add your own plugins here or in other files in this directory! I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()

			local cmp = require("cmp")
			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and
				    vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end
			cmp.setup({
				mapping = {
					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
				},
			})
		end
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 1,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = 'float',
			})
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require("nvim-tree").setup()

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true
			vim.keymap.set('n', "<C-n>", ":NvimTreeFocus<CR>")
		end
	},
}
