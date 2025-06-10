local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { 'superhtml', 'lsp' },
  filetypes = { 'superhtml', 'html' },
  root_markers = { '.git' },
  capabilities = capabilities
}
