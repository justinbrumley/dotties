return {
  "olimorris/codecompanion.nvim",
  version = "17.33.0",
  dependencies = {
    "j-hui/fidget.nvim", -- Display status
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "DEEPSEEK_API_KEY",
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = "deepseek", },
        inline = { adapter = "copilot" },
        agent = { adapter = "deepseek" },
      },
    })
  end,
  init = function()
    -- vim.cmd([[cab cc CodeCompanion]])
    require("plugins.custom.spinner"):init()
  end,
}
