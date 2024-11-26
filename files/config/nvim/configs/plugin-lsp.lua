-- Language servers
local servers = {
  'ansiblels',
  'bashls',
  --'golangci_lint_ls',
  'gopls',
  'pylsp',
  'terraformls',
  'vimls',
  'yamlls'
}

-- Enable language servers w/ additional capabilities from cmp
for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
end
