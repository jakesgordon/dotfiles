return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  workspace_required = true,
  root_markers = {
    "tsconfig.json",
    "package.json",
    ".git"
  },
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false -- let biome do this
  end,
}
