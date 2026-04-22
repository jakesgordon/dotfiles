---@brief
---
--- https://github.com/hashicorp/terraform-ls
---
--- HashiCorp's official LSP server for Terraform.

return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform.lock.hcl', '.terraform', '.git' },
}
