require("telescope").setup({
  defaults = {
    layout_stategy = "horizontal",
    layout_config = {
      width = 0.7,
      prompt_position = "top"
    }
  }
})

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>ss", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
