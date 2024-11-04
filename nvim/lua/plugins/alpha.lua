return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                                                  ",
      "                 |    |    |                      ",
      "                )_)  )_)  )_)                     ",
      "               )___))___))___)\\                  ",
      "              )____)____)_____)\\\\               ",
      "            _____|____|____|____\\\\\\__          ",
      "   --^-----\\                          /-----^-^- ",
      "     ^^^^^       ^^^^^^^^^^^^^^^^^^^^^            ",
      "       ^^^^      ^^^^     ^^^    ^^               ",
      "             ^^^^      ^^^                        ",
      "                                                  "
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("q", "󱫯", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
