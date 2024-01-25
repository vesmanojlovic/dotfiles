return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")

    vim.keymap.set({"i"}, "<C-L>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})

    vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, {silent = true})
  end,
}
