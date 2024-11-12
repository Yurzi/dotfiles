-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.shell = "pwsh"
opt.shellcmdflag = "-command"
opt.shellquote = '"'
opt.shellxquote = ""

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font:h14" -- text below applies for VimScript
  vim.g.neovide_fullscreen = true
  vim.g.neovide_theme = "auto"
  vim.g.neovide_input_ime = true -- disable input method
end
