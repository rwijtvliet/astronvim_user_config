-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- n, t, s: dvorak navigation
    ["n"] = { "v:count ? 'j' : 'gj'", expr = true, desc = "Move cursor down" },
    ["t"] = { "v:count ? 'k' : 'gk'", expr = true, desc = "Move cursor up" },
    ["s"] = { "l", desc = "Move cursor right"},
    -- N, T, S: 
    ["S"] = { "L", desc = "Move to screen bottom"},
    -- TODO: T and N and Control+...

    -- j, k, l: remap to default actions for n, t, s
    ["l"] = { "t", desc = "Jump to before next occurance of character"}, 
    ["L"] = { "T", desc = "Jump to after prev occurance of character"},

    ["k"] = { "s", desc = "Delete character and substitute text"},
    ["K"] = { "S", desc = "Delete line and substitute text"},

    ["j"] = { "n", desc = "Repeat search forward"},
    ["J"] = { "N", desc = "Repeat search backward"},
    
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
