local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { 'just-lsp' },
  filetypes = { 'just' },
  root_markers = { '.git' },
  capabilities = capabilities,
}
