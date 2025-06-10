return {
  cmd = { 'just-lsp' },
  filetypes = { 'just' },
  root_markers = { '.git' },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
