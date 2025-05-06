
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set(
    'n',
    '<Esc>',
    vim.cmd.nohlsearch,
    { desc = "Clear search highlights" }
)

vim.keymap.set(
    "n",
    "<Leader>q",
    vim.cmd.quit,
    { desc = "close this buffer" }
)
vim.keymap.set(
    "n",
    "<Leader>Q",
    vim.cmd.qall,
    {desc = "close all buffers and exit vim"}
)

-- save
vim.keymap.set(
    "n",
    "<Leader>s",
    vim.cmd.write,
    {silent= true, desc="save this buffer"}
)

-- @{ use jk kj to exit insert mode
vim.keymap.set("i","jk","<Esc>", {noremap=true, desc = "escape alias"})
vim.keymap.set("i","kj","<Esc>", {noremap=true, desc = "escape alias"})
-- @}

-- @{ splits
vim.keymap.set(
    "n",
    "<Leader>-",
    "<C-w>s<C-w>j",
    {desc="split top/bottom"}
)
vim.keymap.set(
    "n",
    "<Leader>v",
    "<C-w>v<C-w>l",
    {desc="split left/right"}
)
-- opens the current buffer in its own tab, without changing the current window
-- layout
vim.keymap.set(
    "n",
    "<Leader>_",
    function()
        vim.cmd.tab("split")
    end,
    {desc="open this buffer in a fullscreen tab"}
)
-- even out sizes
vim.keymap.set(
    "n",
    "<Leader>=",
    "<C-w>=",
    {desc="even out split sizes"}
)
-- @}

-- jump back to the last file in this window
vim.keymap.set(
    "n",
    "<Leader>3",
    function()
        vim.cmd.edit("#")
    end,
    {desc = "switch to the previous buffer"}
)

-- show the full path to the file in the current buffer
vim.keymap.set(
    "n",
    "<Leader>P",
    function()
        vim.cmd.echo("expand('%:p')")
    end,
    {desc="show the path to this buffer"}
)

