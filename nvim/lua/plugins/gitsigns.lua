return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  opts = {
    current_line_blame = true,
    -- Optional: reduce false positives due to EOL
    -- _extmark_signs = false,
    -- _signs_staged_enable = false,
    -- Optional: specify git binary if you’ve aliased it to ignore EOL
    -- git_cmd = { "git", "-c", "core.autocrlf=input" },
  }
}
