return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- global picker defaults (explorer)
      opts.picker = opts.picker or {}
      opts.picker.hidden = true
      opts.picker.ignored = true

      -- file picker (<leader><leader>)
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.files = opts.picker.sources.files or {}
      opts.picker.sources.files.hidden = true
      opts.picker.sources.files.ignored = true
    end,
  },
}
