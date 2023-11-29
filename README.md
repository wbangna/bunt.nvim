# Bunt

## setup

With defaults:
```lua
require("bunt").setup()
```

Set own colors:
```lua
require("bunt").setup({
    { fg = "#f39c12" },
    { fg = "#f1c40f" },
    { fg = "#1abc9c" },
    { fg = "#2980b9" },
    { fg = "#9b59b6" },
    { fg = "#c0392b" },
  })
```


## highlight current search pattern

```
require("bunt").highlight_search()
```

## dependencies

`nvim-lua/plenary.nvim`
