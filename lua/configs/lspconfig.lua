local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lspconfig = require("lspconfig")
local opts = { noremap = true, silent = true }

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "clangd",
    "pyright",
}

-- list of servers configured with default config.
-- Anything you add here now must be added to the above table as well.
local default_servers = {
    "pyright",
}

-- lsps with default config: servers that are preset by nvchad under the hood.
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

lspconfig.clangd.setup({
    -- on_attach = function(client, bufnr)
    -- Noe's addition for opening a definintion in a vsplit window
    on_attach = function(client, bufnr)
        vim.keymap.set('n', 'gv', function() vim.cmd([[vsplit]]) vim.lsp.buf.definition() end, opts)

        -- Here we disable the clangd's formater as we are going to do our own in
        -- conform.lua
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            -- Noe's addition
            completion = {
                callSnippet = "Replace"
            },
            -- This part in face is linting. So keeping it to false means that we won't use
            -- the language server's own linter but an external module.
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

-- Noe's addition
-- lspconfig.pyright.setup({
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--     filetypes = "python",
-- })
