local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
            local ts_config = {
                ensure_installed = { "c", "cpp", "rust", "python", "lua", "vim", "html", "css", "typescript", "svelte", "nu" },
                sync_install = false,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            }

            if vim.fn.has("win32") == 1 then
                ts_config.c_compiler = {
                    command =
                    "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\msvc\\14.44.35207\\bin\\Hostx64\\x64\\cl.exe",
                    defines = { "_CRT_SECURE_NO_WARNINGS" },
                    extra_cflags = { "/std:c17" },
                    is_msvc = true
                }
                ts_config.cpp_compiler = {
                    command =
                    "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\msvc\\14.44.35207\\bin\\Hostx64\\x64\\cl.exe",
                    defines = { "_CRT_SECURE_NO_WARNINGS" },
                    extra_cflags = { "/std:c++20" },
                    is_msvc = true
                }
            end

            configs.setup(ts_config)
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    {
        'abecodes/tabout.nvim',
        lazy = false,
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = false,           -- shift content if tab out is not possible
                act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>',  -- reverse shift default action,
                enable_backwards = true,      -- well ...
                completion = false,           -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '<', close = '>' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' }
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        dependencies = { -- These are optional
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp"
        },
        opt = true,              -- Set this to true if the plugin is optional
        event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
        priority = 1000,
    },

    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                under_cursor = true,
            })
        end,

    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
    {
        'fedepujol/move.nvim',
        opts = {
            char = {
                enable = true,
            },
        },
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
    },

    {
        'preservim/tagbar',
    },

    {
        'mg979/vim-visual-multi',
    },

    {
        'gcmt/wildfire.vim',
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
        opts = {
            direction = "float",
        },
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        event = "VeryLazy",
        config = function()
            local notify = require("notify")

            notify.setup({
                stages = "fade_in_slide_out",
                timeout = 3000,
                fps = 60,
                render = "default",
                background_colour = "Normal",
                max_width = math.floor(vim.o.columns * 0.5),
                max_height = math.floor(vim.o.lines * 0.25),
                level = "TRACE",
            })

            vim.notify = notify
        end,
    },

    -- 自動切換輸入法
    {
        "Jedpoet/im-switch.nvim",
        -- event = "VimEnter",
        config = function()
            require("im-switch").setup()
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lazy = false, -- neo-tree will lazily load itself
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
        },
    },

    -- fzf
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {},
        keys = {
            --     { "<leader>f",  "<cmd>FzfLua grep_curbuf<CR>", desc = "files" },
            { "<leader>fg", "<cmd>FzfLua grep_curbuf<CR>", desc = "files" },
            --     { "<leader>f/", "<cmd>FzfLua <CR>",            desc = "FzfLua self" },
            --     { "<leader>ff", "<cmd>FzfLua files<CR>",       desc = "files" },
            --     { "<leader>fb", "<cmd>FzfLua buffers<CR>",     desc = "files" },
        },
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- {
    --     'nvim-telescope/telescope-fzf-native.nvim',
    --     build =
    --     'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    -- },

    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            local ts_context = require("treesitter-context")

            ts_context.setup({
                enable = true,
                max_lines = 5,
                trim_scope = 'outer',
                mode = 'cursor',
                -- separator = "─",
                zindex = 20,
                on_attach = function(bufnr)
                    local api = vim.api
                    local ts_utils = require("nvim-treesitter.ts_utils")
                    local context = require("treesitter-context")

                    -- 改寫 get_text
                    local orig_get_text = context.get_text
                    context.get_text = function(node, ...)
                        -- 抓到 function/class/interface/struct 的宣告節點
                        if node then
                            -- 只取節點的第一行（也就是宣告那一行）
                            local start_row, start_col, end_row, end_col = node:range()
                            local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, start_row, -1, {})
                            -- 過濾掉只有 { 的行
                            local filtered = {}
                            for _, line in ipairs(lines) do
                                if vim.trim(line) ~= "{" then
                                    table.insert(filtered, line)
                                end
                            end
                            return filtered
                        else
                            -- fallback
                            return orig_get_text(node, ...)
                        end
                    end
                end,
            })

            -- 漂亮的淡入動畫
            -- vim.api.nvim_create_autocmd("User", {
            --     pattern = "TreesitterContext",
            --     callback = function()
            --         local win = vim.api.nvim_get_current_win()
            --         if vim.api.nvim_win_is_valid(win) then
            --             vim.api.nvim_win_set_option(win, "winblend", 20)
            --         end
            --     end
            -- })
        end,
    },

    {
        "ethanholz/nvim-lastplace",
        lazy = true,
    },

    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        cond = function()
            -- 檢查啟動時傳入的檔案參數數量是否為 0
            return vim.fn.argc() == 0
        end,
        config = function()
            require('dashboard').setup {
                theme = "doom", -- 或 hyper，選你喜歡的樣式
                config = {
                    header = {
                        "  ",
                        "  ",
                        "########################################################################",
                        "#                                                                      #",
                        "#       ██╗ █████╗ ██████╗ ███████╗██████╗  ██████╗ ███████╗████████╗  #",
                        "#       ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝  #",
                        "#       ██║███████║██║  ██║█████╗  ██████╔╝██║   ██║█████╗     ██║     #",
                        "#  ██   ██║██╔══██║██║  ██║██╔══╝  ██╔═══╝ ██║   ██║██╔══╝     ██║     #",
                        "#  ╚█████╔╝██║  ██║██████╔╝███████╗██║     ╚██████╔╝███████╗   ██║     #",
                        "#   ╚════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝      ╚═════╝ ╚══════╝   ╚═╝     #",
                        "#                                                                      #",
                        "########################################################################",
                        "  ",
                        "  ",
                        "  ",
                    },
                    center = {
                        {
                            icon = "  ",
                            desc = "Find File",
                            key = "f",
                            action = "Telescope find_files",
                        },
                        {
                            icon = "  ",
                            desc = "Recent Files",
                            key = "r",
                            action = "Telescope oldfiles",
                        },
                        {
                            icon = "  ",
                            desc = "Show Lazy",
                            key = "s",
                            action = "Lazy",
                        },
                        {
                            icon = "󰗼  ",
                            desc = "Quit",
                            key = "q",
                            action = ":q",
                        },
                    },
                    footer = {
                        "Peace cannot be kept by force.",
                        "It can only be achieved by understanding.",
                        -- { "請別讓我獨自匍匐於滂沱世末之雨" }
                    }
                } -- config
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    },

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- markdown table
    {
        'Kicamon/markdown-table-mode.nvim',
        config = function()
            require('markdown-table-mode').setup()
        end
    },
    {
        "bullets-vim/bullets.vim",
        config = function()
            vim.g.bullets_enabled_file_types = { "markdown" }
            vim.g.bullets_outline_levels = { "num", "ABC", "abc", "std-", "std+", "std*", "chk" }
            vim.g.bullets_custom_mappins = {
                { 'nmap', 'o', '<Plug>(bullets-newline)' }
            }
        end
    },

    {
        "nathom/filetype.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("filetype").setup({
                overrides = {
                    extensions = {
                        h = "cpp",
                    },
                }
            })
        end
    },
    -- 右側狀態欄
    {
        "lewis6991/satellite.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        config = function()
            require('satellite').setup {
                current_only = false,
                winblend = 50,
                zindex = 40,
                excluded_filetypes = {},
                width = 2,
                handlers = {
                    cursor = {
                        enable = true,
                        -- Supports any number of symbols
                        symbols = { '⎺', '⎻', '⎼', '⎽' }
                        -- symbols = { '⎻', '⎼' }
                        -- Highlights:
                        -- - SatelliteCursor (default links to NonText
                    },
                    search = {
                        enable = true,
                        -- Highlights:
                        -- - SatelliteSearch (default links to Search)
                        -- - SatelliteSearchCurrent (default links to SearchCurrent)
                    },
                    diagnostic = {
                        enable = true,
                        signs = { '-', '=', '≡' },
                        min_severity = vim.diagnostic.severity.HINT,
                        -- Highlights:
                        -- - SatelliteDiagnosticError (default links to DiagnosticError)
                        -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
                        -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
                        -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
                    },
                    gitsigns = {
                        enable = true,
                        signs = { -- can only be a single character (multibyte is okay)
                            add = "│",
                            change = "│",
                            delete = "-",
                        },
                        -- Highlights:
                        -- SatelliteGitSignsAdd (default links to GitSignsAdd)
                        -- SatelliteGitSignsChange (default links to GitSignsChange)
                        -- SatelliteGitSignsDelete (default links to GitSignsDelete)
                    },
                    marks = {
                        enable = true,
                        show_builtins = false, -- shows the builtin marks like [ ] < >
                        key = 'm'
                        -- Highlights:
                        -- SatelliteMark (default links to Normal)
                    },
                    quickfix = {
                        signs = { '-', '=', '≡' },
                        -- Highlights:
                        -- SatelliteQuickfix (default links to WarningMsg)
                    }
                },
            }
        end
    },

    {
        "ibhagwan/smartyank.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("smartyank").setup()
        end,
    },

    {
        "folke/noice.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
        config = function()
            require("noice").setup({
                lsp = {
                    hover = {
                        enabled = true,
                        opts = {
                            border = "rounded",                          -- 或 "single" / "double" / "solid"
                            max_width = math.floor(vim.o.columns * 0.6), -- 60% 的螢幕寬度
                            max_height = math.floor(vim.o.lines * 0.3),  -- 30% 的螢幕高度
                        },
                    },
                    signature = {
                        enabled = true,
                        opts = {
                            border = "rounded",
                            max_width = math.floor(vim.o.columns * 0.8), -- 50% 的螢幕寬度
                            max_height = math.floor(vim.o.lines * 0.2),  -- 20% 的螢幕高度
                        },
                    },
                    progress = {
                        enabled = true,
                    },
                    message = {
                        enabled = true,
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "notify",
                            find = "No information available",
                        },
                        opts = { skip = true }, -- 避免某些無意義訊息彈出
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = true,
                },
                messages = {
                    enabled = true,
                    view = "notify",
                    view_error = "popup",
                    view_warn = "mini",
                    view_history = "split",
                    view_search = "virtualtext",
                },
                health = {
                    checker = true,
                },
            })
        end,
    },

    -- rust tool
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
        ft = { 'rust' },
    },

    -- auto format
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
                lua = { "stylua" },
                python = { "black" },
                c = { "clang_format" },
                cpp = { "clang_format" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        }
    },

    {
        'mvllow/modes.nvim',
        version = 'v0.2.1',
        config = function()
            require('modes').setup({
                colors = {
                    bg = "", -- Optional bg param, defaults to Normal hl group
                    copy = "#f5c359",
                    delete = "#c75c6a",
                    insert = "#434c5e",
                    visual = "#ee0000",
                },

                -- Set opacity for cursorline and number background
                line_opacity = 0.15,

                -- Enable cursor highlights
                set_cursor = true,

                -- Enable cursorline initially, and disable cursorline for inactive windows
                -- or ignored filetypes
                set_cursorline = true,

                -- Enable line number highlights to match cursorline
                set_number = true,

                -- Enable sign column highlights to match cursorline
                set_signcolumn = true,

                -- Disable modes highlights in specified filetypes
                -- Please PR commonly ignored filetypes
                ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
            })
        end
    },

    {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    },

    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({
                lightbulb = {
                    enable = false,
                    sign = false,
                    virtual_text = false,
                },
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        },
    },

    -- {
    --     'kevinhwang91/nvim-ufo',
    --     requires = 'kevinhwang91/promise-async'
    -- },

    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- theme
    {
        "EdenEast/nightfox.nvim"
    },
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000,
    },
    {
        'nordtheme/vim',
    },
    {
        "zacanger/angr.vim",
    },

    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
        end
    },

    -- AI code
    {
        "joshuavial/aider.nvim",
        opts = {
            -- your configuration comes here
            -- if you don't want to use the default settings
            auto_manage_context = true, -- automatically manage buffer context
            default_bindings = true,    -- use default <leader>A keybindings
            debug = false,              -- enable debug logging
        },
    },

    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer",   -- buffer auto-completion
            "hrsh7th/cmp-path",     -- path auto-completion
            "hrsh7th/cmp-cmdline",  -- cmdline auto-completion
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },

    -- Game
    {
        "seandewar/nvimesweeper",
    },

    {
        'jim-fx/sudoku.nvim',
        cmd = "Sudoku",
        config = function()
            require("sudoku").setup({
                -- configuration ...
            })
        end
    },

    {
        'tamton-aquib/duck.nvim',
        config = function()
            vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("ඞ") end, {})
            vim.keymap.set('n', '<leader>dk', function() require("duck").cook("ඞ") end, {})
            vim.keymap.set('n', '<leader>da', function() require("duck").cook_all("ඞ") end, {})
        end
    },

})


require('move').setup({})

require("ibl").setup()

require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = {
        "gitcommit",
        "gitrebase",
        "svn",
        "hgcommit",
    },
    lastplace_open_folds = true,
})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

-- require('telescope').load_extension('fzf')-

local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
