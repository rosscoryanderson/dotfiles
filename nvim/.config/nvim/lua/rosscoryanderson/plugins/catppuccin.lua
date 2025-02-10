return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        -- vim.cmd.colorscheme = "catppuccin"
        vim.cmd("colorscheme catppuccin")
        require("catppuccin").setup({
            flavour = "macchiato",
            no_italic = true
        })
    end
}
