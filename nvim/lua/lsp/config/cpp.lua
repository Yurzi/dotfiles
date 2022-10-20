local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = {"utf-16"}

local opts = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- 绑定快捷键
    buf_set_keymap("n",
      "<leader>ch",
      "<cmd>ClangdSwitchSourceHeader<CR>",
      { noremap = true, silent = true })

    require("keybindings").mapLSP(buf_set_keymap)
    -- 保存时自动格式化
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
