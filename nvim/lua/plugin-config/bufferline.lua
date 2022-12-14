local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline not found!")
  return
end

-- buffer line config --
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- 关闭Tab的命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete %d",
    -- 侧边栏设置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offset = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP  后续课程会配置
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
