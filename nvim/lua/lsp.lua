require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'ast_grep',
        'marksman',
        'pyright',
        'ruff',
        'ts_ls',
        'svelte',
        'clangd',
    }
})

local lspconfig = require("lspconfig")

-- Python
lspconfig.pyright.setup({
    settings = {
        pyright = {
            typeCheckingMode = "basic", -- 可選：off, basic, strict
        },
    },
})

lspconfig.ruff.setup({})

-- Go
lspconfig.gopls.setup({})

-- Lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
            hint = {
                enable = true,
            },
        },
    },
})

-- C / C++
lspconfig.clangd.setup({
    settings = {
        clangd = {
            InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
            fallbackFlags = { "-std=c++20" },
        },
    }
})

-- TypeScript / JavaScript
lspconfig.ts_ls.setup({})

-- Svelte
lspconfig.svelte.setup({})

-- Markdown
lspconfig.marksman.setup({})

-- CMake
local configs = require("lspconfig.configs")
local nvim_lsp = require("lspconfig")
if not configs.neocmake then
    configs.neocmake = {
        default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true,
            init_options = {
                format = { enable = true },
                lint = { enable = true },
                scan_cmake_in_package = true,
            }
        }
    }
    nvim_lsp.neocmake.setup({})
end

-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- 光標停留時顯示 diagnostic 浮動視窗
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
