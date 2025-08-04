local terminal_buf = nil
local terminal_win = nil

function _G.toggle_terminal()
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, true)
        terminal_win = nil
        return
    end

    -- 若沒開啟就建立浮動終端
    terminal_buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.4)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    terminal_win = vim.api.nvim_open_win(terminal_buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    vim.cmd("term") -- 啟動終端
    -- vim.cmd("startinsert") -- 進入輸入模式
end
