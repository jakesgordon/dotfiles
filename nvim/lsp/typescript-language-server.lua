return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "typescript",
  },
  workspace_required = true,
  root_markers = {
    "tsconfig.json",
    "package.json",
    ".git"
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
}
