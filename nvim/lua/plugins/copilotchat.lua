return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = function(_, opts)
    local select = require("CopilotChat.select")

    opts.prompts = opts.prompts or {}

    opts.prompts.CopilotChatTests = {
      prompt = "Write unit tests for the given code.",
      description = "Generate tests for selected code or the whole file",
      -- selection = function(source)
      --   -- Get visual selection if available
      --   local sel = select.selection(source, "visual")
      --   if sel and sel:match("%S") then -- not nil and not only whitespace
      --     return sel
      --   end
      --
      --   -- Otherwise, use the entire buffer
      --   local buf = select.selection(source, "buffer")
      --   if buf and buf:match("%S") then
      --     return buf
      --   end
      --
      --   -- Absolute fallback: dummy string so CopilotChat never asks
      --   return "-- No code found in buffer"
      -- end,
    }

    return opts
  end,
}

