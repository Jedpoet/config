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
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'lua_ls', 'ast_grep', 'texlab', 'marksman', 'basedpyright', 'ruff' }
})

-- Set different settings for different languages' LSP.
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP.
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
local lspconfig = require("lspconfig")

-- Customized on_attach function.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions.
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
-- local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

-- if client.name == "rust_analyzer" then
-- 	-- WARNING: This feature requires Neovim v0.10+
-- 	vim.lsp.inlay_hint.enable()
-- end

-- See `:help vim.lsp.*` for documentation on any of the below functions
--[[
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({
			async = true,
			-- Predicate used to filter clients. Receives a client as
			-- argument and must return a boolean. Clients matching the
			-- predicate are included.
			filter = function(client)
				-- NOTE: If an LSP contains a formatter, we don't need to use null-ls at all.
				return client.name == "null-ls"
					or client.name == "hls"
					or client.name == "rust_analyzer"
					or client.name == "ruff"
					or client.name == "ts_ls"
			end,
		})
	end, bufopts)
    --]]
-- end

-- How to add an LSP for a specific programming language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add the configuration below. The syntax is `lspconfig.<name>.setup(...)`
-- Hint (find <name> here) : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- 使用 basedpyright 作為主要 LSP
lspconfig.basedpyright.setup({
    on_attach = on_attach,
    settings = {
        basedpyright = {
            typeCheckingMode = "basic", -- 可選：off, basic, strict
        },
    },
})

-- 使用 ruff_lsp 作為 linter/formatter
lspconfig.ruff.setup({
    on_attach = on_attach,
})

lspconfig.gopls.setup({
    on_attach = on_attach,
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global.
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files.
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier.
            telemetry = {
                enable = false,
            },
            hint = {
                true,
            },
        },
    },
})

-- lspconfig.rust_analyzer.setup({
-- 	-- source: https://rust-analyzer.github.io/manual.html#nvim-lsp
-- 	on_attach = on_attach,
-- })

-- 不要用 lspconfig.rust_analyzer.setup()
-- 而是用 vim.g.rustaceanvim
-- vim.g.rustaceanvim = {
--     server = {
--         on_attach = function(client, bufnr)
--             -- 你的 on_attach 函數
--         end,
--     },
-- }

lspconfig.clangd.setup({
    on_attach = on_attach,
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

-- Case 1. For CMake Users
--     $ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
-- Case 2. For Bazel Users, use https://github.com/hedronvision/bazel-compile-commands-extractor
-- Case 3. If you don't use any build tool and all files in a project use the same build flags
--     Place your compiler flags in the compile_flags.txt file, located in the root directory
--     of your project. Each line in the file should contain a single compiler flag.
-- src: https://clangd.llvm.org/installation#compile_commandsjson

lspconfig.marksman.setup({})
lspconfig.texlab.setup({
    filetypes = { "markdown" }
})

local cmp = require("cmp")

cmp.setup({
    mapping = {
        -- 讓 Tab 可以選擇補全項目
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),

        -- 讓 Enter 只換行，不選擇補全
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false, -- 這行確保 Enter **不會自動選擇補全項目**
        }),
    },
})

vim.diagnostic.config({
    virtual_text = false, -- 不顯示 inline 的小文字
    signs = true,         -- 左側的 error/warning 標記
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded", -- 浮動視窗邊框樣式，可選 single/rounded/solid/shadow
        source = "always",  -- 顯示診斷來源
        header = "",
        prefix = "",
    },
})

-- 光標停留時，顯示 diagnostic 浮動視窗
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
