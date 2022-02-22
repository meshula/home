
local vim = vim
local api = vim.api
local fn = vim.fn
-- user interface
vim.cmd([[set mouse=a]])
vim.g.mapleader = " "
vim.g.completion_enable_auto_popus = 1
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.o.guifont = "FantasqueSansMono Nerd Font Mono:h13"

-- window options
vim.wo.relativenumber = false
vim.wo.number = true
vim.wo.colorcolumn = "80"

-- undo
vim.cmd([[set undofile]])

-- edit
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.clipboard = "unnamedplus"

-- plugins
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
print(install_path)
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  -- git
  use "tpope/vim-fugitive"
  use "mhinz/vim-signify"
  
  -- user interface
  -- use "morhetz/gruvbox"
  use "ryanoasis/vim-devicons"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"
  use "mhartington/oceanic-next"
  -- use "DanilaMihailov/beacon.nvim"

  -- language support
  use "neovim/nvim-lspconfig"
  -- use { "autozimu/LanguageClient-neovim", branch="next", run = "bash install.sh" }
  use { "neoclide/coc.nvim", branch="release" }
  use "nvim-treesitter/nvim-treesitter"
  use "ziglang/zig.vim"
  -- use "quadplay/vim-pyxlscript-syntax"
  
  -- editor
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- file browser
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- after all the plugins are requested, sync
  if packer_bootstrap then
    require('packer').sync()
  end    
end)

vim.g.coc_global_extensions = {
    'coc-json',
    'coc-cmake',
    'coc-clangd',
    'coc-git',
    'coc-glslx',
    'coc-markdownlint',
    'coc-yank',
    'coc-yaml',
    'coc-zls', 
    '@yaegassy/coc-pylsp',
    'coc-clangd',
}

api.nvim_set_keymap("n", "<leader>zsh", ":e term://zsh | normal i", {noremap=true})
api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {noremap=true})

api.nvim_set_keymap("n", "<leader>v", ":vsplit", {noremap=true})
api.nvim_set_keymap("n", "<leader>h", ":split", {noremap=true})

api.nvim_set_keymap("n", "<leader>ls", ":NvimTreeOpen", {noremap=true})

if false then
    api.nvim_set_keymap("n", "K", 
      ':call LanguageClient#textDocument_hover()<CR>',  
      {noremap = true, silent = true})
    api.nvim_set_keymap("n", "gd", 
      ':call LanguageClient#textDocument_definition()<CR>', 
      {noremap = true, silent = true})
    api.nvim_set_keymap("n", "<F2>", 
      ':call LanguageClient#textDocument_rename()<CR>',  
      {noremap = true, silent = true})
end

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw        = false,
  hijack_netrw         = true,
  open_on_setup        = false,
  ignore_ft_on_setup   = {},
  auto_close           = false,
  auto_reload_on_write = true,
  open_on_tab          = false,
  hijack_cursor        = false,
  update_cwd           = false,
  hijack_unnamed_buffer_when_opening = false,
  hijack_directories   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  actions = {
    change_dir = {
      global = false,
    },
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf"
          }
        }
      }
    }
  }
}

api.nvim_command [[colorscheme OceanicNext]]

