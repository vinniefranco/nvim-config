local lsp = require('lsp-zero')
local luasnip = require("luasnip")

require("nvim-autopairs").setup({
  check_ts = true
})

lsp.preset('recommended')

lsp.skip_server_setup({"rust_analyzer"})

lsp.ensure_installed({
  "tsserver",
  "eslint",
  "elixirls",
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

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

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

lsp.nvim_workspace()
lsp.setup()

local rt = require("rust-tools")
local rust_lsp = lsp.build_options("rust_analyzer", {
  on_attach = function(_, bufnr)
        -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end
})
rt.setup({server = rust_lsp})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)

    local format_cmd = function(input)
      vim.lsp.buf.format({
        id = client.id,
        timeout_ms = 5000,
        async = input.bang,
      })
    end

    local bufcmd = vim.api.nvim_buf_create_user_command
    bufcmd(bufnr, 'NullFormat', format_cmd, {
      bang = true,
      range = true,
      desc = 'Format using null-ls'
    })
  end,
  sources = {
    --- Replace these with the tools you have installed
    null_ls.builtins.formatting.prettier,
  }
})

