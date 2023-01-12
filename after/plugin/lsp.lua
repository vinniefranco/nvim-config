local lsp = require('lsp-zero')
local luasnip = require("luasnip")

require("nvim-autopairs").setup({
  check_ts = true
})

lsp.preset('recommended')

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "sumneko_lua"
})

lsp.configure("sumeko_lua", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})


local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Better mappings
local cmp = require("cmp")
cmp.setup({
  sources = {
    {
      name = 'path',
    },
  },
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<CR>"] = cmp.mapping.confirm({ select = false }),
  ["<C-g>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end)
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
end)

lsp.setup()

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({async = false})]]
