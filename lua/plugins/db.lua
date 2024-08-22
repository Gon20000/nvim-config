return {
  {
    "tpope/vim-dadbod",
    config = function()
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      {
        'tpope/vim-dadbod',
        lazy = true
      },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql', 'sqlite3' },
        lazy = true
      }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    config = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }
}
