return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',       -- LSP completion
    'hrsh7th/cmp-buffer',         -- Buffer completion
    'hrsh7th/cmp-path',           -- Path completion
    'saadparwaiz1/cmp_luasnip',   -- Snippet completion
    'L3MON4D3/LuaSnip',           -- Snippet engine
  },
  config = function ()
    require "configs.cmp"
  end
}
