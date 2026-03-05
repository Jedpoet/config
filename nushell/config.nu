# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# --- Basic Settings ---
$env.config.buffer_editor = "neovide"
$env.config.show_banner = false
$env.config.edit_mode = "vi"
# $env.config.table.mode = "psql"
$env.config.rm.always_trash = true
$env.config.completions.algorithm = "fuzzy"
$env.PROMPT_INDICATOR_VI_INSERT = "❯ "
$env.PROMPT_INDICATOR_VI_NORMAL = "❮ "
$env.config.color_config.bool = {|x| if $x { 'light_green' } else { 'light_red' } }

# --- alias ---
alias la = ls -a
alias nvide = neovide
alias vim = nvim
alias lg = lazygit
alias cat = bat
alias gt = gitui
alias zl = zellij
alias 'git log' = serie

# --- StarShip ---
$env.STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# --- Key Bindings ---
# $env.config.keybindings ++= [
#     {
#         name: insert_last_token
#         modifier: alt
#         keycode: char_.
#         mode: [emacs vi_normal vi_insert]
#         event: [
#             { edit: InsertString, value: "!$" } # 插入上一個命令的最後一個參數
#         ]
#     }
# ]

# --- Plugins ---

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]

# --- zoxide ---
source ~/.zoxide.nu

# --- yazi ---
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# --- vim ---
def nvd [...prompt_parts: string] {
    let file = ($prompt_parts | str join "")
    if $file == "" {
        job spawn {neovide}
        return
    }
    job spawn {neovide $file} 
}

# think init
def tinit [] {
    mkdir notes
    "# 執行區\n\n*當前專注點*：\n\n# 代辦區\n\n -[ ] \n\n# 思考區\n- " | save notes/BRAIN.md
    touch notes/complete.md
    print "✅ 思考流專案初始化完成：已建立 BRAIN.md 與 complete.md"
}
def think [] {
    mut current_dir = $env.PWD
    mut root_dir = ""

    # 1. 向上尋找專案根目錄 (判斷基準為 BRAIN.md 或 .git)
    while $current_dir != "/" {
        if ($"($current_dir)/notes/BRAIN.md" | path exists) or ($"($current_dir)/.git" | path exists) {
            $root_dir = $current_dir
            break
        }
        $current_dir = ($current_dir | path dirname)
    }

    # 2. 如果找不到根目錄，攔截並詢問使用者
    if $root_dir == "" {
        print "❌ 錯誤：找不到專案根目錄 (缺少 BRAIN.md 或 .git)。"
        let response = (input $"❓ 要在當前目錄 ($env.PWD) 執行 tinit 建立思考流架構嗎？ [y/N]: ")

        if $response =~ '^[yYeEsS]*[yY]$' {
            tinit
            $root_dir = $env.PWD
        } else {
            print "🚫 已取消啟動。"
            return
        }
    }

    # 3. 切換到正確的根目錄，並啟動 Zellij
    cd $root_dir
    print $"🚀 切換至專案根目錄: ($root_dir)"
    print "啟動 Zellij 思考流..."

    zellij --layout think
}

# --- Gemini CLI Helper ---
# 用法: g 你的任務描述
# 範例: g 列出所有 .toml 檔案
def g [...prompt_parts: string] {
    # 將所有傳入的參數組合成一個字串
    let prompt = ($prompt_parts | str join " ")
    if ($prompt | is-empty) {
        print "錯誤：請提供要執行的任務。"
        return
    }

    let full_prompt = ($"產生一個 Nushell 指令來完成以下任務：" | append $prompt | append "。只輸出指令本身，不要包含任何說明、解釋或程式碼區塊標記。") | str join " "
    echo $full_prompt | gemini
}
# source $"($nu.home-path)/.cargo/env.nu"
