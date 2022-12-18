local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

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
