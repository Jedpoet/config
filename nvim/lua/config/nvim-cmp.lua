local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- Use <C-b/f> to scroll the docs
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Enter 確認，選單未顯示則換行
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Tab 選擇下一個，或跳轉 Snippet，或縮排
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- 如果補全選單可見，選擇下一個
            if cmp.visible() then
                cmp.select_next_item()
            -- 如果在 snippet 中，跳到下一個節點
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            -- 否則，執行預設的 Tab 行為 (縮排)
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Shift-Tab 選擇上一個
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    -- Let's configure the item's appearance
    -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    formatting = {
        -- Set order from left to right
        -- kind: single letter indicating the type of completion
        -- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
        -- menu: extra text for the popup menu, displayed after "word" or "abbr"
        fields = { 'abbr', 'menu' },

        -- customize the appearance of the completion menu
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[Lsp]',
                luasnip = '[Luasnip]',
                buffer = '[File]',
                path = '[Path]',
            })[entry.source.name]
            return vim_item
        end,
    },

    -- Set source precedence
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- For nvim-lsp
        { name = 'luasnip' }, -- For luasnip user
        { name = 'buffer' }, -- For buffer word completion
        { name = 'path' }, -- For path completion
    })
})
