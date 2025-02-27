vim.g.mapleader = ' '

-- wrap
vim.keymap.set('n', '<Leader>w', ':set wrap! linebreak!<cr>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- navigation
--- behave like other capitals
vim.keymap.set('n', 'Y', 'y$')
--- keeping it centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')
--- moving text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader>k', ':m .-2<CR>==')
vim.keymap.set('n', '<leader>j', ':m .+1<CR>==')

-- telescope
-- vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<cr>")
-- vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>")
-- vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<cr>")
-- vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope bibtex<cr>")

-- function navigation
vim.keymap.set('n', '<leader>h', 'ci{')
vim.keymap.set('n', '<leader>l', 'ci(')

--- quicklist
vim.keymap.set('n', '<leader>qn', '<cmd>:cnext<cr>')
vim.keymap.set('n', '<leader>qp', '<cmd>:cprev<cr>')
vim.keymap.set('n', '<leader>qo', '<cmd>:copen<cr>')

-- lua tree
vim.keymap.set('n', '<Leader>tt', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<Leader>tf', '<cmd>NvimTreeFindFileToggle<cr>')
vim.keymap.set('n', '<Leader>tr', '<cmd>NvimTreeRefresh<cr>')

-- language server
vim.keymap.set('n', '<Leader>vd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<Leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<Leader>vsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<Leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<Leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Leader>vh', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<Leader>vsd', "<cmd>lua vim.diagnostic.open_float({scope='line'})<CR>")
vim.keymap.set('n', '<Leader>vn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<Leader>vp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<Leader>vf', '<cmd>Format<CR>')

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

vim.keymap.set('n', '<leader>vwm', function()
  require('--vim-with-me').StartVimWithMe()
end)
vim.keymap.set('n', '<leader>svwm', function()
  require('--vim-with-me').StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'jj', '<Esc>')

vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format)

vim.keymap.set('n', '<leader>d', 'yyp')

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')

vim.keymap.set('x', "'", [[:s/\%V\(.*\)\%V/'\1'/ <CR>]], { desc = "Surround selection with '" })
vim.keymap.set('x', '"', [[:s/\%V\(.*\)\%V/"\1"/ <CR>]], { desc = 'Surround selection with "' })
vim.keymap.set('x', '*', [[:s/\%V\(.*\)\%V/*\1*/ <CR>]], { desc = 'Surround selection with *' })

vim.keymap.set('n', '<leader>s*', [[:s/\<<C-r><C-w>\>/*<C-r><C-w>\*/ <CR>]], { desc = 'Surround word with *' })
vim.keymap.set('n', '<leader>s"', [[:s/\<<C-r><C-w>\>/"<C-r><C-w>\"/ <CR>]], { desc = 'Surround word with "' })
vim.keymap.set('n', "<leader>s'", [[:s/\<<C-r><C-w>\>/'<C-r><C-w>\'/ <CR>]], { desc = "Surround word with '" })

vim.keymap.set('n', 'go', 'o<ESC>', { desc = 'Insert new line below' })
vim.keymap.set('n', '<Enter>', 'o<ESC>', { desc = 'Insert new line below' })
vim.keymap.set('n', 'gO', 'O<ESC>', { desc = 'Insert new line above' })
vim.keymap.set('n', '<S-Enter>', 'O<ESC>', { desc = 'Insert new line above' })
