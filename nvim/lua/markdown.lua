vim.g.mkdp_auto_start = 0

vim.g.mkdp_auto_close = 1

vim.g.mkdp_images_path = '~/blog'

vim.g.mkdp_markdown_css = ''

--[[
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  command = "Mtm",
})
--]]

vim.api.nvim_create_autocmd("User", {
  pattern = "TableModeRealign",
  command = [[silent! %s/| \zs\ze |/<++>/g]],
})
