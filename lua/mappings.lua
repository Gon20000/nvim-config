require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- CompetiTest
map('n', "<Leader>tb", ":CompetiTest run<CR>", {desc = "Compile and run current file."})
map('n', "<Leader>tr", ":CompetiTest run_no_compile<CR>", {desc = "Run current file without compiling."})
map('n', "<Leader>ta", ":CompetiTest add_testcase<CR>", {desc = "Add a new testcase."})
map('n', "<Leader>td", ":CompetiTest delete_testcase ", {desc = "Remove a testcase."})
map('n', "<Leader>te", ":CompetiTest edit_testcase ", {desc = "Edit an existing testcase."})
map('n', "<Leader>ts", ":CompetiTest show_ui<CR>", {desc = "Re-open the ui with no actions."})
map('n', "<Leader>tt", ":CompetiTest receive testcases<CR>", {desc = "Download a problem's testcases."})
map('n', "<Leader>tp", ":CompetiTest receive problem<CR>", {desc = "Download a problem along with testcases."})
map('n', "<Leader>tc", ":CompetiTest receive contest<CR>", {desc = "Download a contest's problems."})

-- local dap = require("dap")

-- config path for lua snippets
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    -- some options
    local opts = {buffer = ev.buf}
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if(client == nil) then
      return
    end

    if client.supports_method("textDocument/codeAction") then
      map({"n", "v"}, "<space>ca", function ()
        vim.lsp.buf.code_action();
      end, vim.tbl_extend('keep', {desc = "Show code actions"}, opts));
    end
  end
})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
