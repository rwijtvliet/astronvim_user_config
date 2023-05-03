return {
   "ellisonleao/gruvbox.nvim",
    as = 'gruvbox',
  event='UIEnter',
    config = function()
      require('gruvbox').setup {
        contrast = '',
      dim_inactive=true,
      italic = {
        strings = false
      },
      }
    end,
  }
