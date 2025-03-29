-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- add neovide support
vim.o.guifont = "CaskaydiaCove Nerd Font,LXGW WenKai Mono,monospace:h17" -- text below applies for VimScript

vim.o.scrolloff = 14

if vim.g.neovide then
  vim.o.winblend = 60
  vim.o.pumblend = 60

  vim.g.neovide_theme = "light"
  vim.g.neovide_input_ime = true -- disable input method
  vim.g.neovide_floating_corner_radius = 0.5
  vim.g.neovide_transparency = 0.81
  vim.g.neovide_window_blurred = true
  vim.g.neovide_refresh_rate = 60

  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 200
end
