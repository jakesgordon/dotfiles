return {
  cmd = { 'biome', 'lsp-proxy' },
  filetypes = {
    'css',
    'javascript',
    'json',
    'jsonc',
    'typescript',
    'vue',
  },
  workspace_required = true,
  root_markers = {
    "tsconfig.json",
    "package.json",
    "biome.json",
    ".git",
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
