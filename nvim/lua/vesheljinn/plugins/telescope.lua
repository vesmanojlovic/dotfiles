return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fs", function()
          local word = vim.fn.expand("<cword>")
          builtin.grep_string({ search = word })
        end) -- search for word under cursor
		vim.keymap.set("n", "<leader>fS", function()
          local word = vim.fn.expand("<cWORD>")
          builtin.grep_string({ search = word })
        end) -- search for WORD under cursor
		vim.keymap.set("n", "<leader>fes", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end) -- search for user input
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	end,
}
