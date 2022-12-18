vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = {"menuone", "noselect"}
vim.opt.conceallevel = 0
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldexpr = ""
vim.opt.foldmethod = "manual"
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.wrap = false


vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Unload netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrePlugin = 1

-- These bad bois need to be loaded after disabling netrw
require("offbyjuan.packer")
require("offbyjuan.remap")
