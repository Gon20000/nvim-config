return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  lazy = false,
  config = function()
    require('competitest').setup ({
      compile_command = {
        cpp = {
          exec = "g++",
          args = {
            -- "-fdiagnostics-color=always",
            "-g",
            "$(FNAME)",
            "-o",
            "$(FNOEXT)",
            "-Wsign-conversion",
            "-std=c++2a",
            "-fsanitize=address"
          }
        }
      },

      run_command = {
        cpp = { exec = "./$(FNOEXT)" },
      },

      runner_ui = {
        -- I like it more :)
        interface = "split",
      },

      split_ui = {
        total_width = 0.4,
        -- does nothing probably:
        -- horizontal_layout = {
        --   { 2, "tc" },
        --   { 3, {
        --     { 1, "so" },
        --     { 1, "eo" },
        --   } },
        --   { 4, {
        --     { 1, "si" },
        --     { 3, "se" },
        --   } },
        -- },
        --
        vertical_layout = {
          { 2, "tc" },
          { 3, {
            { 1, "so" },
            { 1, "eo" },
          } },
          { 3, {
            { 2, "si" },
            { 1, "se" },
          } }
        }
      },

      view_output_diff = true,
      received_problems_path = function(task, file_extension)
        local name = string.gsub(task.name, "%s", "_")
        return string.format("%s/%s.%s", vim.fn.getcwd(), name, file_extension)
      end
    })
  end,
}
