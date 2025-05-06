-- @{ lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'diff', 'diagnostics'},
    lualine_b = {},
    lualine_c = {{'filename', path=3}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
-- @}

-- @{ fugitive
vim.keymap.set(
    "n",
    "<Leader>gs",
    vim.cmd.Git,
    {desc = "open git status window"}
)
-- add my git graph alias for fugitive
vim.keymap.set(
    "n",
    "<Leader>gg",
    function()
        vim.cmd.Git(
            "log --graph --oneline --decorate --format='%C(yellow)%h%C(reset)"
            .. " %C(bold magenta)%al %C(reset)%C(magenta)%as "
            .. "%C(blue)%m%C(auto) %s %d'"
        )
    end,
    {desc = "open git graph view in fugitive"}
)
vim.keymap.set(
    "n",
    "<Leader>gG",
    function()
        vim.cmd.Git(
            "log --graph --oneline --decorate --format='%C(yellow)%h%C(reset)"
            .. " %C(bold magenta)%al %C(reset)%C(magenta)%as "
            .. "%C(blue)%m%C(auto) %s %d' --all"
        )
    end,
    {desc = "open git graph view with --all option in fugitive"}
)
-- @}

-- @{ Telescope
require("telescope").setup {
  defaults = {
      path_display={"smart"},
  },
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
    },
  },
}

-- old files (most commonly used)
function MRU_Func()
    -- this ensures that oldfiles is up to date, if another vim session has
    -- written to it since the last time this one looked.
    -- vim.cmd([[:rshada]])
    -- was using frecency... but I think oldfiles might just be a better fit
    -- vim.cmd.Telescope("oldfiles")
    require('telescope').extensions['recent_files'].pick()
end
vim.keymap.set(
    "n",
    "<Leader>r",
    MRU_Func,
    {noremap=true, desc="open recent file picker in telescope"}
)
-- resume the last search
vim.keymap.set(
    "n",
    "<Leader>R",
    function()
        vim.cmd.Telescope("resume")
    end,
    {noremap=true, desc="open last telescope search"}
)
-- local files
function FindFiles_Func(search_from_project_root)
    local builtin = require("telescope.builtin")
    local utils = require("telescope.utils")

    local root = utils.buffer_dir()

    if (search_from_project_root) then
        root = string.gsub(vim.fn.system(
        "git rev-parse --show-toplevel"),
        "\n",
        ""
        )
        if vim.v.shell_error == 1 then
            root = "."
        end
    end
    builtin.find_files({cwd = root})
end
vim.keymap.set(
    "n",
    "<Leader>.",
    FindFiles_Func,
    {noremap=true, desc="open filename search from CWD in telescope"}
)
vim.keymap.set(
    "n",
    "<Leader>,",
    function()
        FindFiles_Func(true)
    end,
    {noremap=true, desc="open filename search from project root w/ telescope"}
)

vim.keymap.set(
    "n",
    "<Leader>d",
    function()
        vim.cmd.Telescope("diagnostics")
    end,
    {noremap=true, desc="open diagnostics"}
)
vim.keymap.set(
    "n",
    "<Leader>t",
    function()
        vim.cmd.Telescope("lsp_document_symbols")
    end,
    {noremap=true, desc="open outline view"}
)
vim.keymap.set(
    "n",
    "<Leader>G",
    function()
        vim.cmd.Telescope("git_files")
    end,
    {noremap=true, desc="git files search"}
)
function TeleBuffers()
    local builtin = require("telescope.builtin")
    builtin.buffers({sort_mru=true})
end
vim.keymap.set(
    "n",
    "<Leader>B",
    TeleBuffers,
    {noremap=true, desc="open buffers in telescope"}
)

-- @{ treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"wgsl"},
    indent = {
        -- excited about this for the future, but for now, it seems to make 8 
        -- space indents in C++, so I'm skipping it
        enable = false,
    }
}
-- @}

-- marks
vim.keymap.set(
    "n",
    "<Leader>m",
    function()
        vim.cmd.Telescope("marks")
    end,
    {noremap=true, desc="open marks in telescope"}
)

-- @{ search in the quadplay manual
function QuadplayManualLookup()
    local search_phrase = '^`' .. vim.fn.expand('<cword>') .. '(.*)`$'
    local manual_page = vim.fn.expand(
        "~/Documents/workspace/quadplay/doc/manual.md.html"
    )
    require('telescope.builtin').grep_string(
        {
            search=search_phrase,
            search_dirs={manual_page},
            use_regex=true,
            path_display="hidden",
            initial_mode="normal",
        }
    )
end
vim.keymap.set(
    'n',
    '<Leader>M',
    QuadplayManualLookup,
    {noremap=true, desc="look up word in quadplay manual"}
)
-- @}

-- search for the current word in local files
vim.keymap.set(
    "n",
    "<Leader>S",
    function()
        vim.cmd.Telescope("grep_string")
    end,
    {noremap=true, desc="Search for the word under the cursor in files"}
)
-- search for any word in local files
function FindString_Func(search_project)
    local root = "."
    if (search_project) then
        root = string.gsub(vim.fn.system(
        "git rev-parse --show-toplevel"),
        "\n",
        ""
        )
        if vim.v.shell_error == 1 then
            root = "."
        end
    end
    require('telescope.builtin').live_grep(
        {
            cwd=root,
        }
    )
end
vim.keymap.set(
    "n",
    "<Leader>/",
    FindString_Func,
    {noremap=true, desc="start an interactive string search" }
)
vim.keymap.set(
    "n",
    "<Leader>;",
    function()
        FindFiles_Func(true)
    end,
    {
        noremap=true,
        desc="start an interactive string search rooted at the project root",
    }
)

require('telescope').setup{
	defaults = {
        layout_strategy="flex",
		mappings = {
			i = {
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-h>"] = "which_key"
			}
		},
        path_display = { "truncate", },
	},
}
-- @}

-- @{ treesitter
require('nvim-treesitter.configs').setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "c",
        "cpp",
        "python",
        "toml",
        "zig",
        "yaml",
        "jsonc",
        "lua"
    },
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the
        -- same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for
        -- indentation). Using this option may slow down your editor, and you
        -- may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
-- @}

-- @{ Settings for the built in comment system
-- manual commentstring switching for pyxlscript (Treesitter someday...)
vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter"},
    {
        pattern = {"*.pyxl"}, callback = function(_)
            vim.opt_local.commentstring = "// %s"
        end
    }
)
vim.keymap.set(
    { "n", "v" },
    "<Leader>c",
    "gc",
    { desc = "toggle comment", remap = true }
)
-- @}

-- @{  LSP Configurations (define LSPs using lspconfig plugin) 
--     LSP programs themselves need to be externally installed/managed (IE 
--     through conda)
require('lspconfig').pyright.setup{}
require('lspconfig').zls.setup{}
require('lspconfig').clangd.setup{}
require('lspconfig').lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if (
          path ~= vim.fn.stdpath('config')
          and (vim.loop.fs_stat(path..'/.luarc.json')
          or vim.loop.fs_stat(path..'/.luarc.jsonc'))
      ) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend(
        'force',
        client.config.settings.Lua,
        {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                }
            }
        }
    )
  end,
  settings = {
    Lua = { telemetry = false },
  }
}
-- @}


-- @{ zig
-- do not run zig fmt when I save my buffer
vim.g.zig_fmt_autosave = 0
-- @}

-- @{ beacon
vim.g.beacon_minimal_jump = 2
-- @}

-- @{ vim-cmake
vim.g.cmake_default_config = 'build'
vim.g.cmake_build_options = {'-j 9'}
-- close the window on a succesful build
local cmake_build_success_grp = vim.api.nvim_create_augroup("cmake_build", {})
vim.api.nvim_create_autocmd(
    "User",
    {
        pattern = "CMakeBuildSucceeded",
        callback = vim.cmd.CMakeClose,
        group = cmake_build_success_grp,
    }
)

-- open telescope quickfix and close cmake on build fail
function on_cmake_fail()
    vim.cmd.CMakeClose()
    vim.cmd.Telescope("quickfix")
end
local cmake_build_fail_grp = vim.api.nvim_create_augroup("cmake_build_fail", {})
vim.api.nvim_create_autocmd(
    "User",
    {
        pattern = "CMakeBuildFailed",
        callback = on_cmake_fail,
        group = cmake_build_fail_grp,
    }
)
-- @}

-- @{ Markview
require("markview").setup(
    {
        preview = {
            icon_provider = "devicons", -- "mini" or "devicons"
        }
    }
)
-- @} Markview
