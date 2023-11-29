
local popup = require("plenary.popup")

local Win_id

local ColorNames = {}

local M = {}

-- from https://dev.to/____marcell/how-to-create-an-ui-menu-in-neovim-2k6a
function ShowMenu(title, opts, cb)
  local height = 20
  local width = 30

  Win_id = popup.create(opts, {
        title = title,
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        callback = cb,
  })
  for _, color_name in ipairs(ColorNames) do
    vim.fn.matchadd(color_name, "^" .. color_name .. "$", 10, -1, {window=Win_id});
  end

  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent=false })
end

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
end

M.setup = function(opts)
  local colors = {
    -- default colors
    { fg = "#f39c12" },
    { fg = "#f1c40f" },
    { fg = "#1abc9c" },
    { fg = "#2980b9" },
    { fg = "#9b59b6" },
    { fg = "#c0392b" },
    { fg = "#fad7a0" },
    { fg = "#d98880" },
    { fg = "#d7bde2" },
    { fg = "#85c1e9" },
    { fg = "#117a65" },
    { fg = "#9a7d0a" },
  }

  if opts and (opts.colors ~= nil) then
    colors = opts.colors
  end

  for idx, color_def in ipairs(colors) do
    local color_name = string.format("BuntColor%d", idx)
    table.insert(ColorNames, color_name)
    vim.api.nvim_set_hl(0, color_name, color_def)
    idx = idx + 1
  end
end


M.highlight_search = function()
  local search_pattern = vim.fn.getreg("/")
  local curr_win_id = vim.fn.win_getid()
  ShowMenu("Select Color", ColorNames, function(_, sel)
    vim.fn.matchadd(sel, search_pattern, 10, -1, {window=curr_win_id});
  end)
end

return M

