local opt = vim.opt

opt.number = true
opt.scrolloff = 5
opt.relativenumber = true
opt.guicursor = "i:ver30-blinkwait50-blinkoff50-blinkon100"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.exrc = true
opt.synmaxcol = 256

-- telescope open file in insert mode -> fold disable on opening (fix via issue 559)
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      command = "normal! zx zM zR",
    })
  end,
})

-- auto detect dockerfile-*
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "Dockerfile*",
  command = "setfiletype dockerfile"
})
