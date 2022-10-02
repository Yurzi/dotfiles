local status, project = pcall(require, "project_nvim")
if not status then
  vim.notify("project_nvim not found!")
  return
end

-- nvim-tree support
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "CMakeLists.txt", "package.json", ".sln" },
})

local status_, telescope = pcall(require, "telescope")
if not status_ then
  vim.notify("telescope not found")
  return
end
pcall(telescope.load_extension, "projects")
