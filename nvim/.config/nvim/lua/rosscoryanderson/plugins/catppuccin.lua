return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd("colorscheme catppuccin")
        require("catppuccin").setup({
            flavour = "mocha",
            no_italic = true,
            transparent_background = true,
            default_integrations = true,
            integrations = {
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                }
            }
        })
    end
}
