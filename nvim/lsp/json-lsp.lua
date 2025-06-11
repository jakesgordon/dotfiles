return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false -- let biome do this
  end,

}
