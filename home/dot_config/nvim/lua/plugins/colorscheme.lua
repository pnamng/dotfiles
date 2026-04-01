return {
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 1
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.g.background = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
