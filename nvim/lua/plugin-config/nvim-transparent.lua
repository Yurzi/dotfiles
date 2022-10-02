local status, transparent = pcall(require, "transparent")
if not status then
  vim.notify("nvim transparent not found!")
  return
end

transparent.setup({
  enable = true,
})
