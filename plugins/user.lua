return {
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "max397574/better-escape.nvim",
    opts = { timeout = 300, mapping = {"hh", "ht"},  }
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"
      -- We use extend_tbl to merge the base config with the new options, to avoid overriding
      return require("astronvim.utils").extend_tbl(opts, {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = false,
              ["<C-k>"] = false,
              ["<C-t>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-h>"] = actions.cycle_history_prev,
              ["<C-s>"] = actions.cycle_history_next,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["t"] = actions.move_selection_previous,
              ["n"] = actions.move_selection_next,
              ["<C-t>"] = false,
              ["<C-n>"] = false,
              ["<C-h>"] = actions.cycle_history_prev,
              ["<C-s>"] = actions.cycle_history_next,
            }
          }
        }
      })
    end,
  },
  { 
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        window = {
          mappings = {
            ["<A-h>"] = "prev_source",
            ["<A-s>"] = "next_source",
            ["l"] = false,
            ["s"] = "child_or_open",
            ["n"] = "", 
            ["t"] = "",
            ["<"] = false,
            [">"] = false,
            ["_"] = "open_tabnew",
            ["|"] = "open_vsplit",
            ["\\"] = "open_split",
          },
        },
      })
    end,
  },
  -- colorschemes
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require('catppuccin').setup {}
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    as = 'gruvbox',
    config = function()
      require('gruvbox').setup {
        contrast = 'hard'
      }
    end,
  }
  --   config = function()
  --   
  --     local actions = require "telescope.actions"
  --     return {
  --       pickers = {find_files = {follow = true, hidden = true}},
  --       mappings = {
  --         i = {
  --
  --         },
  --         n = {
  --          ["t"] = actions.move_selection_previous,
  --           ["n"] = actions.move_selection_next,
  --         }
  --       }
  --     }
  --   end
  -- }
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
