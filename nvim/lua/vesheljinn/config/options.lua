local opt = vim.opt

opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor20",
}

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.wrap = false

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = false
        vim.opt_local.textwidth = 80
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = false
        vim.opt_local.conceallevel = 1
    end,
})

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
opt.isfname:append("@-@")

opt.backspace = 'indent,eol,start'

opt.clipboard:append('unnamedplus')

opt.splitbelow = true
opt.splitright = true

opt.scrolloff = 12

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.colorcolumn = "80"

vim.cmd([[
  filetype on
  filetype plugin on
  filetype indent on
]])
