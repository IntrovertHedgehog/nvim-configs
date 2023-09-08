local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  lint.shellcheck,
  -- lint.eslint_d.with {
  --   diagnostics_format = "[eslint] #{m}\n(#{c})",
  -- },
  formatting.prettier,
  formatting.stylua,
  formatting.ruff,
  formatting.isort,
  formatting.black,
  formatting.google_java_format,
  formatting.latexindent,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
