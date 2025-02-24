return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.keymap.set("n", "<space>bp", "<cmd>BufferLinePick<CR>", {
            desc = "pick a buffer",
        })

        require("bufferline").setup({
            options = {
                offsets = {
                    {
                        filetype = "snacks_layout_box",
                        text = "Explorer",
                        separator = true,
                        text_align = "left",
                        highlight = "Directory"
                    }
                },
                diagnostics = "nvim_lsp",
                separator_style = { "", "" },
                modified_icon = '●',
                -- show_close_icon = false,
                -- show_buffer_close_icons = false,
            }
        })
    end
}
