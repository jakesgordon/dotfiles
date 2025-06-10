-- TODO
-- ====
-- * telescope.nvim - https://github.com/nvim-telescope/telescope.nvim
-- * decide on LSP strategy (mason or no mason - maybe copy neovim/nvim-lspconfig files into lua/lsp dir ?

-- * go - cloud-cli
-- * c# - cloud-platform
-- * ruby - ???
-- * elixir - ???
-- * python - ???
-- * java - ???
-- * c/c++ - ???
-- * do I still need any of those legacy language plugins???
-- * (maybe) replace vim-airline with lualine.nvim

-- =================
-- GENERAL SETTINGS
-- =================

vim.cmd("syntax on")                 -- enable syntax highlighting
vim.cmd("filetype plugin indent on") -- enable per-filetype plugins

vim.opt.backspace = "indent,eol,start"         -- allow backspacing over everything in insert mode
vim.opt.backup = true                          -- keep a backup file
vim.opt.backupcopy = "yes"                     -- use overwrite strategy for backups (to avoid issues with node file watchers)
vim.opt.backupdir = vim.fn.expand("~/.backup") -- custom backup directory
vim.opt.cmdheight = 3                          -- set command line 3 lines high
vim.opt.colorcolumn = "100"                    -- highlight the 120th column
vim.opt.completeopt = "menu,menuone,preview,noselect,noinsert"
vim.opt.expandtab = true                       -- expand tabs to spaces
vim.opt.gdefault = true                        -- replace all instances on line when doing global search/replace
vim.opt.hidden = true                          -- allow hidden buffers with unsaved changes
vim.opt.hlsearch = true                        -- highlight search terms
vim.opt.ignorecase = true                      -- case insensitive search by default
vim.opt.incsearch = true                       -- do incremental searching
vim.opt.laststatus = 2                         -- always put a status line in.
vim.opt.foldenable = false                     -- disable code folding (I find it annoying)
vim.opt.wrap = false                           -- no line wrapping
vim.opt.number = true                          -- enable line numbers
vim.opt.ruler = true                           -- show the cursor position all the time
vim.opt.scrolloff = 10                         -- start scrolling 10 lines from the top/bottom
vim.opt.secure = true                          -- enable per-project .vimrc files in a secure way - https://andrew.stwrt.ca/posts/project-specific-vimrc/
vim.opt.shiftwidth = 2                         -- indent action = 2 spaces
vim.opt.showcmd = true                         -- display incomplete commands
vim.opt.showmatch = true                       -- show matching parens
vim.opt.showmode = true                        -- so you know what mode you are in
vim.opt.smartcase = true                       -- do case sensitive search if search term contains uppercase
vim.opt.softtabstop = 2                        -- soft tabs = 2 spaces
vim.opt.tabstop = 2                            -- tabs = 2 spaces
vim.opt.timeoutlen = 1000                      -- timeout on mappings after 1 second
vim.opt.ttimeoutlen = 0                        -- timeout on key codes immediately (to avoid pause after ESC)
vim.opt.virtualedit:append("block")            -- allow virtual-block select to go past end of lines
vim.opt.whichwrap = "<,>,[,]"                  -- allow arrow keys to line wrap
vim.opt.wildignore:append("*.o,*.a")           -- ignore these when completing file or directory names
vim.opt.wildignore:append("*.pui,*.prj")       -- (ditto)
vim.opt.wildignore:append("*.svn,*.git")       -- (ditto)
vim.opt.wildignore:append("*.swp")             -- (ditto)
vim.opt.wildignore:append("_build")            -- (ditto)
vim.opt.wildignore:append("bin,gen")           -- (ditto)
vim.opt.wildignore:append("deps")              -- (ditto)
vim.opt.wildignore:append("node_modules")      -- (ditto)
vim.opt.wildignore:append("tmp")               -- (ditto)
vim.opt.wildmenu = true                        -- enable enhanced command line completion
vim.opt.wildmode = "longest,list"              -- and show bash like auto complete list
vim.opt.termguicolors = true                   -- enable 24 bit RGB color
vim.opt.background = "light"                   -- default to light background

-- LEADER KEYS
-- ===========

vim.g.mapleader = "\\"

vim.keymap.set("n", "<Leader>f", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>a", ":Rg<Space>")
vim.keymap.set("n", "<Leader>t", ":FZF<CR>")
vim.keymap.set("n", "<Esc>", ":noh<CR>")
vim.keymap.set("n", "<Leader>d", ":set background=dark<CR>")
vim.keymap.set("n", "<Leader>l", ":set background=light<CR>")
vim.keymap.set("v", "<Leader>Y", '"+y')
vim.keymap.set("n", "<Leader>P", '"+P')

-- QUICK SAVE
-- ==========
vim.keymap.set("",  "<C-s>", ":wa<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>")
vim.keymap.set("",  "<C-q>", ":qa<CR>")
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>")

-- QUICK ENTRY INTO INSERT MODE
-- ============================
vim.keymap.set("n", "<Space>", "i<Space>")
vim.keymap.set("n", "<Del",    "i<Del>")

-- WINDOW MANAGEMENT
-- =================
vim.keymap.set("n", "_",      "<C-W>s<C-W><Down>")
vim.keymap.set("n", "<Bar>",  "<C-W>v<C-W><Right>")
vim.keymap.set("n", "<C-x>",  "<C-w>c")
vim.keymap.set("n", "<C-w>-", "4<C-w>-")
vim.keymap.set("n", "<C-w>_", "4<C-w>-")
vim.keymap.set("n", "<C-w>+", "4<C-w>+")
vim.keymap.set("n", "<C-w>=", "4<C-w>+")
vim.keymap.set("n", "<C-w><", "8<C-w><")
vim.keymap.set("n", "<C-w>>", "8<C-w>>")
vim.keymap.set("n", "<C-w>,", "8<C-w><")
vim.keymap.set("n", "<C-w>.", "8<C-w>>")

-- DIAGNOSTICS
-- ===========

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  }
});

vim.keymap.set("n", "<Leader>xx", function()
  require("trouble").toggle({
    mode = "diagnostics",
    focus = true
  })
end)

vim.keymap.set("n", "<C-e>", function()
  local diagnostics = vim.diagnostic.get(0, {lnum = vim.fn.line(".") - 1})
  if #diagnostics == 0 then
    vim.diagnostic.goto_next()
  end
  vim.diagnostic.open_float(nil, { focusable = false })
end)

-- CUSTOM COMMANDS
-- ===============
vim.api.nvim_create_user_command("EditVim", "edit ~/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("EditBash", "edit ~/.bashrc", {})

-- CUSTOM Rg
-- =========
vim.g.rg_highlight = 1
vim.g.rg_command = "rg --vimgrep --color=never"

-- CUSTOM FZF
-- ==========
vim.g.fzf_layout = { -- Popup window (anchored to the bottom of the current window)
  window = {
    width = 1.0,
    height = 0.4,
    relative = true,
    yoffset = 1.0
  }
}

-- CUSTOM Airline
-- ==============
vim.g.airline_powerline_fonts = 1

-- CUSTOM AUTO COMMENT
-- ===================

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- disable auto-comment on newline
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    -- remove comment leader when joining comment lines
    vim.opt_local.formatoptions:append("j")
  end,
})

-- PLUGINS
-- =======
require("config.lazy")
vim.cmd("colorscheme solarized")

-- AUTO COMPLETE
-- =============
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSPs - NOPE
-- ====

-- require("mason").setup()
-- require("mason-lspconfig").setup({
--   automatic_enable = false,
--   ensure_installed = {
--     "lua_ls",
--     "ts_ls",
--     "biome",
--     "html",
--   }
-- })
--
-- require("lspconfig").lua_ls.setup({
--   settings = {
--     Lua = {
--       diagnostics = { globals = { "vim" } }
--     }
--   }
-- })
--
-- require("lspconfig").ts_ls.setup({
-- })
--
-- require("lspconfig").biome.setup({
-- })
--
-- require("lspconfig").html.setup({
--   settings = {
--     html = {
--       validate = true,
--       suggest = {
--         html5 = true,
--       },
--     },
--   },
-- })


-- LSPs - MAYBE
-- ====

require("mason").setup()

local registry = require("mason-registry")
local servers = {
  "lua-language-server",
  "typescript-language-server",
  "superhtml",
  "css-lsp",
  "json-lsp",
  "yaml-language-server",
  "sqlls",
}

for _, server in ipairs(servers) do
  if not registry.is_installed(server) then
    vim.cmd("MasonInstall " .. server)
  end
end

vim.lsp.config["lua-language-server"] = {
  cmd = { "lua-language-server" },
  filetypes = { 'lua' },
  root_markers = {
    '.git',
    '.luarc.json',
    '.luarc.jsonc',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  },
  capabilities = capabilities
}

vim.lsp.config["typescript-language-server"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "typescript",
  },
  root_markers = {
    "tsconfig.json",
    "package.json",
    ".git"
  },
  capabilities = capabilities
}

vim.lsp.config["superhtml"] = {
  cmd = { 'superhtml', 'lsp' },
  filetypes = { 'superhtml', 'html' },
  root_markers = { '.git' },
  capabilities = capabilities
}

vim.lsp.config["css-lsp"] = {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { 'package.json', '.git' },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  capabilities = capabilities
}

vim.lsp.config["json-lsp"] = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  capabilities = capabilities
}

vim.lsp.config["yaml-language-server"] = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { '.git' },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
  },
  capabilities = capabilities
}

vim.lsp.config["sqlls"] = {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = { 'sql', 'mysql' },
  root_markers = { '.sqllsrc.json' },
  settings = {
    sqlLanguageServer = {
      lint = {
        rules = {
          ["linebreak-after-clause-keyword"] = "off"
        }
      }
    }
  },
  capabilities = capabilities
}

vim.lsp.enable("lua-language-server")
vim.lsp.enable("typescript-language-server")
vim.lsp.enable("superhtml")
vim.lsp.enable("css-lsp")
vim.lsp.enable("json-lsp")
vim.lsp.enable("yaml-language-server")
vim.lsp.enable("sqlls")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = true,
    custom = {
      "^.git$",
    }
  },
})

