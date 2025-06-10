return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json' },
  -- https://github.com/vuejs/language-tools/blob/v2/packages/language-server/lib/types.ts
  init_options = {
    typescript = {
      tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib'
    },
  },
}
