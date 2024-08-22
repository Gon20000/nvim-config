local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)  -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completion
    { name = 'luasnip' },   -- Snippet completion
  }, {
    { name = 'buffer' },    -- Buffer completion
    { name = 'path' },      -- Path completion
  })
})

-- Setup for SQL and SQLite filetypes using vim-dadbod-completion
cmp.setup.filetype({ "sql", "sqlite3", "db" }, {
 sources = cmp.config.sources({
    { name = "vim-dadbod-completion" },  -- SQL/SQLite-specific completion
    { name = "buffer" },                 -- Buffer completion
  })
})
