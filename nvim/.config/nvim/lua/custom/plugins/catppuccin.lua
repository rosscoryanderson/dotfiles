return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
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
            },
        }
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd("colorscheme catppuccin-mocha")
            -- flavour = "latte",
            -- no_italic = true,
            -- transparent_background = true,
            -- default_integrations = true,
            -- integrations = {
            --     nvimtree = true,
            --     treesitter = true,
            --     notify = true,
            --     mini = {
            --         enabled = true,
            --         indentscope_color = "",
            --     }
            -- }
        -- })
    end
}
