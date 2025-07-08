
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local function eol()
      local fmt = vim.bo.fileformat
      return fmt:upper()
    end

    -- Insert `eol` into an existing section like lualine_x
    table.insert(opts.sections.lualine_x, eol)
  end,
}
