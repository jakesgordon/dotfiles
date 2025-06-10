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
}
