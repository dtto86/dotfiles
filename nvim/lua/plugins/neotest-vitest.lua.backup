return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio", -- Required dependency :cite[8]
      "marilari88/neotest-vitest", -- Vitest adapter :cite[1]
      -- Other adapters (e.g., neotest-jest) if needed
    },
    opts = function(_, opts)
      -- Initialize adapters table if empty
      opts.adapters = opts.adapters or {}
      -- Add neotest-vitest with optional configuration
      table.insert(
        opts.adapters,
        require("neotest-vitest")({
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules" -- Ignore node_modules :cite[1]
          end,
          -- Optional: Custom test file detection
          is_test_file = function(file_path)
            return string.match(file_path, "%.test%.ts") ~= nil
          end,
        })
      )
      return opts
    end,
  },
}
