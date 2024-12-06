-- Language servers
local servers = {
  'ansiblels',
  'bashls',
  'gopls',
  'pylsp',
  'rust_analyzer',
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
