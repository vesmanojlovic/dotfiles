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
                name = "Work_vault",
                path = "/home/vesmanojlovic/Documents/Obsidian/Work_vault",
            },
            {
                name = "Writing_vault",
                path = "/home/vesmanojlovic/Documents/Obsidian/Writing_vault",
            },
        }
    }
}
