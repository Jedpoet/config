# 玉聿的 Neovim 配置

這是一個基於 `lazy.nvim` 的個人 Neovim 配置，旨在提供一個高效且功能豐富的開發環境。

## ✨ 主要功能

*   **插件管理**: 使用 `lazy.nvim` 進行高效的插件管理。
*   **LSP 支援**: 透過 `nvim-lspconfig` 和 `mason.nvim` 提供強大的語言伺服器協議支援，實現智能補全、診斷、定義跳轉等功能。
*   **自動補全**: 由 `nvim-cmp` 提供，支援 LSP、緩衝區、路徑和命令列補全。
*   **文件樹**: 使用 `neo-tree.nvim` 提供直觀的文件瀏覽。
*   **模糊查找**: 整合 `telescope.nvim` 和 `fzf-lua` 實現快速文件、緩衝區和內容查找。
*   **狀態列**: 美觀且實用的 `lualine.nvim` 狀態列。
*   **自動配對與環繞**: `nvim-autopairs` 和 `nvim-surround` 提升編輯效率。
*   **代碼格式化**: 透過 `conform.nvim` 實現多語言的自動代碼格式化。
*   **終端整合**: 內建 `toggleterm.nvim` 方便快速切換終端。
*   **Markdown 增強**: 支援 Markdown 預覽、表格模式和列表自動補全。
*   **主題**: 支援多種主題，包括 `nightfox.nvim`、`catppuccin/nvim` 等。
*   **AI 輔助**: 整合 `aider.nvim` 提供 AI 代碼輔助。
*   **趣味功能**: 內建 `nvimesweeper` 和 `sudoku.nvim` 等小遊戲。

## 🚀 安裝

1.  **前置需求**:
    *   `node.js`: 請參考 [Node.js 官方網站](https://nodejs.org/) 進行安裝。
    *   `git`: 請參考 [Git 官方網站](https://git-scm.com/book/zh-tw/v2/%E9%96%8B%E5%A7%8B-Git-%E5%5B%E5%AE%89%E8%A3%9D-Git%5D) 進行安裝。
    *   `Neovim`: 請參考 [Neovim 官方網站](https://neovim.io/doc/user/install.html) 進行安裝 (v0.9.0 或更高版本)。
    *   `fzf`: 模糊查找工具。
        *   **macOS (Homebrew)**: `brew install fzf`
        *   **Linux (apt)**: `sudo apt install fzf`
        *   **其他系統/手動安裝**: 請參考 [fzf GitHub 頁面](https://github.com/junegunn/fzf#installation)
    *   `ctags` (Universal Ctags): 用於生成代碼標籤，供 Tagbar 等插件使用。
        *   **macOS (Homebrew)**: `brew install universal-ctags`
        *   **Linux (apt)**: `sudo apt install universal-ctags`
        *   **其他系統/手動安裝**: 請參考 [Universal Ctags GitHub 頁面](https://github.com/universal-ctags/ctags#how-to-install)

2.  **克隆倉庫**:
    ```bash
    git clone https://github.com/jadepoet/config.git ~/.config/
    ```

3.  **啟動 Neovim**:
    首次啟動 Neovim 時，`lazy.nvim` 會自動引導並安裝所有插件。
    ```bash
    nvim
    ```

## ⌨️ 鍵盤映射

*   **Leader Key**: `[` 
*   **:**: `SPACE`
*   **ESC**: `jk`
*   **窗口導航**:
    *   `<C-h>`: 移動到左側窗口
    *   `<C-j>`: 移動到下方窗口
    *   `<C-k>`: 移動到上方窗口
    *   `<C-l>`: 移動到右側窗口
*   **文件查找**:
    *   `<leader>ff`: 使用 Telescope 查找文件
    *   `<leader>fa`: 使用 fzf-lua 查找文件 (全盤搜索)
    *   `<leader>fo`: 使用 fzf-lua 查找文件 (搜索最近編輯的文件)
*   **緩衝區導航**:
    *   `<leader>n`: 下一個緩衝區
    *   `<leader>p`: 上一個緩衝區
*   **終端**:
    *   `<leader>r`: 切換浮動終端
    *   `<leader>[`: 開啟新終端
*   **文件樹**:
    *   `<C-e>`: 切換 Neo-tree 文件樹
*   **Markdown 預覽**:
    *   `<leader>m`: (在 Markdown 文件中) 切換 Markdown 預覽
*   **代碼結構**:
    *   `<leader>t`: 切換 Tagbar 視窗 (顯示代碼結構)
*   **快速跳轉**:
    *   `gp`: 跳出浮動視窗顯示此函數、變數定義
    *   `[fg`: 用fzf查找文件內的文字 
    *   `C-f`+要跳轉的字母: 跳轉到螢幕內某字母出現的地方

## 🔌 插件列表

以下是此配置中使用的主要插件：

*   `nvim-treesitter/nvim-treesitter` (語法高亮和結構化編輯)
*   `windwp/nvim-autopairs` (自動配對括號、引號等)
*   `abecodes/tabout.nvim` (快速跳出括號、引號等)
*   `RRethy/vim-illuminate` (高亮當前單詞的所有引用)
*   `folke/which-key.nvim` (顯示可用鍵盤映射)
*   `numToStr/Comment.nvim` (快速註釋代碼)
*   `fedepujol/move.nvim` (移動行或選區)
*   `smoka7/hop.nvim` (快速跳轉)
*   `lukas-reineke/indent-blankline.nvim` (顯示縮進線)
*   `nvim-lualine/lualine.nvim` (美觀的狀態列)
*   `akinsho/bufferline.nvim` (緩衝區標籤列)
*   `preservim/tagbar` (顯示代碼結構)
*   `mg979/vim-visual-multi` (多光標編輯)
*   `gcmt/wildfire.vim` (快速選擇文本塊)
*   `akinsho/toggleterm.nvim` (集成終端)
*   `rcarriga/nvim-notify` (美觀的通知)
*   `Jedpoet/im-switch.nvim` (輸入法自動切換)
*   `kylechui/nvim-surround` (快速添加/修改環繞符)
*   `nvim-neo-tree/neo-tree.nvim` (文件樹)
*   `ibhagwan/fzf-lua` (模糊查找工具)
*   `nvim-telescope/telescope.nvim` (強大的模糊查找器)
*   `mikavilpas/yazi.nvim` (文件管理器集成)
*   `nvim-treesitter/nvim-treesitter-context` (顯示上下文代碼)
*   `ethanholz/nvim-lastplace` (記住上次編輯位置)
*   `nvimdev/dashboard-nvim` (啟動頁面)
*   `iamcco/markdown-preview.nvim` (Markdown 預覽)
*   `Kicamon/markdown-table-mode.nvim` (Markdown 表格編輯)
*   `bullets-vim/bullets.vim` (Markdown 列表自動補全)
*   `nathom/filetype.nvim` (文件類型檢測)
*   `ibhagwan/smartyank.nvim` (智能複製)
*   `folke/noice.nvim` (美化 Neovim 訊息)
*   `mrcjkb/rustaceanvim` (Rust 開發工具)
*   `stevearc/conform.nvim` (代碼格式化)
*   `mvllow/modes.nvim` (模式指示器)
*   `SmiteshP/nvim-navic` (顯示當前函數/類路徑)
*   `nvimdev/lspsaga.nvim` (LSP 增強 UI)
*   `williamboman/mason.nvim` (LSP 伺服器和工具安裝器)
*   `williamboman/mason-lspconfig.nvim` (Mason 與 LSP 配置的橋樑)
*   `neovim/nvim-lspconfig` (LSP 配置)
*   `folke/trouble.nvim` (診斷、位置列表等)
*   `EdenEast/nightfox.nvim` (主題)
*   `catppuccin/nvim` (主題)
*   `nordtheme/vim` (主題)
*   `zacanger/angr.vim` (主題)
*   `MysticalDevil/inlay-hints.nvim` (內聯提示)
*   `joshuavial/aider.nvim` (AI 代碼輔助)
*   `onsails/lspkind.nvim` (LSP 補全圖標)
*   `hrsh7th/nvim-cmp` (自動補全引擎)
*   `L3MON4D3/LuaSnip` (代碼片段引擎)
*   `seandewar/nvimesweeper` (掃雷遊戲)
*   `jim-fx/sudoku.nvim` (數獨遊戲)
*   `tamton-aquib/duck.nvim` (趣味插件)
