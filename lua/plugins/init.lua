return {

    -- "tpope/vim-fugitive",
    -- "vim-scripts/a.vim",
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        opts = {
          -- See `:help gitsigns.txt`
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
          on_attach = function(bufnr)
          local gitsigns = require('gitsigns')
          -- vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
          -- vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
          -- vim.keymap.set('n', '<leader>ph', gitsigns.preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
          --   -- Actions
          -- vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
          -- vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
          -- vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          -- vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          -- vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer)
          -- vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk)
          -- vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)
          -- vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk)
          vim.keymap.set('n', '<S-X>', function() gitsigns.blame_line{full=true} end)
          vim.keymap.set('n', '<S-B>', gitsigns.toggle_current_line_blame)
          vim.keymap.set('n', '<S-T>', gitsigns.diffthis)
          vim.keymap.set('n', '<S-H>', function() gitsigns.diffthis('~') end)
          vim.keymap.set('n', '<S-D>', gitsigns.toggle_deleted)
          vim.keymap.set('n', '<S-G>', gitsigns.blame)
          vim.keymap.set('n', '<S-L>', gitsigns.blame_line)
        -- Text object
          -- vim.keymap.set({'o', 'x'}, 'ih', ':<S-U>Gitsigns select_hunk<CR>')
          end,
        },
    },
    {
      'FabijanZulj/blame.nvim',
        event = "VeryLazy",
        opts = {
            blame_options = { '-w' },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
          -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
          -- setting the keybinding for LazyGit with 'keys' is recommended in
          -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
            { "<leader>lgl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit" }
        }
    },
-------------------------------------------------------------------------------------
    {
       "mfussenegger/nvim-dap",
    },

    {
        "nvim-neotest/nvim-nio",
    },

    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function (_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end
    },

    {   "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function ()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function ()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end
        end
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "folke/neodev.nvim", opts = {}
    },
-------------------------------------------------------------------------------------

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "stevearc/qf_helper.nvim",
        event = "VeryLazy",
        config = function()
            -- require("qf_helper").setup()
            require("qf_helper").setup({
              prefer_loclist = true,       -- Used for QNext/QPrev (see Commands below)
              sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
              quickfix = {
                autoclose = true,          -- Autoclose qf if it's the only open window
                default_bindings = true,   -- Set up recommended bindings in qf window
                default_options = true,    -- Set recommended buffer and window options
                max_height = 10,           -- Max qf height when using open() or toggle()
                min_height = 1,            -- Min qf height when using open() or toggle()
                track_location = true,     -- Keep qf updated with your current location
              },
              loclist = {                  -- The same options, but for the loclist
                autoclose = true,
                default_bindings = true,
                default_options = true,
                max_height = 10,
                min_height = 1,
                track_location = true,
               },
            })
        end,
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "simrat39/symbols-outline.nvim",
        opts = {
          highlight_hovered_item = true,
          show_guides = true,
          auto_preview = false,
          position = 'right',
          relative_width = true,
          width = 25,
          auto_close = false,
          show_numbers = false,
          show_relative_numbers = false,
          show_symbol_details = true,
          preview_bg_highlight = 'Pmenu',
          autofold_depth = nil,
          auto_unfold_hover = true,
          fold_markers = { '', '' },
          wrap = false,
          keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {"<Esc>", "q"},
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "h",
            unfold = "l",
            fold_all = "W",
            unfold_all = "E",
            fold_reset = "R",
          },
          lsp_blacklist = {},
          symbol_blacklist = {},
          symbols = {
            File = { icon = "", hl = "@text.uri" },
            Module = { icon = "", hl = "@namespace" },
            Namespace = { icon = "", hl = "@namespace" },
            Package = { icon = "", hl = "@namespace" },
            Class = { icon = "", hl = "@type" },
            Method = { icon = "ƒ", hl = "@method" },
            Property = { icon = "", hl = "@method" },
            Field = { icon = "", hl = "@field" },
            Constructor = { icon = "", hl = "@constructor" },
            Enum = { icon = "ℰ", hl = "@type" },
            Interface = { icon = "ﰮ", hl = "@type" },
            Function = { icon = "", hl = "@function" },
            Variable = { icon = "", hl = "@constant" },
            Constant = { icon = "", hl = "@constant" },
            String = { icon = "", hl = "@string" },
            Number = { icon = "#", hl = "@number" },
            Boolean = { icon = "⊨", hl = "@boolean" },
            Array = { icon = "", hl = "@constant" },
            Object = { icon = "⦿", hl = "@type" },
            Key = { icon = "", hl = "@type" },
            Null = { icon = "NULL", hl = "@type" },
            EnumMember = { icon = "", hl = "@field" },
            Struct = { icon = "", hl = "@type" },
            Event = { icon = "", hl = "@type" },
            Operator = { icon = "+", hl = "@operator" },
            TypeParameter = { icon = "", hl = "@parameter" },
            Component = { icon = "", hl = "@function" },
            Fragment = { icon = "", hl = "@constant" },
          },
        },
        event = "VeryLazy",
        config = function()
            require("symbols-outline").setup(opts)
        end,
    },


        -- {
        -- Another cloloscheme
    {
        "EdenEast/nightfox.nvim",
         event = 'VimEnter', -- if you want lazy load, see below
        -- event = "VeryLazy",
    },
    -- {
    --     "folke/trouble.nvim",
    --     opts = {}, -- for default options, refer to the configuration section for custom setup.
    --     event = "VeryLazy",
    --     cmd = "Trouble",
    --     keys = {
    --        {
    --           "<leader>xx",
    --           "<cmd>Trouble diagnostics toggle<cr>",
    --           desc = "Diagnostics (Trouble)",
    --         },
    --         {
    --           "<leader>xX",
    --           "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    --           desc = "Buffer Diagnostics (Trouble)",
    --         },
    --         {
    --           "<leader>cs",
    --           "<cmd>Trouble symbols toggle focus=false<cr>",
    --           desc = "Symbols (Trouble)",
  --         },
    --         {
    --           "<leader>cl",
    --           "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --           desc = "LSP Definitions / references / ... (Trouble)",
    --         },
    --         {
    --           "<leader>xL",
    --           "<cmd>Trouble loclist toggle<cr>",
    --           desc = "Location List (Trouble)",
    --         },
    --         {
    --           "<leader>xQ",
    --           "<cmd>Trouble qflist toggle<cr>",
    --           desc = "Quickfix List (Trouble)",
    --         },
    --     },
    -- }
}
