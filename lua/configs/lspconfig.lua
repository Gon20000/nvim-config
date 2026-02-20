local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "ts_ls", "solargraph", "pyright", "jsonls", "eslint", "intelephense" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end


lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index", "--query-driver=/usr/bin/g++" }, -- Adjust additional options as needed
})

lspconfig.efm.setup {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      python = {
        {
          lintCommand = "flake8 --stdin-display-name ${INPUT} -",
          lintStdin = true,
          lintFormats = { "%f:%l:%c: %m" },
          lintIgnoreExitCode = true,
        },
        {
          formatCommand = "autopep8 --aggressive --aggressive -",
          formatStdin = true
        },
      }
    }
  },
  filetypes = { "python" },
}

-- disable formatting
lspconfig.ts_ls.setup {
  on_attach = function(client)
    -- disable tsserver formatting in favor of eslint/prettier
    client.server_capabilities.documentFormattingProvider = false
  end,
}


-- Minimal on_attach: only refactor/code actions
local phpactor_on_attach = function(client, bufnr)
  -- Disable hover, go-to, etc. — leave those for Intelephense
  client.server_capabilities.hoverProvider = false
  client.server_capabilities.definitionProvider = false
  client.server_capabilities.referencesProvider = false
  client.server_capabilities.renameProvider = true
  client.server_capabilities.codeActionProvider = true

  -- NvChad-style keymap for code actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
    { buffer = bufnr, noremap = true, silent = true, desc = "Phpactor: Code Action" })
end

-- Use the global Phpactor instead of Mason’s local one
lspconfig.phpactor.setup {
  cmd = { "phpactor", "language-server" }, -- <-- global binary
  on_attach = phpactor_on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',
  { noremap = true, silent = true })
