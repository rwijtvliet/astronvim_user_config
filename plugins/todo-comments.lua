return {
  "folke/todo-comments.nvim",
  event = "UIEnter",
  requires = "nvim-lua/plenary.nvim",
  config = function() require("todo-comments").setup {} end,
}
