-- TODO
-- ====
-- * auto-format (on demand/save)

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
vim.g.loaded_python3_provider = 0              -- disable unused plugin provider, we only use lua or vim plugins
vim.g.loaded_ruby_provider = 0                 -- (ditto)
vim.g.loaded_node_provider = 0                 -- (ditto)
vim.g.loaded_perl_provider = 0                 -- (ditto)

-- LEADER KEYS
-- ===========

vim.g.mapleader = "\\"

vim.keymap.set("n", "<Leader>a", ":Rg<Space>")
vim.keymap.set("n", "<Leader>F", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>t", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>g", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>h", ":Telescope help_tags<CR>")
vim.keymap.set("n", "<Leader>d", ":set background=dark<CR>")
vim.keymap.set("n", "<Leader>l", ":set background=light<CR>")
vim.keymap.set("n", "<Leader>e", ":Telescope diagnostics<CR>")
vim.keymap.set("n", "<Leader>E", ":Trouble diagnostics toggle<CR>")
vim.keymap.set("v", "<Leader>Y", '"+y')
vim.keymap.set("n", "<Leader>P", '"+P')
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- QUICK SAVE
-- ==========

vim.keymap.set("",  "<C-s>", ":wa<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>")
vim.keymap.set("",  "<C-q>", ":qa<CR>")
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>")

-- QUICK ENTRY INTO INSERT MODE
-- ============================

-- vim.keymap.set("n", "<Space>", "i<Space>")
-- vim.keymap.set("n", "<Del",    "i<Del>")

-- WINDOW MANAGEMENT
-- =================

vim.keymap.set("n", "_",      "<C-W>s<C-W><Down>")
vim.keymap.set("n", "<Bar>",  "<C-W>v<C-W><Right>")
vim.keymap.set("n", "<C-c>",  "<C-w>c")
vim.keymap.set("n", "<C-w>-", "4<C-w>-")
vim.keymap.set("n", "<C-w>_", "4<C-w>-")
vim.keymap.set("n", "<C-w>+", "4<C-w>+")
vim.keymap.set("n", "<C-w>=", "4<C-w>+")
vim.keymap.set("n", "<C-w><", "8<C-w><")
vim.keymap.set("n", "<C-w>>", "8<C-w>>")
vim.keymap.set("n", "<C-w>,", "8<C-w><")
vim.keymap.set("n", "<C-w>.", "8<C-w>>")

-- EDIT COMMANDS
-- =============

vim.api.nvim_create_user_command("EditVim", "edit ~/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("EditBash", "edit ~/.bashrc", {})

-- RIPGREP
-- =======

vim.g.rg_highlight = 1
vim.g.rg_command = "rg --vimgrep --color=never"

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

vim.keymap.set("n", "<C-e>", function()
  local diagnostics = vim.diagnostic.get(0, {lnum = vim.fn.line(".") - 1})
  if #diagnostics == 0 then
    vim.diagnostic.goto_next()
  end
  vim.diagnostic.open_float(nil, { focusable = false })
end)

-- AIRLINE
-- =======
vim.g.airline_powerline_fonts = 1

-- AUTO COMMENT
-- ============

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- disable auto-comment on newline
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    -- remove comment leader when joining comment lines
    vim.opt_local.formatoptions:append("j")
  end,
})

-- LAZY PLUGINS
-- ============

require("config.lazy")
vim.cmd("colorscheme solarized")

-- TREE VIEW
-- =========

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
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

-- TROUBLE
-- =======

require("trouble").setup({
  opts = {},
  cmd = "Trouble",
})

-- TELESCOPE
-- =========

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
    },
    mappings = {
      i = {
        ["<Esc>"] = require("telescope.actions").close
      }
    }
  }
})

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

-- LSPs
-- ====

require("mason").setup()

local registry = require("mason-registry")
local servers = {
  "biome",
  "css-lsp",
  "gopls",
  "json-lsp",
  "just-lsp",
  "lua-language-server",
  "sqruff",
  "superhtml",
  "typescript-language-server",
  "vue-language-server",
  "yaml-language-server",
}
for _, server in ipairs(servers) do
  if not registry.is_installed(server) then
    vim.cmd("MasonInstall " .. server)
  end
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 }
    end)
    vim.keymap.set("n", "<C-k>", function()
      vim.lsp.buf.signature_help { border = "rounded", title = false, max_height = 25, max_width = 120 }
    end)
  end,
})
