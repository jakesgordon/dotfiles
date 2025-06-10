return {
  "maxmx03/solarized.nvim",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "nvim-tree/nvim-tree.lua",
  "jremmen/vim-ripgrep",
  "folke/trouble.nvim",
  "tpope/vim-vinegar",
  "tpope/vim-surround",
  "tpope/vim-projectionist",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    }
  },
  {
    "mason-org/mason.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "cpp",
          "css",
          "elixir",
          "erlang",
          "go",
          "html",
          "java",
          "javascript",
          "json",
          "just",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "ruby",
          "sql",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
	      },
	      highlight = {
          enable = true
        },
      })
    end,
  }
}
