local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.diagnostics.buf,
  null_ls.builtins.formatting.buf,
  require "none-ls.diagnostics.cpplint",
  null_ls.builtins.formatting.clang_format.with { extra_args = { "--style", "Google" } },
  -- require "none-ls.diagnostics.eslint_d",
  -- require "none-ls.formatting.eslint_d",
  null_ls.builtins.formatting.stylua,
  require "none-ls.diagnostics.ruff",
  require "none-ls.formatting.ruff",
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.google_java_format,
  require "none-ls-shellcheck.diagnostics",
}

null_ls.setup {
  debug = true,
  sources = sources,
}
