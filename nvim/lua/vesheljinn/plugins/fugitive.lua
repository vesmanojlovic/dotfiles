return {
    "tpope/vim-fugitive", -- specifying the fugitive plugin
    config = function()
        -- Keymap function with options
        local function map(key, command)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', key, command, opts)
        end
        map('<leader>gs', ':Git<CR>') -- Git status
        map('<leader>ga', ':Git add %<CR>') -- Git add current file
        map('<leader>gm', ':Git commit<CR>') -- Git commit
        map('<leader>gl', ':Git push<CR>') -- Git push
        map('<leader>gh', ':Git pull<CR>') -- Git pull
        map('<leader>gb', ':Git branch<CR>') -- List branches
        map('<leader>gc', ':Git checkout<Space>') -- Checkout branch, type branch name after
        map('<leader>gd', ':Git diff<CR>') -- Git diff
    end
}

