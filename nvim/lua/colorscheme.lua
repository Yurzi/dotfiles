local colorscheme = "sonokai"

vim.g.sonokai_better_performance = 1
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_transparent_background = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. "not found !")
  return
end
