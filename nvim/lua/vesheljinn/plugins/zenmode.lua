return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>z", function()
        require("zen-mode").setup {
            window = {
                width = 100,
                options = {}
            },
            plugins = {
                gitsigns = { enabled = false },
                tmux = { enabled = false },
                kitty = {
                    enabled = true,
                    font = "+4"
                }
            },
            on_open = function()
                vim.cmd.colorscheme("monet")
            end,
            on_close = function()
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end
        }
        require("zen-mode").toggle()
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
    end)


    vim.keymap.set("n", "<leader>Z", function()
        require("zen-mode").setup {
            window = {
                backdrop = 0.95,
                width = 90,
                options = { }
            },
            plugins = {
                gitsigns = { enabled = false },
                tmux = { enabled = false },
                kitty = {
                    enabled = true,
                    font = "+4"
                }
            },
            on_open = function()
                vim.cmd.colorscheme("monet")
            end,
            on_close = function()
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end
        }
        require("zen-mode").toggle()
        vim.wo.wrap = false
        vim.wo.number = false
        vim.wo.rnu = false
        vim.opt.colorcolumn = "0"
    end)
  end,
}
