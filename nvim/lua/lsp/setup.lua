local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
--  安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local default_configed_server = require("lsp.config.default")
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua
  cssl = require("lsp.config.css"),
  html = require("lsp.config.html"),
  jsonls = require("lsp.config.json"),
  pyright = require("lsp.config.python"),
  rust_analyzer = require("lsp.config.rust"),
  clangd = require("lsp.config.cpp"),
}

local function revtab(table)
  local res = {}
  for _, v in pairs(table) do
    res[v] = true
  end
  return res
end

local available_servers = revtab(mason_lspconfig.get_available_servers())
local installed_servers = revtab(mason_lspconfig.get_installed_servers())

for name, _ in pairs(servers) do
  local server_is_found = available_servers[name]
  local server_is_installed = installed_servers[name]
  if server_is_found then
    if not server_is_installed then
      print("Installing " .. name)
      vim.cmd("LspInstall " .. name)
    end
  end
end

mason_lspconfig.setup_handlers({
  function(server_name)
    if servers[server_name] then
      servers[server_name].on_setup(lspconfig[server_name])
    else
      default_configed_server.on_setup(lspconfig[server_name]) -- Default Configuration
    end
  end,
})
