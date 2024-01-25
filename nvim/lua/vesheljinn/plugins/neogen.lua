return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    version = "*",
    config = function ()
      local neogen = require('neogen')
      neogen.setup({
          snippet_engine = "luasnip",
      })
      vim.keymap.set("n", "<leader>,", function()
        neogen.generate({ type = "func" })
      end)
      vim.keymap.set("n", "<leader>.", function()
        neogen.generate({ type = "class" })
      end)
    end
}
