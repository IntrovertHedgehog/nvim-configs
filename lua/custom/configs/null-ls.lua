local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,
  lint.shellcheck,
  lint.eslint_d.with {
    diagnostics_format = "[eslint] #{m}\n(#{c})",
  },
  formatting.ruff,
  formatting.isort,
  formatting.black,
  formatting.google_java_format,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
