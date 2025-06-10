local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
  cmd = { 'sqruff', 'lsp' },
  filetypes = { 'sql' },
  root_markers = { '.sqruff', '.git' },
  capabilities = capabilities
}
