local opt = vim.opt

opt.number = true
opt.scrolloff = 5
opt.relativenumber = true
opt.guicursor = "i:blinkwait700-blinkoff400-blinkon250"
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.exrc = true

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

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  pattern = "*",
  command = "normal zR",
})
