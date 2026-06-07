-- lua/config/options.lua

local opt = vim.opt

-- line numbers
opt.number = true

-- indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- cursor appearance
opt.guicursor = "n-v-c:block,i:blinkon100-blinkoff100-blinkwait100"

-- use system clipboard
opt.clipboard = "unnamedplus"

-- wrap indicator
opt.colorcolumn = "100"
