return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  opts = {},
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function ()
    require("oil").setup();
  end
};
