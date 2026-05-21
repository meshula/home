local result = {
    -- git plugin
    {
        'tpope/vim-fugitive',
        cmd="Git",
        event="VeryLazy",
    },

    -- put diff markers in the gutter
    {
        "mhinz/vim-signify",
        event = "VeryLazy",
        lazy = false,
    },

    -- see buffers when typing " or @
    {
        'junegunn/vim-peekaboo',
        event = "VeryLazy",
    },

    -- colorscheme
    {
        'EdenEast/nightfox.nvim',
    },

    -- throwing a bunch extra in here for the plane/readability in case it
    -- helps

    -- like this light color theme but I prefer nightfox for dark
    -- the latte variant is the light one
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- { "shaunsingh/nord.nvim" },
    -- { "Mofiqul/dracula.nvim" },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },
    -- {'mhartington/oceanic-next' }, -- also nice, but I'm enjoying nightfox

    -- tmux integration
    {
        'christoomey/vim-tmux-navigator',
        event = "VeryLazy",
    },
    {
        'edkolev/tmuxline.vim',
        event = "VeryLazy",
        config = function()
            vim.g.tmuxline_preset = 'nightly_fox'
            vim.g.tmuxline_preset = {
                a    = '#S',
                win  = {'#I', '#W'},
                cwin = {'#I', '#W', '#F'},
                y    = {'%R'},
                z    = '#H'
            }
            vim.g.tmuxline_powerline_separators = 1
        end,
    },

    -- fancy status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'echasnovski/mini.icons',
        },
        event="VeryLazy",
    },

    -- highlight the cursor when you move between windows
    {
        'DanilaMihailov/beacon.nvim',
        event = "VeryLazy",
    },

    {
        'nvim-lua/plenary.nvim',
    },

    -- picker/fuzzy finder
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- modules I'm definitely using

            -- handle big files better
            bigfile = { enabled = true },
            -- an alternate input box, with a normal mode importantly
            -- when using the lsp.rename functionality, this pops up a little
            -- box where you can go into normal mode to more easily edit the
            -- new name
            input = { enabled = true },
            -- the plugin I Actually want from this -- fuzzy searcher picker
            picker = { enabled = true },
            quickfile = { enabled = true },
            -- Scope detection, text objects and jumping based on treesitter or 
            -- indent
            scope = { enabled = true },
            -- Auto-show LSP references and quickly navigate between them
            words = { enabled = true },

            -- disabled modules

            -- file explorer plugin
            -- check what these options do on the snacks github
            explorer = { enabled = true, 
               hidden=true, git_untracked=true, ignored=true },

            -- landing page when you boot nvim (rather than a blank page)
            dashboard = { enabled = false },
            -- indent indicators.  visually distracting but might be
            -- useful for python?  Might want to sit on this one
            indent = { enabled = false },
            -- "toast" style notifier
            notifier = { enabled = false },
            -- smooth scrolling
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            toggle = { enabled = true },
        },
        keys = {
            -- {"<Leader>r", function() Snacks.picker() end, desc=""},
        },
    },

    -- python-indent
    {
        'Vimjas/vim-python-pep8-indent',
        event = "VeryLazy",
    },

    -- tree sitter built in advanced syntax stuff
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {},
        event="VeryLazy",
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = "VeryLazy",
    },

    -- zig
    {
        'ziglang/zig.vim',
    },

    -- completion/LSP stuff
    {
        'saghen/blink.cmp',
        event="VeryLazy",

        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        opts = {
            -- Keymap preset
            -- 'enter' for enter to accept
            -- 
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },

            -- show the documentation popup when manually triggered
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                menu = { border = 'single' },
                documentation = {
                    auto_show = true ,
                    window = { border = 'single' },
                },
            },
            signature = {
                window = { border = 'single' },
                enabled = true,
            },

            -- (Default) Rust fuzzy matcher for typo resistance and
            -- significantly better performance You may use a lua
            -- implementation instead by using `implementation = "lua"` or
            -- fallback to the lua implementation, when the Rust fuzzy matcher
            -- is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "lua" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },

    -- "dap" plugins (Debugger adapter protocol)
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
    },
    {
        -- dap virtual text (show variable values inline)
        'theHamsta/nvim-dap-virtual-text',
    },
    {
        -- ui for dap stuff
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function() require("dapui").setup() end,
        event = "VeryLazy",
    },

    -- "surround" gestures (changing types of quotes/parenthesis)
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },

    -- cmake
    {
        "cdelledonne/vim-cmake",
        lazy = true,
        cmd = {"CMakeBuild",},
    },

    -- for diagnostics 
    {
        "folke/trouble.nvim",
        opts = {
            auto_show = true,
        },
        cmd = "Trouble",
        keys = {
            {"<Leader>x", group="Trouble (LSP Diagnostics)"},
            {
                "<leader>xx",
                function()
                    vim.cmd.Trouble("diagnostics toggle")
                end,
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                function()
                    vim.cmd.Trouble("diagnostics toggle filter.buf=0")
                end,
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>ts",
                function()
                    vim.cmd.Trouble("symbols toggle focus=false")
                end,
                desc = "Symbols Outline (Trouble)",
            },
            {
                "<leader>tl",
                function()
                    vim.cmd.Trouble("lsp toggle focus=false win.position=right")
                end,
                desc = "LSP Definitions / references / ... Outline (Trouble)",
            },
            {
                "<leader>xL",
                function()
                    vim.cmd.Trouble("loclist toggle")
                end,
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                function()
                    vim.cmd.Trouble("qflist toggle")
                end,
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        opts = {
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 250,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = true,
                -- If you are using a Nerd Font: set icons.keys to an empty
                -- table which will use the default which-key.nvim defined Nerd
                -- Font icons, otherwise define a string table
                keys = {},
                rules = {
                    -- Propagating "Telescope" patterns to Picker stuff
                    { pattern = "picker", icon = "", color = "orange" },
                    { pattern = "swap", icon = "󰯎", color = "yellow" },
                },
            },
        },
    },
}

if vim.env.OS == "WSL" then
    table.insert(result,{ 'OmniSharp/omnisharp-vim' })
end


return result
