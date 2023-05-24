local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,
  lint.shellcheck,
  -- lint.eslint_d.with {
  --   diagnostics_format = "[eslint] #{m}\n(#{c})",
  -- },
  lint.pylint.with {
    diagnostics_postprocess = function(diagnostic)
      diagnostic.code = diagnostic.message_id
    end,
  },
  formatting.isort,
  formatting.black,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
