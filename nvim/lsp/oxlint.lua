return {
  cmd = { 'oxlint', '--lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact'
  },
  workspace_required = true,
  root_markers = {
    ".oxlintrc.json",
    ".oxlintrc.jsonc",
    "oxlint.config.ts",
  },
}
