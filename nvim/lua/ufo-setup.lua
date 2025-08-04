-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()

-- --- Peek function head 自動浮窗 ---
local function peek_function_head()
    local ufo = require('ufo')
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1

    -- 抓取當前的 fold (如果有)
    local range = ufo.getFolds(bufnr)[row]
    if not range then
        return
    end

    -- 抓這個 fold 的起始位置
    local start_line = range.startLnum
    local end_line = math.min(start_line + 5, vim.api.nvim_buf_line_count(bufnr)) -- 最多讀 5 行

    -- 讀取 function 定義開頭的幾行
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
    if vim.tbl_isempty(lines) then
        return
    end

    -- 顯示成浮動視窗
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = 0
    for _, line in ipairs(lines) do
        width = math.max(width, #line)
    end
    width = math.min(width + 4, vim.o.columns - 4)

    local win = vim.api.nvim_open_win(buf, false, {
        relative = 'cursor',
        row = 1,
        col = 0,
        width = width,
        height = #lines,
        style = 'minimal',
        border = 'single',
    })

    -- 移動時自動關閉浮窗
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
        once = true,
        callback = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
        end
    })
end

-- 每次停住時觸發 peek
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        peek_function_head()
    end
})
