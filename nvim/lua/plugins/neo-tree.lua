return {
        "nvim-neo-tree/neo-tree.nvim",
        filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true},
        },
        branch = "v3.x",
        dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>')
            vim.keymap.set('n', '<leader>vn', ':vertical split <CR> <C-w>l :Neotree filesystem reveal left<CR>')
        end
    }
