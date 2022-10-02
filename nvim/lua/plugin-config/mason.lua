local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason not found !")
  return
end

mason.setup({
  ui = {
    border = "single",
  },
})

local status_, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ then
  vim.notify("mason-lspconfig not found !")
  return
end

mason_lspconfig.setup()
