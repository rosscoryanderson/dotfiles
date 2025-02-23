return {
  'mawkler/modicator.nvim',
  dependencies = 'catppuccin/nvim',
  -- dependencies = 'catppuccin',
  init = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
}

