-- YAML schema support for serverless.yml and AWS CloudFormation
return {
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = "yaml",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = false }, -- We don't need k8s schemas
        cloud_init = { enabled = false },
      },
      schemas = {
        {
          name = "Serverless Framework",
          uri = "https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json",
        },
        {
          name = "AWS CloudFormation",
          uri = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json",
        },
        {
          name = "AWS SAM",
          uri = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json",
        },
      },
      lspconfig = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json"] = "serverless.yml",
              ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "*template.{yml,yaml}",
              ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json"] = "sam.{yml,yaml}",
            },
            validate = true,
            completion = true,
            hover = true,
            format = {
              enable = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("yaml-companion").setup(opts)
      
      -- Integrate with telescope
      require("telescope").load_extension("yaml_schema")
    end,
  },
}
