-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map("n", "<F5>", ":term uv run -p 3.10 python3 -m pdb main.py")
map("n", "<F6>", ":term uv run -p 3.10 pytest .")
