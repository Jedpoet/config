-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
vim.keymap.set('n', '<Space>', ':', opts)
vim.keymap.set('n', '<leader>fa', ":lua require('fzf-lua').files({cwd='/'})<CR>", opts)
vim.keymap.set('n', '<C-a>', "gg0vG$", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Nvim-move setting
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
vim.keymap.set('n', '<C-v>', 'p', opts)
vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)
vim.keymap.set('n', '<leader>n', "<cmd>BufferLineCycleNext<CR>", opts) -- 下一個 buffer
vim.keymap.set('n', '<leader>p', "<cmd>BufferLineCyclePrev<CR>", opts) -- 上一個 buffer

-- vim.keymap.set('n', '<leader>t', "<cmd>TagbarToggle<CR><C-w>l", opts)  -- 打開tagbar
vim.keymap.set("n", "<leader>t", function()
    vim.o.shell = "cmd"
    return "<cmd>TagbarToggle<CR><C-w>l"
    -- vim.g.tagbar_ctags_bin = "cmd.exe /C ctags"
    -- vim.cmd("TagbarToggle")
    -- vim.cmd("wincmd l")
    -- end, { noremap = true })
end, { expr = true, noremap = true })
vim.keymap.set("n", "<leader>g", ":BufferLineGoToBuffer ", opts)

-- find setting
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = 'Telescope oldfiles' }) -- 尋找最近使用的檔案

vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek function definition' })

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

-- vim.keymap.set('n', '<leader>r', "<cmd>ToggleTerm size=5 dir=~/Desktop direction=horizontal name=desktop<CR>", opts)
vim.keymap.set("n", "<leader>r", function()
    if vim.fn.has("win32") == 1 then
        vim.o.shell = "nu"
    end
    return "<cmd>lua toggle_terminal()<CR>"
end, { expr = true, noremap = true })

vim.keymap.set("n", "<leader>[", function()
    if vim.fn.has("win32") == 1 then
        vim.o.shell = "nu"
    end
    return "<cmd>terminal<CR>"
end, { expr = true, noremap = true })

vim.keymap.set("n", "<C-e>", function()
    local neo_tree = require("neo-tree.command")
    neo_tree.execute({ toggle = true })
end, opts)

-----------------
-- Insert mode --
-----------------

vim.keymap.set('i', 'jk', '<Esc>', opts)
vim.keymap.set('i', '螭鍇', '<Esc>', opts)
vim.keymap.set('i', '惡惡', '<Esc>', opts)
-- vim.keymap.set('i', "(", "() <++><Esc>F<hhi", opts)
-- vim.keymap.set('i', "[", "[] <++><Esc>F<hhi", opts)
-- vim.keymap.set('i', "{", "{} <++><Esc>F<hhi", opts)
-- vim.keymap.set('i', "\"", "\"\" <++><Esc>F<hhi", opts)
-- vim.keymap.set('i', "\'", "\'\' <++><Esc>F<hhi", opts)
-- vim.keymap.set('i', "<>", "< <++>> <++><Esc>F<hhhhhhhi", opts)
vim.keymap.set('i', ",f", "<Esc>/ <++><CR>:noh<CR>c5l", opts)
vim.keymap.set('i', "<C-v>", "<Esc>pi", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Nvim-move setting
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
-- vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

-------------------
-- Terminal mode --
-------------------

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = true })
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = true })
        vim.keymap.set("n", "x", '<cmd>bd!<CR>', { buffer = true })
    end,
})

-------------------
-- Markdown only --
-------------------

local mar = {
    buffer = true,
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set('n', "<leader>m", "<cmd>MarkdownPreviewToggle<CR>", mar)
        vim.keymap.set('i', "$", "$ <++>$ <++><Esc>F$hhhhhi", mar)
        vim.keymap.set('i', ",t",
            "| <tt> |  <++> | <++><CR>| ---- | ---- |<CR>|  <++> |  <++> | <++><Esc>/<tt><CR>:noh<CR>c4l", mar)
        vim.keymap.set('i', ".t", " <tt> |  <++><Esc>/<tt><CR>:noh<CR>c4l", mar)
        vim.keymap.set('i', ",c",
            "$\\begin{cases}<CR><tt>\\\\<CR> <++>\\\\ <++><CR>\\end{cases}$<CR> <++><Esc>/<tt><CR>:noh<CR>c4l", mar)
        vim.keymap.set('i', ",b", "<font color='#3D90D7'><tt></font><Esc>/<tt><CR>:noh<CR>c4l", mar)
        vim.keymap.set('i', ",m",
            "$\\left[\\begin{matrix}<CR><tt>\\\\<CR> <++>\\\\ <++><CR>\\end{matrix}\\right]$<CR> <++><Esc>/<tt><CR>:noh<CR>c4l",
            mar)
        vim.keymap.set('i', ",l", "[<tt>]( <++>) <++><Esc>/<tt><CR>:noh<CR>c4l", mar)
        vim.keymap.set("i", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            if line:match("|%s*$") then
                return "<CR>|"
            else
                return "<CR>"
            end
        end, { expr = true, noremap = true })
    end
})
