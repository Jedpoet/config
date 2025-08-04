require("bufferline").setup({
    options = {
        mode = "buffers",          -- 或 "tabs"，決定 bufferline 是基於 buffer 還是 tab
        numbers = "ordinal",       -- "none" | "ordinal" | "buffer_id" | "both"
        diagnostics = "nvim_lsp",  -- 顯示 LSP 診斷資訊
        separator_style = "slant", -- "slant" | "thick" | "thin" | { "left", "right" }
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
                separator = true
            }
        },
        show_buffer_icons = true,       -- 是否顯示 buffer 的 icon
        show_buffer_close_icons = true, -- 是否顯示 buffer 的關閉按鈕
        show_close_icon = true,         -- 是否顯示最右邊的關閉按鈕
        enforce_regular_tabs = false,   -- 是否讓所有 tabs 一樣寬度
        always_show_bufferline = false, -- 是否在只有一個 buffer 時仍然顯示
    },
    highlights = {
        separator = {
            fg = "#434c5e", -- 設定未選中的分隔符顏色
        },
        separator_selected = {
            fg = "#434c5e", -- 設定選中的分隔符顏色
        },
        fill = {
            bg = "#434c5e",
        },
        background = {
            fg = "#bbbbbb",
        },
        buffer_selected = {
            fg = "#c0e0ff",
            bold = true,
            italic = false,
        },
    },
})
