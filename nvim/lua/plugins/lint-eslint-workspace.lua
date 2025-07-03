local util = require("lint.util")

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
    linters = {
      eslint_d = {
        -- cmd = "eslint_d",
        cmd = "./node_modules/.bin/eslint",
        args = {
          "--stdin",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
        },
        stdin = true,
        cwd = function(bufnr)
          -- Find nearest folder with node_modules
          return util.root_pattern("node_modules")(vim.api.nvim_buf_get_name(bufnr))
        end,
      },
    },
  },
}
