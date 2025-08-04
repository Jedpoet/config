-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.termguicolors = true      -- allow colors
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim
vim.g.mapleader = '['             -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spacesin tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.linebreak = true
vim.opt.scrolloff = 5
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false  -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- fold
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zo', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zc', require('ufo').closeAllFolds)

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

-- 把 ctags 所在目录加到 PATH
-- vim.g.tagbar_ctags_bin = "cmd.exe /C ctags"
-- vim.g.tagbar_ctags_bin = 'C:/Program Files (x86)/ctags/ctags.exe'
-- vim.g.tagbar_ctags_type = 'universal'

-- 改 Neovim 的 updatetime（單位：毫秒）
vim.o.updatetime = 500 -- 這裡決定游標停在原地多久後觸發 CursorHold

-- 綁定 CursorHold 事件，觸發 diagnostic 視窗
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})


-- if vim.fn.has("win32") == 1 then
--     vim.o.shell = "pwsh"
-- end

-- Neovide setting
if vim.g.neovide then
    vim.o.guifont = "Firacode Nerd Font:h13"
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.5 -- 粒子生命秒數
    vim.g.neovide_cursor_vfx_particle_density = 10.0 -- 粒子密度
    -- vim.g.neovide_opacity = 0.8 -- 視窗整體透明
    vim.o.winblend = 80                              -- 浮動視窗透明
    vim.o.pumblend = 80                              -- popup 補全視窗透明
    vim.o.termguicolors = true
end
