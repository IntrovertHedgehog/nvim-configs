local lspconfig = require "lspconfig"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local servers = { "quick_lint_js", "tsserver", "texlab" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 100,
        },
      },
    },
  },
}

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function()
    return vim.fs.dirname(vim.fs.find({
      "build.xml",
      "pom.xml",
      "settings.gradle",
      "settings.gradle.kts",
      "build.gradle",
      "build.gradle.kts",
      ".git",
    }, { upward = true })[1])
  end,
}
