return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({
      icons = false,
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
      use_diagnostic_signs = true,
      -- toggle trouble
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle()
      end),
      -- next trouble item
      vim.keymap.set("n", "[d", function()
        require("trouble").next({skip_groups = true, jump = true,})
      end),
      -- previous trouble item
      vim.keymap.set("n", "]d", function()
        require("trouble").previous({skip_groups = true, jump = true,})
      end),
    })
  end
}
