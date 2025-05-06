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
        lazy = false,
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nightfox').setup({})

            -- Load the colorscheme here.
            vim.cmd.colorscheme('nightfox')
        end,
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
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    -- highlight the cursor when you move between windows
    {
        'DanilaMihailov/beacon.nvim',
        event = "VeryLazy",
    },

    -- fuzzy finder / telescope.nvim + plugins
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = {"Telescope",},
        dependencies = {
            'nvim-lua/plenary.nvim',
            "smartpde/telescope-recent-files"
        }
    },

    {
	    "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        cmd = {"Telescope",},
	    config = function()
		    -- To get telescope-file-browser loaded and working with telescope,
		    -- you need to call load_extension, somewhere after setup function:
		    require("telescope").load_extension("file_browser")
		    require("telescope").load_extension("recent_files")
	    end,
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
        event = "VeryLazy",
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

        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
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

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "lua" },
            -- fuzzy = { implementation = "prefer_rust_with_warning" }
            -- fuzzy.prebuilt_binaries.force_version

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },

        opts_extend = { "sources.default" }
    },

    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
    },

    -- "surround" gestures (changing types of quotes/parenthesis)
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },

    -- markdown rendering
	{
		"OXY2DEV/markview.nvim",
        lazy = false,
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
        lazy = false,
        opts = {},
        cmd = "Trouble",
        keys = {
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
                "<leader>cs",
                function()
                    vim.cmd.Trouble("symbols toggle focus=false")
                end,
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                function()
                    vim.cmd.Trouble("lsp toggle focus=false win.position=right")
                end,
                desc = "LSP Definitions / references / ... (Trouble)",
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
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = {},
            },
        },
    },
}

if vim.env.OS == "WSL" then
    table.insert(result,{ 'OmniSharp/omnisharp-vim' })
end

-- quadplay tooling
local pyxldir = (
    vim.env["HOME"] .. "/workspace/quadplay/tools/vim-pyxlscript-syntax"
)
-- pyxlscript (quadplay scripting language)
if vim.fn.isdirectory(pyxldir) then
   -- table.insert(result, { dir=pyxldir })
end

return result
