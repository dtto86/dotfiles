-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    {
      'mason-org/mason.nvim',
      opts = {},
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
        -- This is the default configuration, you can change it to your liking
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'js', -- JavaScript/TypeScript debugger
          -- 'go', -- Uncomment this if you want to debug Go code
          -- 'python', -- Uncomment this if you want to debug Python code
          -- Add more languages as needed
        },
      },
    },

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js',
  },
  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(LazyVim.config.icons.dap) do
      -- sign = type(sign) == "table" and sign or { sign }
      local text, texthl, linehl, numhl
      if type(sign) == "table" then
        text = sign[1]
        texthl = sign[2] or "DiagnosticInfo"
        linehl = sign[3]
        numhl = sign[3]
      else
        text = sign
        texthl = "DiagnosticInfo"
        linehl = nil
        numhl = nil
      end

      vim.fn.sign_define(
        "Dap" .. name,
        { text = text, texthl = texthl, linehl = linehl, numhl = numhl }
      )
    end

    -- Install vscode-js-debug specific config
    require('dap-vscode-js').setup {
      node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter', -- Path to js-debug-adapter installation. Defaults to mason.nvim installation path.
      debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      log_file_path = vim.fn.stdpath('cache') .. '/dap_vscode_js.log', -- Path for file logging
      log_file_level = 0, -- Logging level for output to file. Set to false to disable file logging.
      log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
    }

    for _, language in ipairs { 'typescript', 'javascript' } do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch npm script',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch api npm script",
          runtimeExecutable = "npm",
          runtimeArgs = { "run", "start-api" }, -- or whatever script
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch ui npm script",
          runtimeExecutable = "npm",
          runtimeArgs = { "run", "start:all" }, -- or whatever script
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}/src',
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
        },
      }
    end
  end,
}
