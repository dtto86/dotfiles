return {
  {
    "lewis6991/gitsigns.nvim",
    -- opts = {
    --   signs = {
    --     add          = { text = "▎" },
    --     change       = { text = "▎" },
    --     delete       = { text = "▎" },
    --     topdelete    = { text = "▎" },
    --     changedelete = { text = "▎" },
    --   },
    --   signcolumn = true, -- enable signs in sign column
    --   numhl      = false,
    --   linehl     = false,
    --   word_diff  = false,
    -- },
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      local colors = {
        add = "#587c0c",    -- green (added)
        change = "#d7ba7d", -- yellow (modified)
        delete = "#f14c4c", -- red (deleted)
      }

      require("scrollbar").setup({
        handle = { color = "#4e4e4e" }, -- scrollbar thumb
        marks = {
          GitAdd = { text = "│", color = colors.add },
          GitChange = { text = "│", color = colors.change },
          GitDelete = { text = "│", color = colors.delete },
        },
      })

      -- enable gitsigns integration
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}

