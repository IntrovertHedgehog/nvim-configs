local function init()
  vim.g.vimtex_view_general_viewer = "okular"
  vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
  -- vim.g.maplocalleader = "\"
end

return init
