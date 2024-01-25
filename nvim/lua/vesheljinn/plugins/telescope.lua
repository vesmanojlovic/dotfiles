return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fes", function()
          local word = vim.fn.expand("<cword>")
          builtin.grep_string({ search = word })
        end)
		vim.keymap.set("n", "<leader>fEs", function()
          local word = vim.fn.expand("<cWORD>")
          builtin.grep_string({ search = word })
        end)
		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	end,
}
