local packer = require("packer")
packer.startup({
  function(use)
    -- Packer --
    use("wbthomason/packer.nvim")

    -- Color Scheme --
    use("sainnhe/sonokai")
    use("xiyaowong/nvim-transparent")

    -- File Explorer --
    use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })

    -- Buffer Line And Lua Line --
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")

    -- Telescope --
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- Dashboard --
    use("glepnir/dashboard-nvim")
    use("ahmedkhalf/project.nvim")
    -- Nvim treesitter --
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- LSP --
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "neovim/nvim-lspconfig" })
    -- null-ls --
    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- dap --
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")
    -- CMP --
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")

    -- UI --
    use("glepnir/lspsaga.nvim")
    use("j-hui/fidget.nvim")

    -- Rust Tools --
    use("simrat39/rust-tools.nvim")
  end,

  config = {
    -- 并发控制
    max_jobs = 16,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
