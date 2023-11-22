
local M = {}

M.setup = function()
  vim.api.nvim_set_hl(0, "BuntColor1", { fg = "#992222" })
end

M.highlight_search = function()
  local search_pattern = vim.fn.getreg("/")
  vim.fn.matchadd("BuntColor1", search_pattern);
end


return M

