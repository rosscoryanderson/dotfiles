return {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000, -- Ensure it loads first
    config = function()
        -- vim.cmd("colorscheme onedark_vivid")
        require("onedarkpro").setup({
            styles = {
                types = "NONE",
                methods = "NONE",
                numbers = "NONE",
                strings = "NONE",
                comments = "NONE",
                keywords = "bold",
                constants = "NONE",
                functions = "bold",
                operators = "NONE",
                variables = "NONE",
                parameters = "NONE",
                conditionals = "NONE",
                virtual_text = "NONE",
            }
        })
    end
}
