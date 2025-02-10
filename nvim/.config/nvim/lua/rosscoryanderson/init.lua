require("rosscoryanderson.config.keymaps")
require("rosscoryanderson.config.options")
require("rosscoryanderson.config.lazy")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
