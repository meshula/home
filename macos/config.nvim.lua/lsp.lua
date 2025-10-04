-- LSP config

-- @{  LSP Configurations (define LSPs using lspconfig plugin) 
--     LSP programs themselves need to be externally installed/managed (IE 
--     through conda)
vim.lsp.enable("pyright")
vim.lsp.enable("zls")
vim.lsp.enable("sourcekit")
-- vim.lsp.enable("clangd")
vim.lsp.config(
    "lua_ls",
    {
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
                    -- Tell the language server which version of Lua you're
                    -- using (most likely LuaJIT in the case of Neovim)
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
            Lua = {
                diagnostics = { globals = { "vim", "Snacks" } },
                telemetry = false,
            },
        }
    }
)
vim.lsp.enable("lua_ls")
-- @}


vim.lsp.inlay_hint.enable()
vim.keymap.set(
    "n",
    "<Leader>jd",
    vim.lsp.buf.definition,
    { desc = "jump to definition" }
)
vim.keymap.set(
    "n",
    "<Leader>jD",
    vim.lsp.buf.declaration,
    { desc = "jump to declaration" }
)
vim.keymap.set(
    "n",
    "<Leader>n",
    vim.lsp.buf.rename,
    { desc = "rename the symbol under the cursor using the lsp (refactor)" }
)
vim.diagnostic.config(
    {
        -- virtual_lines = { current_line = false, },
        virtual_lines = false,
        virtual_text = true,
        underline = true,
        signs = true,
        -- float = { cursor = true },
        float = {
            border = 'rounded',
            focusable = true, -- for copy-paste
            severity_sort = true,
            -- format = function(diagnostic)
            --     return string.format('%s [%s]', diagnostic.message, diagnostic.source)
            -- end,
        },
        update_in_insert = true,
        jump = {
            float = true,
        },
    }
)

-- diagnostic on hover
vim.api.nvim_create_autocmd(
    { "CursorHold" },
    {
        pattern = "*",
        callback = function()
            for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.api.nvim_win_get_config(winid).zindex then
                    return
                end
            end
            vim.diagnostic.open_float(
                {
                    scope = "cursor",
                    focusable = false,
                    close_events = {
                        "CursorMoved",
                        "CursorMovedI",
                        "BufHidden",
                        "InsertCharPre",
                        "WinLeave",
                    },
                }
            )
        end
    }
)

-- swap header/impl
vim.keymap.set(
    "n",
    "<Leader>k",
    vim.cmd.ClangdSwitchSourceHeader,
    { desc = "swap buffer between source and header"}
)
