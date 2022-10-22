-- 基础设置
require("basic")

-- 快捷键设置
require("keybindings")

-- Packer 插件管理器
require("plugins")

-- ColorScheme 设置
require("colorscheme")

-- Plugin Configs --
-- Nvim-Tree
require("plugin-config.nvim-tree")
-- Buffer Line
require("plugin-config.bufferline")
-- Lua Line
require("plugin-config.lualine")
-- Fidget
require("plugin-config.fidget")
-- Telescope
require("plugin-config.telescope")
-- DashBoard
require("plugin-config.dashboard")
-- Project-Nvim
require("plugin-config.project")
-- Nvim-TreeSitter
require("plugin-config.nvim-treesitter")

-- 内置LSP --
-- Mason
require("plugin-config.mason")
-- Setup LSP
require("lsp.setup")
-- CMP
require("lsp.cmp")
-- UI
require("lsp.ui")
-- nvim-ls
require("lsp.null-ls")
-- DAP
require("dap.nvim-dap")
