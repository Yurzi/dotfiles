local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local status_ok, schemas_store = pcall(require, "schemastore")
if not status_ok then
  vim.notify("fallback! schemastore not found!")
end

local opts = {
  settings = {
    json = {
      schemas = status_ok and schemas_store.json.schemas() or {},
      validate = { enable = true },
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require("keybindings").mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
