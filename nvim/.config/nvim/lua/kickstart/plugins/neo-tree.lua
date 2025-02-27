-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = false,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',

          -- test keybinds to switch between modes.
          ['e'] = function()
            vim.api.nvim_exec('Neotree focus filesystem left', true)
          end,
          ['b'] = function()
            vim.api.nvim_exec('Neotree focus buffers left', true)
          end,
          ['g'] = function()
            vim.api.nvim_exec('Neotree focus git_status left', true)
          end,

          -- open file in finder
          ['o'] = 'system_open',
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          '.DS_Store',
        },
        hide_by_pattern = {
          '*.bak',
        },
      },
    },
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      -- macOs: open file in default application in the background.
      vim.fn.jobstart({ 'open', path }, { detach = true })
    end,
  },
}
