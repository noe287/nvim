local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    -- python = { "flake8" },
    python = { "pylint" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}
lint.linters.pylint.args = {
    "--max-line-length=100",
    -- "--ignore=E701,W191,E402",
}

-- Causes a lot of flake8 instances to run and keep the cpu busy all the time
-- lint.linters.flake8.args = {
--     "--max-line-length=100",
--     -- "--ignore=E701,W191,E402",
-- }
--
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
