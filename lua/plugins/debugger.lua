return {
  "mfussenegger/nvim-dap",
  dependencies = {"rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio"},
  lazy = false,
  config = function ()
    -- Set up nvim-dap
    local dap = require('dap')

    -- Set up nvim-dap-ui
    local dapui = require("dapui")
    dapui.setup()

    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = '/home/gon/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',

    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
          {
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false
          },
        },
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        setupCommands = {
          {
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false
          },
        },
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }
    -- Automatically open DAP UI when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    -- Automatically close DAP UI when debugging ends
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local map = vim.keymap.set
    map('n', '<F5>', dap.continue, {})
    map('n', '<F9>', dap.step_over, {})
    map('n', '<F11>', dap.step_into, {})
    map('n', '<F12>', dap.step_out, {})
    map('n', '<F6>', dap.run_to_cursor, {});
    --   map('n', '<leader>b', dap.toggle_breakpoint, {})
    --   -- map('n', '<leader>B', dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')), {})
    --   -- map('n', '<leader>lp', dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')), {})
    --   map('n', '<leader>dr', dap.repl.open, {})
    --   map('n', '<leader>dl', dap.run_last, {})
  end
}
