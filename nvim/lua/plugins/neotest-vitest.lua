return {
  "nvim-neotest/neotest",
  dependencies = {
    "marilari88/neotest-vitest",
  },
  opts = {
    adapters = {
      -- ["neotest-vitest"] = {},
      ["neotest-vitest"] = require("neotest-vitest")({
        vitestCommand = "vitest",
        vitestConfigFile = "vitest.config.js",
        cwd = function()
          return vim.fn.getcwd()
        end,
        env = { CI = "1" },
        is_test_file = function(file_path)
          return file_path:match("%.test%.js$") or file_path:match("%.spec%.js$")
        end,
      }),
    },
  },
}

