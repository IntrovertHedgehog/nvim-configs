local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim", "gbprod/none-ls-shellcheck.nvim", "gbprod/none-ls-luacheck.nvim" },
    config = function()
      require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { { "nvimtools/none-ls.nvim" } },
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
        "prettierd",
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
  -- {
  --   "MunifTanjim/prettier.nvim",
  --   config = function()
  --     require "custom.configs.prettier"
  --   end,
  --   ft = {
  --     "css",
  --     "graphql",
  --     "html",
  --     "javascript",
  --     "javascriptreact",
  --     "json",
  --     "less",
  --     "markdown",
  --     "scss",
  --     "typescript",
  --     "typescriptreact",
  --     "yaml",
  --   },
  -- },
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
      highlight = {
        enable = true,
        disable = { "latex" },
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
    lazy = true,
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
    -- not lazy cuz on loading file the marked
    -- files marked from last session is saved
    lazy = false,
  },
  {
    "tpope/vim-fugitive",
    branch = "master",
    lazy = true,
    cmd = { "G", "Git", "Gdiffsplit", "Gedit", "Gread", "Gwrite", "Grep", "GMove", "GDelete", "GBrowse" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local default = require "plugins.configs.telescope"
      local custom = require "custom.configs.telescope"
      local merged = vim.tbl_deep_extend("force", default, custom)
      return merged
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- VimTex is already lazy loaded mostly
    config = function()
      require "custom.configs.vimtex" ()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.nvim-dap"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    ft = require "custom.variables.dap_ft",
    init = function()
      require("core.utils").load_mappings "dap"
    end,
    config = function()
      require "custom.configs.nvim-dap-ui"
    end,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = require "custom.variables.dap_ft",
    init = function()
      require("core.utils").load_mappings "persistent_breakpoints"
    end,
    config = function()
      require("persistent-breakpoints").setup {
        save_dir = vim.fn.stdpath "data" .. "/nvim_checkpoints",
        -- when to load the breakpoints? "BufReadPost" is recommanded.
        load_breakpoints_event = { "BufReadPost" },
        -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
        perf_record = false,
        -- perform callback when loading a persisted breakpoint
        --- @param opts DAPBreakpointOptions options used to create the breakpoint ({condition, logMessage, hitCondition})
        --- @param buf_id integer the buffer the breakpoint was set on
        --- @param line integer the line the breakpoint was set on
        on_load_breakpoint = nil,
      }
    end,
  },
  {
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope" },
      config = function()
        require("todo-comments").setup()
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
  },
  {"kevinhwang91/nvim-bqf",
  lazy = false}
}

return plugins
