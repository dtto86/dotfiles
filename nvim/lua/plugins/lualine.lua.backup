
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local function eol()
      local fmt = vim.bo.fileformat
      if fmt == "unix" then
        return "LF"
      elseif fmt == "dos" then
        return "CRLF"
      elseif fmt == "mac" then
        return "CR"
      else
        return fmt
      end
      -- return fmt:upper()
    end

    -- Insert `eol` into an existing section like lualine_x
    table.insert(opts.sections.lualine_x, eol)
  end,
}
