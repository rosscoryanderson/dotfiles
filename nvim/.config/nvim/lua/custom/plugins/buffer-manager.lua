return {
  'j-morano/buffer_manager.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('buffer_manager').setup {
      select_menu_item_commands = {
        v = {
          key = '<C-v>',
          command = 'vsplit',
        },
        h = {
          key = '<C-h>',
          command = 'split',
        },
      },
      focus_alternate_buffer = false,
      short_file_names = true,
      short_term_names = true,
      loop_nav = false,
      highlight = 'Normal:BufferManagerBorder',
      win_extra_options = {
        winhighlight = 'Normal:BufferManagerNormal',
      },
    }
    local bmui = require 'buffer_manager.ui'
    vim.keymap.set({ 't', 'n' }, '<leader>bb', bmui.toggle_quick_menu, {})
  end,
}
