return {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'css',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'typescript',
    'typescriptreact'
  },
  workspace_required = true,
  root_markers = {
    "tsconfig.json",
    "package.json",
    "biome.json",
    ".git",
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false -- no! I fucking hate auto formatting
  end,
}
