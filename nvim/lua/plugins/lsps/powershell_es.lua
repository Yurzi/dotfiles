return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        powershell_es = {
          bundle_path = "~/Documents/PowerShell/PowerShellEditorServices",
          filetypes = { "ps1", "psm1" },
        },
      },
      setup = {
        powershell_es = function(_, opts) end,
      },
    },
  },
}
