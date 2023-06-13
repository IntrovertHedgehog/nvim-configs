local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "lua-language-server",
        "stylua",
        -- javascript
        "prettier",
        "eslint_d",
        "quick-lint-js",
        "typescript-language-server",
        -- python
        "ruff",
        "isort",
        "black",
        -- java
        "google-java-format",
        "jdtls",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    init = function ()
      require("core.utils").lazy_load "nvim-ts-autotag"
    end,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
    },
  },
  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require "custom.configs.prettier"
    end,
    ft = {
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "scss",
      "less",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        api.config.mappings.default_on_attach(bufnr)
        -- start custom mappings
        vim.keymap.set("n", "]m", api.marks.navigate.next)
        vim.keymap.set("n", "[m", api.marks.navigate.prev)
        vim.keymap.set("n", "'m", api.marks.navigate.select)
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "markdown",
        "markdown_inline",
        "json",
        "html",
        "css",
        "tsx",
        "javascript",
        "typescript",
        "python",
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   init = function ()
  --     require("core.utils").lazy_load "nvim-jdtls"
  --   end,
  --   opts = {
  --     cmd = { "/home/linuxbrew/.linuxbrew/bin/jdtls" },
  --     root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  --   },
  --   config = function(_, opts)
  --     require("jdtls").start_or_attach(opts)
  --   end,
  -- },
}

return plugins
