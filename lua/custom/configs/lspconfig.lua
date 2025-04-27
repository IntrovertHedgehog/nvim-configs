local lspconfig = require "lspconfig"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local servers = {
  "quick_lint_js",
  "ts_ls",
  "texlab",
  -- "ruff",
  "css_variables",
  "cssls",
  "bashls",
  "jedi_language_server",
  "protols",
  "neocmake",
  "metals",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.pylsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = { "W391" },
--           maxLineLength = 100,
--         },
--       },
--     },
--   },
-- }

lspconfig.jdtls.setup {
  cmd = { "jdtls" },
  cmd_env = { JAVA_HOME = "/usr/lib/jvm/java-21-openjdk" },
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--offset-encoding=utf-16",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
}
