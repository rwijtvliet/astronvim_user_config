local utils = require "astronvim.utils"
local is_available = utils.is_available
-- Remappings that work everywhere
---- navigation
vim.api.nvim_set_keymap("", "t", "k", {desc = "Move cursor up"})
vim.api.nvim_set_keymap("", "n", "j", {desc = "Move cursor dwn"})
vim.api.nvim_set_keymap("", "s", "l", {desc = "Move cursor rght"})
---- capitals of navigation
vim.api.nvim_set_keymap("", "T", "K", {desc = "Help"})
vim.api.nvim_set_keymap("", "S", "L", {desc = "Move cursor to bottom of screen"})
---- reverse mappings
vim.api.nvim_set_keymap("", "l", "n", {desc = "Next search result"})
vim.api.nvim_set_keymap("", "L", "N", {desc = "Prev search result"})
vim.api.nvim_set_keymap("", "j", "s", {desc = "Substitute character"})
vim.api.nvim_set_keymap("", "k", "t", {desc = "Till (forward)"})
vim.api.nvim_set_keymap("", "K", "T", {desc = "Till (backward)"})
-- Remappings that work in normal mode
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {desc = "Move to buffer on left"})
vim.api.nvim_set_keymap("n", "<C-t>", "<C-w>k", {desc = "Move to buffer above"})
vim.api.nvim_set_keymap("n", "<C-n>", "<C-w>j", {desc = "Move to buffer below"})
vim.api.nvim_set_keymap("n", "<C-s>", "<C-w>l", {desc = "Move to buffer on right"})
-- if is_available "smart-splits.nvim" then
--   vim.api.nvim_set_keymap("n", "<C-h>", {function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" })
--   vim.api.nvim_set_keymap("n", "<C-n>", {function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" })
--   vim.api.nvim_set_keymap("n", "<C-t>", { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" })
--   vim.api.nvim_set_keymap("n", "<C-s>", { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" })
-- else
--   vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>j", { desc = "Move to left split" })
--   vim.api.nvim_set_keymap("n", "<C-n>", "<C-w>j", { desc = "Move to below split" })
--   vim.api.nvim_set_keymap("n", "<C-t>", "<C-w>k", { desc = "Move to above split" })
--   vim.api.nvim_set_keymap("n", "<C-s>", "<C-w>l", { desc = "Move to right split" })
-- end

vim.api.nvim_set_option("equalalways", true) -- make windows same width when closing one

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  --
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}


