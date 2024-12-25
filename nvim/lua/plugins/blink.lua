return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
    },
    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = false,
        },
      },
      menu = { border = "single" },
      documentation = { window = { border = "single" } },
    },
    signature = { window = { border = "single" } },
  },
}
