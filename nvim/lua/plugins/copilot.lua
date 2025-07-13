return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true, -- optional: show ghost text while typing
      hide_during_completion = false, -- optional: hide ghost text when completion is active
      debounce = 75,
      keymap = {
      accept = "<M-CR>", -- use <M-CR> to accept the suggestion
      --   accept_word = false,
      --   accept_line = false,
      --   next = "<C-n>",
      --   prev = "<C-p>",
      --   dismiss = "<C-e>",
      },
    },
    panel = { enabled = false }, -- <- disables menu popup
  },
}

