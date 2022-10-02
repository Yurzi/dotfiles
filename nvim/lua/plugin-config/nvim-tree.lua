local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("nvim-tree not found!")
  return
end

-- 列表操作快捷键
local list_keys = require("keybindings").nvimTreeList

nvim_tree.setup({
  -- git 状态图标
  git = {
    enable = false,
  },

  -- project plugin 需要这样设置
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },

  -- 过滤文件
  filters = {
    dotfiles = true,
    custom = {
      "node_modules",
    },
  },

  view = {
    width = 32,
    side = "left",
    hide_root_folder = false,
    mappings = {
      custom_only = false,
      list = list_keys,
    },

    -- 不显示行数
    number = false,
    relativenumber = false,

    -- 显示图标
    signcolumn = "yes",
  },

  -- system_open
})

-- 自动关闭
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
