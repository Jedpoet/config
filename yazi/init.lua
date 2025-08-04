require("git"):setup()

require("full-border"):setup()

require("starship"):setup({
    -- Hide flags (such as filter, find and search). This is recommended for starship themes which
    -- are intended to go across the entire width of the terminal.
    hide_flags = false,                               -- Default: false
    -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
    flags_after_prompt = true,                        -- Default: true
    -- Custom starship configuration file to use
    config_file = "~/.config/starship/starship.toml", -- Default: nil
})

require("yaziline"):setup({
    color = "#81A1C1",                --"#98c379",
    secondary_color = "#5A6078",
    default_files_color = "darkgray", -- color of the file counter when it's inactive
    selected_files_color = "white",
    yanked_files_color = "green",
    cut_files_color = "red",

    separator_style = "angly", -- "angly" | "curvy" | "liney" | "empty"
    separator_open = "",
    separator_close = "",
    separator_open_thin = "",
    separator_close_thin = "",
    separator_head = " ", -- "",
    separator_tail = " ", -- "",

    select_symbol = "",
    yank_symbol = "󰆐",

    filename_max_length = 24,     -- truncate when filename > 24
    filename_truncate_length = 6, -- leave 6 chars on both sides
    filename_truncate_separator = "..."
})

require("eza-preview"):setup({
    -- Set the tree preview to be default (default: true)
    default_tree = true,

    -- Directory depth level for tree preview (default: 3)
    level = 3,

    -- Follow symlinks when previewing directories (default: false)
    follow_symlinks = false,

    -- Show target file info instead of symlink info (default: false)
    dereference = false,

    -- Show hidden files (default: true)
    all = true
})
