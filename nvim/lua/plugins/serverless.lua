-- Serverless Framework integration
-- Commands for deploy, invoke, logs, and offline
return {
  -- Create serverless commands using toggleterm
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Extend existing opts
      return opts
    end,
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- AWS region configuration
      local aws_region = "eu-west-2"

      -- Create serverless commands
      vim.api.nvim_create_user_command("ServerlessDeploy", function()
        local cmd = string.format("AWS_REGION=%s serverless deploy", aws_region)
        require("toggleterm").exec(cmd, 5)
      end, { desc = "Deploy serverless application" })

      vim.api.nvim_create_user_command("ServerlessInvoke", function(opts)
        local func_name = opts.args
        if func_name == "" then
          func_name = vim.fn.input("Function name: ")
        end
        if func_name ~= "" then
          local cmd = string.format("AWS_REGION=%s serverless invoke local -f %s", aws_region, func_name)
          require("toggleterm").exec(cmd, 6)
        end
      end, { nargs = "?", desc = "Invoke function locally" })

      vim.api.nvim_create_user_command("ServerlessLogs", function(opts)
        local func_name = opts.args
        if func_name == "" then
          func_name = vim.fn.input("Function name: ")
        end
        if func_name ~= "" then
          local cmd = string.format("AWS_REGION=%s serverless logs -f %s --tail", aws_region, func_name)
          require("toggleterm").exec(cmd, 7)
        end
      end, { nargs = "?", desc = "Tail function logs" })

      vim.api.nvim_create_user_command("ServerlessOffline", function()
        local cmd = "serverless offline"
        require("toggleterm").exec(cmd, 8)
      end, { desc = "Start serverless offline" })

      vim.api.nvim_create_user_command("ServerlessInfo", function()
        local cmd = string.format("AWS_REGION=%s serverless info", aws_region)
        require("toggleterm").exec(cmd, 9)
      end, { desc = "Show deployment info" })

      vim.api.nvim_create_user_command("ServerlessRemove", function()
        local confirm = vim.fn.input("Remove serverless stack? (yes/no): ")
        if confirm == "yes" then
          local cmd = string.format("AWS_REGION=%s serverless remove", aws_region)
          require("toggleterm").exec(cmd, 10)
        end
      end, { desc = "Remove serverless stack" })
    end,
    keys = {
      {
        "<leader>sd",
        "<cmd>ServerlessDeploy<cr>",
        desc = "Serverless deploy",
      },
      {
        "<leader>si",
        "<cmd>ServerlessInvoke<cr>",
        desc = "Serverless invoke",
      },
      {
        "<leader>sl",
        "<cmd>ServerlessLogs<cr>",
        desc = "Serverless logs",
      },
      {
        "<leader>so",
        "<cmd>ServerlessOffline<cr>",
        desc = "Serverless offline",
      },
      {
        "<leader>sI",
        "<cmd>ServerlessInfo<cr>",
        desc = "Serverless info",
      },
    },
  },
}
