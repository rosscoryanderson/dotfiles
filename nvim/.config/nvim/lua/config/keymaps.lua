-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--- moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")

-- dont overwrite paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "go", "o<ESC>", { desc = "Insert new line below" })
vim.keymap.set("n", "<Enter>", "o<ESC>", { desc = "Insert new line below" })
vim.keymap.set("n", "gO", "O<ESC>", { desc = "Insert new line above" })
vim.keymap.set("n", "<S-Enter>", "O<ESC>", { desc = "Insert new line above" })

-- Further ways to save and close files that my muscle memory goes to
vim.keymap.set("c", "W", ":w<CR>", { desc = "Save current buffer" })
vim.keymap.set("c", "Q", ":q<CR>", { desc = "Close current buffer" })
vim.keymap.set("i", ":W", "<Esc>:w<CR>", { desc = "Save current buffer" })

-- Moving across the line
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Move to front of first character on line" })
vim.keymap.set({ "n", "v" }, "L", "g_", { desc = "Move to front of last character on line" })

-- Pasting helpers
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>po", [[viw"_dP]])
