require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'nord',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {{'branch', 'diff', 'diagnostics'},
                {
                    function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        local diagnostics = vim.diagnostic.get(bufnr)
                        local error_lines = {}

                        for _, diag in ipairs(diagnostics) do
                            if diag.severity == vim.diagnostic.severity.ERROR then
                                table.insert(error_lines, diag.lnum + 1) -- lnum 從 0 開始，所以 +1
                            end
                        end

                        if #error_lines > 0 then
                            return " " .. table.concat(error_lines, ", ")
                        else
                            return ""
                        end
                    end,
                    color = { fg = "#ff5555", gui = "bold" },
                }
        },
        lualine_c = {'filename',
            {
                function()
                    return vim.bo.modified and "[未儲存]" or "[已儲存]"
            end,
            color = function()
                return { fg = vim.bo.modified and "#ff5555" or "#50fa7b" }  -- 紅色（未儲存）→ 綠色（已儲存）
            end,
        },},
        lualine_x = {'encoding', 'lsp_status'},
        lualine_y = {'searchcount', 'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

