-- which-key makes a nice view to show what hotkeys are mapped to commands
local wk = require("which-key")
wk.add({ {"<Leader>w", vim.cmd.WhichKey, desc="Open Which-Key" }})

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
-- establish "g" as the prefix for git commands
wk.add( { {"<leader>g", group="git" } })
vim.keymap.set(
    "n",
    "<Leader>gd",
    vim.cmd.Gdiff,
    {desc = "open git diff for the current buffer"}
)
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

-- @{ Picker system (Currently: snacks.picker)
-- old files (most commonly used)
function MRU_Func()
    -- this ensures that oldfiles is up to date, if another vim session has
    -- written to it since the last time this one looked.
    -- vim.cmd([[:rshada]])
    Snacks.picker.recent()
end
vim.keymap.set(
    "n",
    "<Leader>r",
    MRU_Func,
    {noremap=true, desc="open recent file picker"}
)
-- resume the last search
vim.keymap.set(
    "n",
    "<Leader>R",
    function()
        ---@module 'snacks'
        Snacks.picker.resume()
    end,
    {noremap=true, desc="[R]esume last picker"}
)
-- local files
function FindFiles_Func(search_from_project_root)
    if (search_from_project_root) then
        local root = Snacks.git.get_root()
        return Snacks.picker.files({cwd = root })
    end
    Snacks.picker.files()
end
vim.keymap.set(
    "n",
    "<Leader>.",
    FindFiles_Func,
    {noremap=true, desc="open filename search from CWD in picker"}
)
vim.keymap.set(
    "n",
    "<Leader>,",
    function()
        FindFiles_Func(true)
    end,
    {noremap=true, desc="open filename search from project root w/ picker"}
)

vim.keymap.set(
    "n",
    "<Leader>D",
    function()
        Snacks.picker.diagnostics()
    end,
    {noremap=true, desc="open diagnostics in picker"}
)
wk.add({ "<leader>t", icon="", group="LSP Symbol Outliners" })
vim.keymap.set(
    "n",
    "<Leader>tt",
    function()
        Snacks.picker.lsp_symbols()
    end,
    {noremap=true, desc="open document symbols in picker (Outline)"}
)
wk.add({ {"<leader>j", icon="", group="jump with lsp"}})
vim.keymap.set(
    "n",
    "<Leader>jr",
    function()
        Snacks.picker.lsp_references()
    end,
    {noremap=true, desc="open references to symbol in picker"}
)
vim.keymap.set(
    "n",
    "<Leader>p",
    function()
       Snacks.picker()
    end,
    {noremap=true, desc="Open Snacks.picker list"}
)
vim.keymap.set(
    "n",
    "<Leader>B",
    function()
	    Snacks.picker.buffers()
    end,
    {noremap=true, desc="open buffers in picker"}
)
wk.add({ "<leader>w", icon="󰍍", group="Keymap Information" })
vim.keymap.set(
    "n",
    -- W so that leader>w opens which key and W opens picker 
    -- (good for searching) -- I've found they have different uses
    "<Leader>wW",
    Snacks.picker.keymaps,
    {noremap=true, desc="open keymappings in picker"}
)
vim.keymap.set(
    "n",
    "<Leader>ww",
    function() vim.cmd.WhichKey() end,
    {noremap=true, desc="open keymappings in WhichKey"}
)

-- @{ search in the quadplay manual
function QuadplayManualLookup()
    local search_phrase = '^`' .. vim.fn.expand('<cword>') .. '(.*)`$'
    local manual_page = vim.fn.expand(
        "~/Documents/workspace/quadplay/doc/manual.md.html"
    )
    Snacks.picker.grep_word(
        {
            dirs = {manual_page},
        }
    )

--  require('telescope.builtin').grep_string(
--      {
--          search=search_phrase,
--          search_dirs={manual_page},
--          use_regex=true,
--          path_display="hidden",
--          initial_mode="normal",
--      }
--  )
end
vim.keymap.set(
    'n',
    '<Leader>M',
    QuadplayManualLookup,
    {noremap=true, desc="open quadplay manual in picker and look up word"}
)
-- @}

-- search for the current word in local files
vim.keymap.set(
    "n",
    "<Leader>S",
    Snacks.picker.grep_word,
    {noremap=true, desc="Search for the word under the cursor in files"}
)
-- search for any word in local files
function FindString_Func(search_from_project_root)
    local root = "."
    if (search_from_project_root) then
        root = Snacks.git.get_root()
    end
    Snacks.picker.grep({cwd = root})
end
vim.keymap.set(
    "n",
    "<Leader>;",
    FindString_Func,
    {noremap=true, desc="interactive string search picker" }
)
vim.keymap.set(
    "n",
    "<Leader>/",
    function()
        FindString_Func(true)
    end,
    {
        noremap=true,
        desc="interactive string search rooted at the project root picker",
    }
)

-- @{ treesitter (main-branch API)
-- Install parsers (async; only fetches missing ones).
require('nvim-treesitter').install({
    "c",
    "cpp",
    "python",
    "toml",
    "zig",
    "yaml",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "wgsl",
})

-- The json parser handles JSON-with-comments fine; alias the jsonc filetype
-- to it so vim.treesitter.start() finds a parser on .jsonc buffers.
vim.treesitter.language.register("json", "jsonc")

-- Enable Tree-sitter highlighting per filetype. markdown_inline is injected
-- by the markdown parser, so it doesn't need its own filetype entry.
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "python",
        "toml",
        "zig",
        "yaml",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "wgsl",
    },
    callback = function() vim.treesitter.start() end,
})
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
wk.add({"<Leader>c", group="toggle comment"})
vim.keymap.set(
    { "n", "v" },
    "<Leader>cc",
    "gc",
    { desc = "toggle comment", remap = true }
)
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

-- open picker for quickfix and close cmake on build fail
local cmake_build_fail_grp = vim.api.nvim_create_augroup("cmake_build_fail", {})
vim.api.nvim_create_autocmd(
    "User",
    {
        pattern = "CMakeBuildFailed",
        callback = function()
            vim.cmd.CMakeClose()
            Snacks.picker.qflist()
        end,
        group = cmake_build_fail_grp,
    }
)
-- @}

-- @{ dap
local dap = require("dap")
dap.set_log_level('DEBUG')

dap.adapters.lldb = {
	type = "executable",
	command = "/Users/stephan/opt/miniconda3/envs/sdev/bin/lldb-dap",
	name = "lldb",
}

-- local pickers = require("telescope.pickers")
-- local finders = require("telescope.finders")
-- local conf = require("telescope.config").values
-- local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")

-- launch a "fire and forget" coroutine as described in the blog post above
-- coroutine.resume(
--     coroutine.create(
--         function()
--             local first = M.pick_file({
--                 { text = "Yes, launch missiles 🚀", display = "Yes, launch missiles 🚀" },
--                 { text = "No, don't launch missiles", display = "No, don't launch missiles" },
--             })
--             if not first or vim.startswith(first.text, "No") then
--                 return
--             end
--
--             local second = M.pick_sync({
--                 { text = "Really?", display = "Really?" },
--                 { text = "Actually, wait, no", display = "Actually, wait, no" },
--             })
--             if not second or vim.startswith(second.text, "Actually, wait") then
--                 return
--             end
--
--             print("Ok, launching missiles! 🚀")
--         end
--     )
-- )
--
-- function pick_file()
--     local selected = nil
--
--     coroutine.resume(
--         coroutine.create(
--             function()
--                 local co = coroutine.running()
--
--                 require("snacks").picker.pick(
--                     'files',
--                     {
--                         title = "Executable to Debug",
--                         layout = "select",
--                         confirm = function(picker, item)
--                             picker:close()
--                             selected = item
--                             if coroutine.status(co) ~= "running" then
--                                 coroutine.resume(co)
--                             end
--                         end,
--                     }
--                 )
--
--                 if not selected then coroutine.yield() end
--                 return selected
--             end
--         )
--     )
-- end

function pick_file()
  local co = coroutine.running()
  local selected = nil

  local Path = require("plenary.path")
  local cwd = Snacks.git.get_root()

  require("snacks").picker.pick(
      "files",
      {
          cwd = cwd,
          args = {"--type", "x"},
          hidden = true,
          ignored = true,
          title = "Pick executable to debug",
          layout = "select",
          confirm = function(picker, item)
              picker:close()
              selected = Path:new(item.text):absolute(cwd)
              if coroutine.status(co) ~= "running" then
                  coroutine.resume(co)
              end
          end,
      }
  )

  if not selected then
      coroutine.yield()
  end

  return selected
end

dap.configurations.cpp = {
    {
        name = "Launch an executable",
        type = "lldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = pick_file,

        -- function()
        --     return coroutine.create(
                -- function()
                -- function(coro)
                -- local opts = {}
                -- local root = string.gsub(vim.fn.system(
                --     "git rev-parse --show-toplevel"),
                --     "\n",
                --     ""
                -- -- )
                -- local root = Snacks.git.get_root()
                -- if vim.v.shell_error == 1 then
                --     root = "."
                -- end
                -- Snacks.picker.files(
                --     {
                --         cwd = root,
                --         args = {"--type","x"},
                --         hidden = true,
                --         ignored=true,
                --     }
                -- )
                -- pickers.new(
                --     opts,
                --     {
                --         prompt_title = "Path to executable",
                --         finder = finders.new_oneshot_job(
                --             {
                --                 "fd",
                --                 "--hidden", "--no-ignore", "--type", "x",
                --                 ".*",
                --                 root,
                --             },
                --             {}
                --         ),
                --         sorter = conf.generic_sorter(opts),
                --         attach_mappings = function(buffer_number)
                --             actions.select_default:replace(
                --                 function()
                --                     actions.close(buffer_number)
                --                     coroutine.resume(
                --                         coro,
                --                         action_state.get_selected_entry()[1]
                --                     )
                --                 end
                --             )
                --             return true
                --         end,
                --     }
                -- ):find()
        --     end
        -- )
        -- end,
    },
}

-- same as C++ but searches in zig-out
dap.configurations.zig = {
    {
        name = "Launch an executable",
        type = "lldb",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = pick_file,
            -- return coroutine.create(
                -- function(coro)
                -- local opts = {}
                -- local root = string.gsub(vim.fn.system(
                --     "git rev-parse --show-toplevel"),
                --     "\n",
                --     ""
                -- )
                -- if vim.v.shell_error == 1 then
                --     root = "."
                -- else
                --     root = root .. "/zig-out"
                -- end
                -- pickers.new(
                --     opts,
                --     {
                --         prompt_title = "Path to executable",
                --         finder = finders.new_oneshot_job(
                --             {
                --                 "fd",
                --                 "--hidden", "--no-ignore", "--type", "x",
                --                 ".*",
                --                 root,
                --             },
                --             {}
                --         ),
                --         sorter = conf.generic_sorter(opts),
                --         attach_mappings = function(buffer_number)
                --             actions.select_default:replace(
                --                 function()
                --                     actions.close(buffer_number)
                --                     coroutine.resume(
                --                         coro,
                --                         action_state.get_selected_entry()[1]
                --                     )
                --                 end
                --             )
                --             return true
                --         end,
                --     }
                -- ):find()
            -- end
        -- )
        -- end,
    },
}

-- debugger mappings -- using which-key to group it
wk.add(
    {
        -- establish "d" as the prefix for the debugger
        { "<leader>d", group="debug" },
        {
            '<leader>du',
            function() require('dapui').toggle() end,
            desc="debug: open ui"
        },
        {
            '<leader>dc',
            function() require('dap').continue() end,
            desc="debug: continue/start the debugger"
        },
        {
            '<leader>dl',
            function() require('dap').run_last() end,
            desc="debug: re-run the last debug session"
        },
        {
            '<leader>b',
            function() require('dap').toggle_breakpoint() end,
            desc="debug: toggle breakpoint"
        },
        {
            '<leader>di',
            function() require('dap').step_into() end,
            desc="debug: step in"
        },
        {
            '<leader>do',
            function() require('dap').step_out() end,
            desc="debug: step out"
        },
        {
            '<leader>o',
            function() require('dap').step_over() end,
            desc="debug: step over"
        },
    }

)

require("nvim-dap-virtual-text").setup()
-- @}

-- @{ Trouble.nvim (Diagnostics) ("x" prefix")
wk.add({"<Leader>x", group="Trouble (LSP Diagnostics)"})
-- @}
