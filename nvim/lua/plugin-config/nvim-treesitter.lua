local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  vim.notify("nvim-treesitter not found !")
  return
end

treesitter.setup({
  -- Install Language parser
  -- Use :TSInstallInfo to check support language
  ensure_installed = {
    "c",
    "cpp",
    "rust",
    "java",
    "kotlin",
    "lua",
    "python",
    "perl",
    "julia",
    "ruby",
    "vim",
    "http",
    "dot",
    "javascript",
    "typescript",
    "tsx",
    "php",
    "vue",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "latex",
    "bibtex",
    "cmake",
    "ninja",
    "regex",
    "sql",
    "make",
    "json",
    "json5",
    "jsonc",
    "toml",
    "yaml",
  },
  auto_install = true,

  -- enable code highlight
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },

  indent = {
    enable = true,
  },
})

-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.opt.foldlevel = 99
