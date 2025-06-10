local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
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
