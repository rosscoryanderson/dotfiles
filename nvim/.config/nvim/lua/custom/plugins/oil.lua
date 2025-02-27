return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require('oil').setup {
      default_file_explorer = false,
      delete_to_trash = true,
      columns = { 'icon' },
      keymaps = {
        ['C-h'] = false,
        ['M-h'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),

      -- Open parent directory in floating windows
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float),
    }
  end,
}
