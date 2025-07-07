-- local util = require("lint.util")
return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      vue = { "eslint" },
    }

    local function find_nearest_node_modules(dir)
      local Path = require("plenary.path")
      local current = Path:new(dir)

      while current.filename ~= current:parent().filename do
        if current:joinpath("node_modules"):exists() then
          -- print("Using cwd:", current:absolute())
          return current:absolute()
        end
        current = current:parent()
      end

      -- print("Falling back to cwd:", vim.fn.getcwd())
      return vim.fn.getcwd() -- fallback to current working directory
    end

    -- local filename = vim.api.nvim_buf_get_name(0)
    -- Custom eslint_d config to handle monorepo root + per-workspace
    lint.linters.eslint = {
      name = "eslint",
      parser = require("lint.parser").from_errorformat("%f:%l:%c: %t%*[^:]: %m", {
        source = "eslint",
        severity = {
          E = vim.diagnostic.severity.ERROR,
          W = vim.diagnostic.severity.WARN,
        },
      }),

      cmd = "./node_modules/.bin/eslint",
      stdin = true,
      -- args = {
      --   "--stdin",
      --   "--stdin-filename",
      --   filename,
      -- },
      -- env = {
      --   -- Helps eslint_d resolve config from monorepo root
      --   -- or use workspace local eslint when run through eslint_d
      --   -- You may optionally set NODE_PATH to root to help resolution
      --   NODE_ENV = "development",
      -- },
      -- cwd = function()
      --   local buf_path = vim.api.nvim_buf_get_name(0)
      --   local dir = vim.fn.fnamemodify(buf_path, ":p:h")
      --   return find_nearest_node_modules(dir)
      -- end,
      -- cwd = vim.fn.getcwd(), -- or custom logic to find nearest package.json
    }

    -- Auto-lint on these events
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        local dir = vim.fn.fnamemodify(filename, ":p:h")
        local cwd = find_nearest_node_modules(dir)
        lint.try_lint("eslint", {
          args = {
            "--stdin",
            "--stdin-filename",
            filename,
          },
          cwd = cwd,
    })
      end,
    })
  end,
}
