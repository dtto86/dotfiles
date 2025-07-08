return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-lua/plenary.nvim", -- for Path module
  },
  opts = {
    servers = {
      eslint = {
        settings = {
          -- eslint = {
            -- Dynamically set `nodePath` per file
          nodePath = (function()
            local Path = require("plenary.path")
            -- local util = require("lspconfig.util")

            local fname = vim.api.nvim_buf_get_name(0)
            local dir = vim.fn.fnamemodify(fname, ":p:h")
            local current = Path:new(dir)

            while current.filename ~= current:parent().filename do
              if current:joinpath("node_modules"):is_dir() then
                print("Found node_modules in: " .. current:absolute())
                return current:absolute()
              end
              current = current:parent()
            end

            print("No node_modules found, using default path")
            -- return vim.fn.getcwd() -- fallback to CWD
            -- return "/home/pravin/.nvm/versions/node/v20.18.0/lib/node_modules/eslint/"
            return "/home/pravin/.nvm/versions/node/v20.18.0/lib/node_modules"
            -- return "/home/pravin/.nvm/versions/node/v20.18.0/bin"
          end)(),
          workingDirectories = { mode = "auto" },
          -- },
          format = { enable = false }, -- formatting handled separately
        },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("eslint.config.mjs", ".eslintrc.js", "package.json")(fname)
        end,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      },
    },
  },
}
