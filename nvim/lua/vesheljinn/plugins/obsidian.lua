return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Vault_1",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault_1",
            },
            {
                name = "Work_vault",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Work_vault",
            },
        }
    }
}
