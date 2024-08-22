-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "tsserver", "solargraph", "pyright", "jsonls"}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index", "--query-driver=/usr/bin/g++" },  -- Adjust additional options as needed
})

lspconfig.efm.setup {
  init_options = {documentFormatting = true},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      python = {
        {
          lintCommand = "flake8 --stdin-display-name ${INPUT} -",
          lintStdin = true,
          lintFormats = {"%f:%l:%c: %m"},
          lintIgnoreExitCode = true,
        },
        {
          formatCommand = "autopep8 --aggressive --aggressive -",
          formatStdin = true
        },
      }
    }
  },
  filetypes = {"python"},
}

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
