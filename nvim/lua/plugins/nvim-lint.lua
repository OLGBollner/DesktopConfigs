return {
  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
      }

      -- log only if linter actually runs
      local orig_try_lint = require("lint").try_lint
      require("lint").try_lint = function(names, opts)
        local targets = names or require("lint")._resolve_linter_by_ft(vim.bo.filetype)
        if type(targets) == "string" then
          targets = { targets }
        elseif type(targets) ~= "table" then
          targets = {}
        end

        if #targets > 0 then
          -- print("Starting linters: " .. table.concat(targets, ", ")) -- 🔹 comment out
          return orig_try_lint(names, opts)
        end
      end

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Run linters" })
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
    keys = {
      { "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format file" },
    },
  }
}
