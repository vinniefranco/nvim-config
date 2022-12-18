function SetColorscheme(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", { guibg = NONE, ctermbg = NONE })
  vim.api.nvim_set_hl(0, "NormalFloat", { guibg = NONE, ctermbg = NONE })
  vim.api.nvim_set_hl(0, "NonText", { ctermbg = NONE })
end

SetColorscheme()
