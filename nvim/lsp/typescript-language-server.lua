local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
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
