#!/bin/bash

# 遇到錯誤就停止執行腳本
set -e

# 確保在根目錄執行
cd ~

echo "開始初始化 Ubuntu 開發環境..."

# 更新系統並安裝基礎編譯工具包 (這對於後續編譯程式非常重要)
echo "正在更新 apt 套件庫與安裝基礎套件..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential pkg-config libssl-dev xclip python3-pip python3-venv unzip


echo "Git 設定完成！"

# 安裝 Rust 開發環境
if ! command -v cargo &> /dev/null; then
    echo "正在安裝 Rust 工具鏈..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    rustup component add rust-analyzer
else
    echo "Rust 已經安裝"
fi

if ! command --version gh &> /dev/null; then
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
else
    echo "gh 已經安裝"
fi

# 安裝 Node.js 環境
if ! command -v node &> /dev/null; then
    echo "正在安裝 Node.js (LTS 版本)..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "Node.js 已經安裝"
fi

# 安裝 nvim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
if ! command -v nvim &> /dev/null; then
    echo "正在安裝 neovim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
else
    echo "neovim 已經安裝"
fi

# 安裝 Zellij
if ! command -v zellij &> /dev/null; then
    echo "正在安裝 Zellij..."
    # 既然已經裝了 Rust，直接用 cargo 安裝最穩
    cargo install zellij --locked
else
    echo "Zellij 已經安裝"
fi

# 安裝 Yzai

if ! command -v yazi &> /dev/null; then
    echo "正在安裝 yazi"
    sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
    git clone https://github.com/sxyazi/yazi.git
    cd yazi
    cargo build --release --locked
    sudo mv target/release/yazi target/release/ya /usr/local/bin/
    cd ..
    sudo rm -r yazi
else
    echo "yazi 已經安裝"
fi

# 安裝 serie(git log 可視化工具)

if ! command -V serie &> /dev/null; then
    cargo install --locked serie
else
    echo "serie 已經安裝"
fi

# 安裝 delta （git diff 美化）

if ! command -V delta &> /dev/null; then
    cargo install --locked git-delta
else
    echo "delta 已經安裝"
fi

# 安裝 bat（cat 的rust版）
if ! command -V bat &> /dev/null; then
    cargo install --locked bat
else
    echo "bat 已經安裝"
fi

# 安裝 python
if ! command -V python3 &> /dev/null; then
    sudo apt install python3
else
    echo "python3 已經安裝"
fi

# 安裝 uv
if ! command -V uv &> /dev/null; then
    cargo install --locked uv
else
    echo "uv 已經安裝"
fi

# 安裝 zoxide
if ! command -V zoxide &> /dev/null; then
    cargo install --locked zoxide
else
    echo "zoxide 已經安裝"
fi

# 安裝 lazygit
if ! command -v lazygit &> /dev/null; then
    sudo apt install lazygit
else
    echo "lazygit 已經安裝"
fi

# 安裝 gitui
if ! command -V gitui &> /dev/null; then
    cargo install --locked gitui
else
    echo "gitui 已經安裝"
fi


# 安裝 nushell
if ! command -v nu &> /dev/null; then
    echo "正在透過 Cargo 安裝 Nushell..."
    # 使用 cargo 安裝可以確保拿到針對你這台機器編譯的最佳化版本
    cargo install nu --locked
else
    echo "Nushell 已經安裝"
fi

# 將 Nushell 加入系統的合法 shell 清單
if ! grep -q "$(which nu)" /etc/shells; then
    echo "正在將 Nushell 加入 /etc/shells..."
    command -v nu | sudo tee -a /etc/shells
    echo "正在切換預設 Shell 為 Nushell..."
    sudo chsh -s "$(which nu)" "$USER"
fi

# 建立軟連結 (Symlink) 將你的 .config 檔對應到正確位置
echo "正在配置 dotfiles..."
# 假設你的 github repo clone 在 ~/dotfiles
ln -sf ~/config ~/.config

# --- Git 基礎設定 ---
echo "正在設定 Git 全域環境..."

# 設定你的開發者名稱與信箱
git config --global user.name "jadepoet0231"
git config --global user.email "jadepoet0231@gmail.com" # 請記得把這裡換成你真實的信箱

# 現代 Git 的良好預設習慣
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "nvim" # 既然裝了 Neovim，當然要設為預設編輯器
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3

# (選用) 讓終端機裡的 git log 變得超好看的 alias
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

echo "檢查 SSH 金鑰狀態..."

# 1. 檢查是否已經存在密鑰，沒有才生成
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "未找到 SSH 金鑰，正在自動生成新的 ed25519 金鑰..."
    # 加上 -N "" 代表預設不設密碼，-f 指定路徑，這樣就能跳過所有詢問，全自動生成
    ssh-keygen -t ed25519 -C "jadepoet0231@gmail.com" -N "" -f ~/.ssh/id_ed25519
    # 將金鑰加入 agent (將錯誤訊息導向黑洞，避免重複加入時報錯干擾畫面)
    ssh-add ~/.ssh/id_ed25519
    echo -e "\n========================================="
    echo "你的 GitHub SSH 公鑰如下："
    cat ~/.ssh/id_ed25519.pub
    echo "========================================="
    echo "👉 請確認已將上述公鑰複製至 GitHub (Settings -> SSH and GPG keys)！"
else
    echo "SSH 金鑰已存在，安全跳過生成步驟。"
fi

# 2. 檢查 ssh-agent 是否已經在背景執行，沒有才啟動
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi


echo "🎉 環境建置完成！請重新啟動終端機"
