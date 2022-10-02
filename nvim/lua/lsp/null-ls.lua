local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notfiy("null-ls not found!")
  return
end

-- utils func --
local with_root_file = function(builtin, file)
  return builtin.with({
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  })
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting --
    -- shfmt
    -- formatting.shfmt,
    -- Stylua
    with_root_file(formatting.stylua, ".stylua.toml"),
    -- frontend
    formatting.prettier,
    -- fixjosn
    formatting.fixjson,
    -- python
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.isort,
    -- rust
    formatting.rustfmt,
    -- c/cpp
    with_root_file(formatting.clang_format, ".clang-format"),
  },

  -- autosave
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
