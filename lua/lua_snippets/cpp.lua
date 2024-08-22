local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Function to read the content of a file
local function read_file(filepath)
  local file = io.open(filepath, "r")
  if not file then
    print("Could not open file: " .. filepath)
    return {}
  end
  local content = file:read("*all")
  file:close()
  return vim.split(content, "\n")
end

-- Specify the path to your C++ template file
local cpp_template_path = vim.fn.expand("~/cpp_templates/template.cpp");

-- Read the content of the C++ template file
local cpp_template = read_file(cpp_template_path)

ls.add_snippets("cpp", {
  s("cpp", {
    -- Insert the content of the C++ template file into the snippet
    t(cpp_template),
    i(1)
  }),
})
