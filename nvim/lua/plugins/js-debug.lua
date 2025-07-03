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
  -- keys = {
  --   -- Basic debugging keymaps, feel free to change to your liking!
  --   {
  --     '<leader>dc',
  --     function()
  --       require('dap').continue()
  --     end,
  --     desc = 'Debug: Start/Continue',
  --   },
  --   {
  --     '<leader>di',
  --     function()
  --       require('dap').step_into()
  --     end,
  --     desc = 'Debug: Step Into',
  --   },
  --   {
  --     '<leader>do',
  --     function()
  --       require('dap').step_over()
  --     end,
  --     desc = 'Debug: Step Over',
  --   },
  --   {
  --     '<leader>dI',
  --     function()
  --       require('dap').step_out()
  --     end,
  --     desc = 'Debug: Step Out',
  --   },
  --   {
  --     '<leader>db',
  --     function()
  --       require('dap').toggle_breakpoint()
  --     end,
  --     desc = 'Debug: Toggle Breakpoint',
  --   },
  --   {
  --     '<leader>dB',
  --     function()
  --       require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  --     end,
  --     desc = 'Debug: Set Breakpoint',
  --   },
  --   -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  --   {
  --     '<F7>',
  --     function()
  --       require('dapui').toggle()
  --     end,
  --     desc = 'Debug: See last session result.',
  --   },
  -- },
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
    -- local dap = require 'dap'
    -- local dapui = require 'dapui'

    -- require('mason').setup()
    -- require('mason-nvim-dap').setup {
    --   -- Makes a best effort to setup the various debuggers with
    --   -- reasonable debug configurations
    --   automatic_installation = true,
    --
    --   -- You can provide additional configuration to the handlers,
    --   -- see mason-nvim-dap README for more information
    --   handlers = {},
    --
    --   -- You'll need to check that you have the required things installed
    --   -- online, please don't ask me how to install them :)
    --   ensure_installed = {
    --     -- Update this to ensure that you have the debuggers for the langs you want
    --     'js',
    --   },
    -- }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     enabled = true,
    --     element = 'repl',
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    --   mappings = {
    --     expand = { '<CR>', '<2-LeftMouse>' },
    --     open = 'o',
    --     remove = 'd',
    --     edit = 'e',
    --     repl = 'r',
    --     toggle = 't',
    --   },
    --   elements = {
    --     -- Provide the elements you want to see in the UI.
    --     -- For more information, see |:help nvim-dap-ui-elements|
    --     scopes = { expanded = true, icons = false },
    --     breakpoints = { expanded = true, icons = false },
    --     stack_trace = { expanded = true, icons = false },
    --     variables = { expanded = true, icons = false },
    --     watch = { expanded = true, icons = false },
    --   },
    --   element_mappings = {
    --     -- Provide the mappings for the elements you want to see in the UI.
    --     -- For more information, see |:help nvim-dap-ui-element-mappings|
    --     scopes = {
    --       expand = { '<CR>', '<2-LeftMouse>' },
    --       collapse = { '<BS>' },
    --       edit = 'e',
    --       remove = 'd',
    --     },
    --     breakpoints = {
    --       toggle = 't',
    --       edit = 'e',
    --       remove = 'd',
    --     },
    --     stack_trace = {
    --       expand = { '<CR>', '<2-LeftMouse>' },
    --       collapse = { '<BS>' },
    --       edit = 'e',
    --       remove = 'd',
    --     },
    --     variables = {
    --       expand = { '<CR>', '<2-LeftMouse>' },
    --       collapse = { '<BS>' },
    --       edit = 'e',
    --       remove = 'd',
    --     },
    --   },
    --   expand_lines = true, -- Whether to use the expanded lines for the elements
    --   force_buffers = false, -- Whether to force the buffers to be used for the elements
    --   layouts = {
    --     {
    --       elements = { 'scopes', 'breakpoints', 'stack_trace' },
    --       size = 0.25, -- 25% of the screen height
    --       position = 'left', -- Position of the layout
    --     },
    --     {
    --       elements = { 'variables', 'watch' },
    --       size = 0.25, -- 25% of the screen height
    --       position = 'right', -- Position of the layout
    --     },
    --     {
    --       elements = { 'repl' },
    --       size = 0.25, -- 25% of the screen height
    --       position = 'bottom', -- Position of the layout
    --     },
    --   },
    --   floating = {
    --     max_height = nil, -- Maximum height of the floating window
    --     max_width = nil, -- Maximum width of the floating window
    --     border = 'single', -- Border style of the floating window
    --     mappings = {
    --       close = { 'q', '<Esc>' }, -- Mappings to close the floating window
    --     },
    --   },
    --   render = {
    --     indent = 1, -- Indentation level for the elements
    --     max_value_lines = 100, -- Maximum number of lines to render for a value
    --   },
    -- }
    --
    -- -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end
    --
    -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

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
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
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
