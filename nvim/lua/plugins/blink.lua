return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        winblend = vim.o.pumblend,
      },
      documentation = {
        window = {
          winblend = vim.o.pumblend,
        },
      },
    },
  },
}
