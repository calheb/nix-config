-- lua/config/keymaps.lua

local km = vim.keymap

-- escape to exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- window navigation
km.set("n", "<C-h>", "<C-w>h")
km.set("n", "<C-j>", "<C-w>j")
km.set("n", "<C-k>", "<C-w>k")
km.set("n", "<C-l>", "<C-w>l")

vim.g.netrw_winsize = 25

local function open_or_focus_netrw()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "netrw" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd("Lex")
end

local function open_or_focus_terminal()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd("botright split")
  vim.cmd("terminal")
  vim.cmd("resize 12")
end

local function focus_file()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype ~= "netrw" and vim.bo[buf].buftype ~= "terminal" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd("botright vsplit | enew")
end

local function reset_layout()
  vim.cmd("silent! only")
  vim.cmd("enew")
  vim.cmd("botright split")
  vim.cmd("terminal")
  vim.cmd("resize 12")
  vim.cmd("wincmd k")
  vim.cmd("Lex")
end

km.set("n", "<leader>e", open_or_focus_netrw)
km.set("n", "<leader>t", open_or_focus_terminal)
km.set("n", "<leader>f", focus_file)
km.set("n", "<leader>`", reset_layout)

