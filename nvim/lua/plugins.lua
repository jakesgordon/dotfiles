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
    "andythigpen/nvim-coverage",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "elixir",
        "erlang",
        "go",
        "hcl",
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
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  }
}
