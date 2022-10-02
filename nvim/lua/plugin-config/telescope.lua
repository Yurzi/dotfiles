local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end

telescope.setup({
  defaults = {
    -- 打开弹窗后进入的初始模式
    initial_mode = "insert",
    -- 窗口内快捷键
    mappings = require("keybindings").telescopeList,
  },
  --[[pickers = {

    },]]
  --
})
