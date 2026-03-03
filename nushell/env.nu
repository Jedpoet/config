# env.nu
#
# Installed by:
# version = "0.107.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

zoxide init nushell | save -f ~/.zoxide.nu

let cargo_bin = ("~" | path expand | path join ".cargo" "bin")
$env.PATH = ($env.PATH | prepend $cargo_bin | uniq)

# 先定義 nvim 的路徑
let nvim_path = "/opt/nvim-linux-x86_64/bin"

# 檢查該路徑是否存在（只有在 WSL/Linux 下才會是 true），存在才加入 PATH
if ($nvim_path | path exists) {
    $env.PATH = ($env.PATH | prepend $nvim_path)
}
