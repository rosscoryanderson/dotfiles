return {
  "mbbill/undotree",
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
    -- require("undotree").setup({})
  end
}
