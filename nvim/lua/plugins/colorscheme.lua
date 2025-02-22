return {
  {
    "catppuccin",
    opts = {
      -- flavour = "latte",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        noice = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        snacks = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
