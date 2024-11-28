-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.shell = "pwsh"
opt.shellcmdflag =
  "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
opt.shellquote = '"'
opt.shellxquote = ""

vim.o.guifont = "CaskaydiaCove Nerd Font,LXGW WenKai Mono:h14" -- text below applies for VimScript

vim.g.neovide_fullscreen = true
vim.g.neovide_theme = "auto"
vim.g.neovide_input_ime = false -- disable input method
vim.g.neovide_transparency = 0.78
vim.g.neovide_window_blurred = true
