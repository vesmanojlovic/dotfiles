return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            {"github/copilot.vim"},
            {"nvim-lua/plenary.nvim"},
        },
        build = "make tiktoken",
        opts = {
            model = 'claude-sonnet-4',
            agent = 'copilot',
            window = {
                width = 0.4,
                height = 0.6,
                layour = 'float',
                relative = 'editor',
                border = 'rounded',
                title = 'Copilot Chat',
            },
            chat_autocomplete = true,
            clear_chat_on_new_prompt = false,
            show_help = true,
            question_header = "# Ves",
            answer_header = "# Copilot",
            error_header = "# Error",
            separator = "---",
            prompts = {
                Explain = {
                prompt = "Write an explanation for the selected code as paragraphs of text.",
                system_prompt = "COPILOT_EXPLAIN",
                },
                Review = {
                prompt = "Review the selected code and provide feedback.",
                system_prompt = "COPILOT_REVIEW",
                },
                Fix = {
                    prompt = "There is a problem in the selected code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how you changes fixed it.",
                },
                Docs = {
                    prompt = "Write documentation for the selected code.",
                },
                Tests = {
                    prompt = "Write tests for the selected code.",
                },
                Commit = {
                    prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block",
                },
            },
            mapping = {
                complete = {
                    insert = '<Shift-Tab>',
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-s>',
                },
            },
        },
    },
}
