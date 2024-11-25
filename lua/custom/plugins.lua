local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
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
        -- latex
        "texlab",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    init = function()
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
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "java",
        "markdown_inline",
        "markdown",
        "python",
        "bash",
        "regex",
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return {
        default = true,
        strict = true,
        override = require "nvchad.icons.devicons", 
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore",
          },
        },
      }
    end,
  },
  {
    "tpope/vim-obsession",
    lazy = false,
    cmd = { "Obsession" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local default = require "plugins.configs.nvimtree"
      local custom = require "custom.configs.nvimtree"
      return vim.tbl_deep_extend("force", default, custom)
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(_, opts)
      local Rule = require "nvim-autopairs.rule"
      local npairs = require "nvim-autopairs"
      npairs.setup(opts)

      npairs.add_rule(Rule("$$", "$$", "tex"))

      -- you can use some built-in conditions

      local cond = require "nvim-autopairs.conds"

      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "custom.configs.harpoon"
    end,
    lazy = false
  },
  {
    "tpope/vim-fugitive",
    branch = "master",
    lazy = false
  }
}

return plugins
