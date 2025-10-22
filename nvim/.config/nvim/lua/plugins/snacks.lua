return {
  "snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      hidden = true,
      ignored = true,
      sources = {
        explorer = {
          layout = {
            preset = "sidebar",
            preview = true,
          },
        },
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
