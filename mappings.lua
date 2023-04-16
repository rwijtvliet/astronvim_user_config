local utils = require "astronvim.utils"
local is_available = utils.is_available
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
maps = {
  [""] = {    
    ["n"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'j' : 'gj'", expr = true, desc = "Move cursor down" }, 
    ["t"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'k' : 'gk'", expr = true, desc = "Move cursor up" },
    -- ["n"] = { "v:count ? 'j' : 'gj'", expr = true, desc = "Move cursor down" },
    -- ["t"] = { "v:count ? 'k' : 'gk'", expr = true, desc = "Move cursor up" },
    ["s"] = { "l", desc = "Move right"},
    ["K"] = { "T", desc = "Till (backward)" },
    ["l"] = { "n", desc = "Next search result", },
    ["L"] = { "N", desc = "Prev search result", },
    ["j"] = { "s", desc = "Substitute character", },
    ["k"] = { "t", desc = "Till (forward)", },
  },
  -- first key is the mode
  n = {
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
  i = {

  },
  v = {}
}
-- Move lines.
maps.n["<A-t>"] = { "<cmd>m .-2<CR>==", desc = "Move line up"}
maps.n["<A-n>"] = { "<cmd>m .+1<CR>==", desc = "Move line down"}
maps.i["<A-t>"] = { "<Esc><cmd>m .-2<CR>==gi", desc = "Move line up"}
maps.i["<A-n>"] = { "<Esc><cmd>m .+1<CR>==gi", desc = "Move line down"}
maps.v["<A-t>"] = { ":m '<-2<CR>gv=gv", desc = "Move line(s) up"} -- TODO: not working
maps.v["<A-n>"] = { ":m '>+1<CR>gv=gv", desc = "Move line(s) down"} -- TODO: not working
-- Move between splits.
if is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-n>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-t>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-s>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-n>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-t>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-s>"] = { "<C-w>l", desc = "Move to right split" }
end


return maps
