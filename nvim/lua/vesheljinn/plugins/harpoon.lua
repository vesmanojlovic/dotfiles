return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim"
	},
	config = function()
		local harpoon = require("harpoon")

		-- setup
		harpoon:setup({})
		-- keybindings
		vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		-- quick dial
		vim.keymap.set("n", "<C-7>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<C-8>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<C-9>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<C-0>", function() harpoon:list():select(4) end)
		-- toggle prev & next buffers in harpoon list
		vim.keymap.set("n", "<C-S-J>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-S-K>", function() harpoon:list():next() end)
		-- delete list entries
		vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end) -- remove current buffer from harpoon list
		vim.keymap.set("n", "<C-S-d>", function() harpoon:list():clear() end) -- clear harpoon list

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files) do
				table.insert(file_paths, item.path)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		vim.keymap.set("n", "<C-e", function()
			toggle_telescope(harpoon:list())
		end)
	end
}
