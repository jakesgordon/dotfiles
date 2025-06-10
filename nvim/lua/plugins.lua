-- LEGACY PLUGINS
-- ==============
--
-- "call minpac#add('vim-ruby/vim-ruby')
-- "call minpac#add('fatih/vim-go')
-- "call minpac#add('rust-lang/rust.vim')
-- "call minpac#add('posva/vim-vue')
-- "call minpac#add('hail2u/vim-css3-syntax')
-- "call minpac#add('elixir-lang/vim-elixir')
-- "call minpac#add('pangloss/vim-javascript')
-- "call minpac#add('plasticboy/vim-markdown')
-- "call minpac#add('stephpy/vim-yaml')
-- "call minpac#add('leafgarland/typescript-vim')
-- "call minpac#add('peitalin/vim-jsx-typescript')
-- "call minpac#add('NoahTheDuke/vim-just')

return {
  "maxmx03/solarized.nvim",
  "mhinz/vim-startify",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "nvim-tree/nvim-tree.lua",
  "jremmen/vim-ripgrep",
  "junegunn/fzf",
  "tpope/vim-vinegar",
  "tpope/vim-surround",
  "tpope/vim-projectionist",
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
  -- {
  --   "mason-org/mason-lspconfig.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  -- },
  {
    "folke/trouble.nvim",
    opts = {},
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
	highlight = { enable = true },
      })
    end,
  }
}
