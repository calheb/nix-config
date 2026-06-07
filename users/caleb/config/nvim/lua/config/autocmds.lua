-- lua/config/autocmds.lua

local km = vim.keymap

-- fix C-hjkl in netrw
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    km.set("n", "<C-h>", "<C-w>h", { buffer = true })
    km.set("n", "<C-j>", "<C-w>j", { buffer = true })
    km.set("n", "<C-k>", "<C-w>k", { buffer = true })
    km.set("n", "<C-l>", "<C-w>l", { buffer = true })
  end,
})

