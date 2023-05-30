local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local maps = {
  [""] = {
    -- navigation
    ["h"] = { "h", desc = "Move left" },
    ["n"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'j' : 'gj'", expr = true, desc = "Move down" },
    ["t"] = { "v:count == 0 || mode(1)[0:1] == 'no' ? 'k' : 'gk'", expr = true, desc = "Move up" },
    ["s"] = { "l", desc = "Move right" },
    ["S"] = { "L", desc = "Move cursor to bottom of screen" },
    -- search
    ["l"] = { "n", desc = "Next search result" },
    ["L"] = { "N", desc = "Prev search result" },
    -- leap
    ["m"] = { "<Plug>(leap-forward-to)", desc = "Leap forward to match" },
    ["M"] = { "<Plug>(leap-backward-to)", desc = "Leap backward to match" },
    ["gm"] = { "<Plug>(leap-from-window)", desc = "Leap to match in other window" },
    -- move begining/end of line
    ["B"] = { "^", desc = "Move to beginning of line" },
    ["E"] = { "$", desc = "Move to end of line" },
    -- set mark
    ["<A-m>"] = { "m", desc = "Set marker" },
    -- move till word
    ["k"] = { "t", expr = false, noremap = true, desc = "Till (forward)" }, -- expr = false needed to override astrovim mapping for k
    ["K"] = { "T", noremap = true, desc = "Till (backward)" },
  },

  -- first key is the mode
  n = {
    -- substitute
    ["j"] = { "s", expr = false, noremap = true, desc = "Substitute character" }, -- expr = false needed to override astrovim mapping for j
    -- Neotest
    ["<leader>T"] = { desc = get_icon("Testing", 1, true) .. "Test" },
    ["<leader>Ta"] = { function() require("neotest").run.attach() end, desc = "Attach" },
    ["<leader>Tf"] = { function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
    ["<leader>TF"] = {
      function() require("neotest").run.run { vim.fn.expand "%", strategy = "dap" } end,
      desc = "Debug File",
    },
    ["<leader>Tl"] = { function() require("neotest").run.run_last() end, desc = "Run Last" },
    ["<leader>TL"] = { function() require("neotest").run.run_last { strategy = "dap" } end, desc = "Debug Last" },
    ["<leader>Tn"] = { function() require("neotest").run.run() end, desc = "Run Nearest" },
    ["<leader>TN"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug Nearest" },
    ["<leader>To"] = { function() require("neotest").output.open { enter = true } end, desc = "Output" },
    ["<leader>TS"] = { function() require("neotest").run.stop() end, desc = "Stop" },
    ["<leader>Ts"] = { function() require("neotest").summary.toggle() end, desc = "Summary" },
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- Move between buffers
    ["<A-s>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<A-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!end, desc = "Save File" },  -- change description but the same command
    -- Change find actions to follow symlinks
    ["<leader>fF"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true, follow = true } end,
      desc = "Find all files",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore", "-L" }) end,
        }
      end,
      desc = "Find words in all files",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {},
  v = {
    [">"] = { ">gv", desc = "Increase indentation (visual mode)" },
    ["<"] = { "<gv", desc = "Decrease indentation (visual mode)" },
    ["p"] = { '"_dP', desc = "Don't replace register when pasting in visual mode" },
  },
}
-- Move lines.
maps.n["<A-t>"] = { "<cmd>m .-2<CR>==", desc = "Move line up" }
maps.n["<A-n>"] = { "<cmd>m .+1<CR>==", desc = "Move line down" }
maps.i["<A-t>"] = { "<Esc><cmd>m .-2<CR>==gi", desc = "Move line up" }
maps.i["<A-n>"] = { "<Esc><cmd>m .+1<CR>==gi", desc = "Move line down" }
maps.v["<A-t>"] = { ":m .-2<CR>==", desc = "Move line(s) up" }
maps.v["<A-n>"] = { ":m .+1<CR>==", desc = "Move line(s) down" }
for _, mode in ipairs { "n", "i", "v" } do
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
