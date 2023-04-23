local utils = require "astronvim.utils"
local is_available = utils.is_available
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
maps = {
  [""] = {    
    -- navigation
    ["n"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'j' : 'gj'", expr = true, desc = "Move cursor down" }, 
    ["t"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'k' : 'gk'", expr = true, desc = "Move cursor up" },
    ["s"] = { "l", desc = "Move right"},
    ["S"] = { "L", desc = "Move cursor to bottom of screen"},
  },
  -- first key is the mode
  n = {
    -- search
    ["l"] = { "n", desc = "Next search result" },
    ["L"] = { "N", desc = "Prev search result" },
    -- move till word
    ["k"] = { "t", expr = false, noremap = true, desc = "Till (forward)" }, -- expr = false needed to override astrovim mapping for k
    ["K"] = { "T", desc = "Till (backward)" },
    -- substitute
    ["j"] = { "s", expr = false, noremap = true, desc = "Substitute character" }, -- expr = false needed to override astrovim mapping for k
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- Move between buffers
    ["<A-s>"] = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
    ["<A-h>"] = { function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer"},
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    -- Change find actions to follow symlinks
    ["<leader>fF"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true , follow=true} end,
      desc = "Find all files",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" , "-L"}) end,
        }
      end,
      desc = "Find words in all files",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {

  },
  v = {
    [">"] = {">gv", desc = "Increase indentation (visual mode)"},
    ["<"] = {"<gv", desc = "Decrease indentation (visual mode)"},
    ["p"] = {'"_dP', desc = "Don't replace register when pasting in visual mode"}
  }
}
-- Move lines.
maps.n["<A-t>"] = { "<cmd>m .-2<CR>==", desc = "Move line up"}
maps.n["<A-n>"] = { "<cmd>m .+1<CR>==", desc = "Move line down"}
maps.i["<A-t>"] = { "<Esc><cmd>m .-2<CR>==gi", desc = "Move line up"}
maps.i["<A-n>"] = { "<Esc><cmd>m .+1<CR>==gi", desc = "Move line down"}
maps.v["<A-t>"] = { ":m .-2<CR>==", desc = "Move line(s) up"} 
maps.v["<A-n>"] = { ":m .+1<CR>==", desc = "Move line(s) down"}
for _,mode in ipairs({'n', 'i', 'v'}) do
  maps[mode]["<A-Up>"] = maps[mode]["<A-t>"]
  maps[mode]["<A-Down>"] = maps[mode]["<A-n>"]
end
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
