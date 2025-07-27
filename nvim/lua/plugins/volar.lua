return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    setup = {
      volar = function(_, opts)
        opts.filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }
        opts.on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          require("lazyvim.plugins.lsp.keymaps").on_attach(client, bufnr)
          -- vim.keymap.del("n", "gd", { buffer = bufnr })
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        end
        -- opts.handlers = {
        --   ["textDocument/definition"] = vim.lsp.buf.definition,
        --   ["textDocument/hover"] = vim.lsp.buf.hover,
        --   ["textDocument/signatureHelp"] = vim.lsp.buf.signature_help,
        -- }
        opts.handlers = vim.tbl_extend("force", opts.handlers or {}, {
          ["textDocument/definition"] = function(...)
            vim.lsp.buf.definition(...)
          end,
        })
        return opts
      end,
    }
  }
}
