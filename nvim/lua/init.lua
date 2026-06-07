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
require('lazy').setup('plugins')

-- Load each config module in its own pcall so that one broken module (e.g. a
-- plugin API change) reports itself instead of silently aborting init.lua and
-- taking every setting below it down with it.
local function safe_require(mod)
    local ok, err = pcall(require, mod)
    if not ok then
        vim.schedule(function()
            vim.notify(
                "init.lua: failed to load '" .. mod .. "':\n" .. tostring(err),
                vim.log.levels.ERROR
            )
        end)
    end
end

safe_require('lsp')

-- keyboard mappings
safe_require('mappings')

-- plugin configuration
safe_require('plugin_config')

-- Use terminal colors instead of a custom colorscheme
-- vim.cmd.colorscheme('nightfox')

-- @{ look/color scheme stuff
-- horizontal line under the cursor and 80 character colum
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

-- program language syntax on
-- Disable termguicolors to use terminal's color palette
vim.opt.termguicolors = false

-- set a different colorscheme in ssh mode
-- local function detect_ssh()
-- 	local str = vim.env.SSH_CLIENT
-- 	if (str ~= nil) then
-- 		str = str:gsub("%s+", "")
-- 		str = string.gsub(str, "%s+", "")
--
-- 		if (str ~= "") then
-- 			vim.cmd.colorscheme('duskfox')
-- 		end
-- 	end
-- end
-- detect_ssh()

-- toggle line numbers between absolute and relative
vim.api.nvim_create_autocmd(
    "InsertEnter",
    {
        callback = function()
            vim.opt.relativenumber = true
        end,
    }
)
vim.api.nvim_create_autocmd(
    "InsertLeave",
    {
        callback = function()
            vim.opt.relativenumber = false
        end,
    }
)

vim.opt.number = true
vim.opt.relativenumber = false

-- @{ undo
vim.opt.undofile = true
-- @}

-- @{ tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
-- @}

-- @{ search
-- when searching, ignore casing
vim.opt.ignorecase = true
-- ...unless an upper case letter is present, then DO be case sensitive
vim.opt.smartcase = true
-- @}

-- when opening a file, cd to its directory
vim.opt.autochdir = true

-- faster update time makes all the async stuff more responsive
vim.opt.updatetime = 100

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
-- .mm is Objective-C++ (Vim's default treats it as nroff/groff, which gives
-- no useful coloring). objcpp sources both the ObjC and C++ syntax.
vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead"},
    {
        pattern = "*.mm",
        callback = function()
            vim.bo.filetype = "objcpp"
        end,
    }
)
-- @}

-- @{ Enable wrap and linebreak for text files
vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter"},
    {
        pattern = {"*.md", "*.txt", "*.html"},
        callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
        end,
    }
)
-- @}

-- @{ moving around, how many lines to keep at the top or bottom of the screen
vim.opt.scrolloff = 3
-- @}

-- @{ the parameters of the "shada" file, which is partly responsible for 
--    :oldfiles, which I use with recent file picker...
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