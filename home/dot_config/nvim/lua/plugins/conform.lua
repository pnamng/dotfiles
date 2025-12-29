return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        sh = { "shfmt" },
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
        php = { "pint" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      notify_on_error = true,
      -- formatters = {
      --   php = {
      --     command = "php-cs-fixer",
      --     args = {
      --       "fix",
      --       "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
      --       "$FILENAME",
      --     },
      --     stdin = false,
      --   },
      -- },
    })
  end,
}
