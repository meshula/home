-- stephan steinbach's init.lua file
-- ...based on my vimrc file, translated in ~2020 to lua
-- ...which is based on Günter Steinbach's vimrc, copied originally in ~2001
-- ...who knows how his old his vimrc was though
-- ----------------------------------------------------------------------------

-- check the neovim version
local nvim_version = "0.11"
if (vim.fn.has('nvim-' .. nvim_version) ~= 1) then
    local version = vim.version()
    print(
        "insufficient neovim version, expected: " .. nvim_version
        .. " got: "
        .. version.major .. "." .. version.minor .. "." .. version.patch
    )
end

-- Spacebar as Leader
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system(
      {
          "git",
          "clone",
          "--filter=blob:none",
          "--branch=stable",
          lazyrepo,
          lazypath
      }
  )
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo(
    {
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out, "WarningMsg" },
          { "\nPress any key to exit..." },
        },
        true,
        {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- load my plugins into lazy
require("lazy").setup("plugins")

-- keyboard mappings
require('mappings')

-- plugin configuration
require('plugin_config')

-- @{ look/color scheme stuff
-- horizontal line under the cursor and 80 character colum
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

-- program language syntax on
vim.opt.termguicolors = true

-- set a different colorscheme in ssh mode
function detect_ssh()
	local str = vim.env.SSH_CLIENT
	if (str ~= nil) then
		str = str:gsub("%s+", "")
		str = string.gsub(str, "%s+", "")

		if (str ~= "") then
			vim.cmd.colorscheme('duskfox')
		end
	end
end
detect_ssh()

-- toggle line numbers between absolute and relative
vim.api.nvim_create_autocmd(
    "InsertEnter",
    {
        callback = function()
            vim.opt.relativenumber = false
        end,
    }
)
vim.api.nvim_create_autocmd(
    "InsertLeave",
    {
        callback = function()
            vim.opt.relativenumber = true
        end,
    }
)

vim.opt.number = true
vim.opt.relativenumber = true

-- toggle line numbering
function toggle_number()
    vim.opt.number = not vim.o.number
    vim.opt.relativenumber = not vim.o.relativenumber
end
vim.keymap.set(
    "n",
    "<Leader>N",
    function()
        toggle_number()
    end,
    {noremap=true}
)
-- @}

-- @{ undo
vim.opt.undofile = true
-- @}

-- @{ tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- @}

-- @{ search
-- when searching, ignore casing
vim.opt.ignorecase = true
-- ...unless an upper case letter is present, then DO be case sensitive
vim.opt.smartcase = true
-- @}

-- @{ directory
-- when opening a file, cd to its directory
vim.opt.autochdir = true
-- @}

-- @{
-- faster update time makes all the async stuff more responsive
vim.opt.updatetime = 100
-- @}

-- @{ Markdown
vim.g.markdown_recommended_style = 0
-- @}

-- @{ custom filetype mappings
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead"},
    {
        pattern = "*.md.html",
        callback = function()
            vim.api.bo.filetype = "markdown"
        end,
    }
)
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead"},
    {
        pattern = "*.otio",
        callback = function()
            vim.api.bo.filetype = "json"
        end,
    }
)
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead"},
    {
        pattern = "*.wgsl",
        callback = function()
            vim.bo.filetype = "wgsl"
        end,
    }
)
-- @}

-- @{ moving around, how many lines to keep at the top or bottom of the screen
vim.opt.scrolloff = 3
-- @}

-- @{ the parameters of the "shada" file, which is partly responsible for 
--    :oldfiles, which I use with telescope...
vim.opt.shada = "!,'5000,<100,s100,h"
-- @}

-- @{
-- python indentation preference
vim.g.python_indent = {
    closed_paren_align_last_line = true
}
-- @}

-- so that the sign coloumn (left of the numbers) doesn't ocnstantly appear and 
-- disapear as bugs come and go
vim.opt.signcolumn = "yes"

-- LSP config @{
vim.lsp.inlay_hint.enable()
vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { desc = "jump to definition" }
)
vim.keymap.set(
    "n",
    "<Leader>n",
    vim.lsp.buf.rename,
    { desc = "rename the symbol under the cursor using the lsp" }
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
-- @}

-- @{ highlight on yank
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        callback = function()
            vim.highlight.on_yank({ timeout = 333 })
        end,
    }
)
-- @}
