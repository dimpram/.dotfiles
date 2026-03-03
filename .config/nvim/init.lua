-- ==============================================================================
-- 1. BASIC SETTINGS
-- ==============================================================================
vim.g.mapleader = " " -- Set leader key to Space
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4 -- Go standard is 4 spaces (tabs)
vim.opt.shiftwidth = 4
vim.opt.expandtab = false -- Go uses actual tabs, not spaces
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50

-- ==============================================================================
-- 2. BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- ==============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==============================================================================
-- 3. PLUGIN CONFIGURATION
-- ==============================================================================
require("lazy").setup({
  -- Telescope: Fuzzy Finder for files, text, and more
  {
    "nvim-telescope/telescope.nvim",
	branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- This makes Telescope incredibly fast
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "vendor/", -- Ignore Go vendor folder
          },
        },
      })

      -- Load the fzf extension for faster sorting
      telescope.load_extension("fzf")

      -- Keybindings (Space + f + something)
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep (Search Code)" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Open Buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help" })
    end,
  },

  -- File Explorer Sidebar
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Adds beautiful icons
    },
    config = function()
      -- Neovim recommends disabling the built-in netrw when using nvim-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left", -- You can change this to "right" if you prefer
        },
        renderer = {
          group_empty = true, -- Groups empty folders together
        },
        filters = {
          dotfiles = false, -- Set to true to hide hidden files like .git
        },
      })

      -- Keybinding to quickly open/close the sidebar (Space + e)
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- Core LSP and Tool Installation (Mason)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Ensure the Go language server and a JS/TS server are installed
        ensure_installed = { "gopls", "ts_ls" },
      })
    end,
  },

  -- LSP Configuration (Neovim 0.11+ Native API)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Golang setup (gopls)
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true, 
          },
        },
      })
      vim.lsp.enable("gopls")

      -- JS/TS setup (ts_ls)
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable("ts_ls")
      
      -- Modern best practice: Set up keymaps ONLY when an LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })
    end,
  },

  -- Conform.nvim: The modern formatting engine
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- Run goimports first to organize imports, then gofumpt for formatting
          go = { "goimports", "gofumpt" },
          -- Use prettier for all web/config files
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
        },
        -- Automatically format on save
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), 
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- Treesitter for Better Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
	lazy = false,
    opts = {
      ensure_installed = { 
        "go", "gomod", "gowork", "gosum", 
        "javascript", "typescript", "json", "yaml", "html", "css", "markdown", "lua" 
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  -- Colorscheme (Catppuccin)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
})
