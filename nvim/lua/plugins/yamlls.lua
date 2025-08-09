return {
  "neovim/nvim-lspconfig",
  dependencies = { "b0o/SchemaStore.nvim" },
  opts = {
    servers = {
      yamlls = {
        settings = {
          yaml = {
            -- Pull all YAML schemas from SchemaStore + add AWS SAM manually
            schemas = vim.tbl_extend(
              "force",
              require("schemastore").yaml.schemas(),
              {
                -- AWS SAM / CloudFormation schema for these files
                ["https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json"] = {
                  "template.cfn.yaml",
                  "template.yaml",
                },
              }
            ),
            customTags = {
              "!And scalar",
              "!And sequence",
              "!If scalar",
              "!If sequence",
              "!Not scalar",
              "!Not sequence",
              "!Equals scalar",
              "!Equals sequence",
              "!Or scalar",
              "!Or sequence",
              "!FindInMap scalar",
              "!FindInMap sequence",
              "!Base64 scalar",
              "!Cidr scalar",
              "!Ref scalar",
              "!Ref sequence",
              "!Sub scalar",
              "!Sub sequence",
              "!GetAtt scalar",
              "!GetAtt sequence",
              "!GetAZs scalar",
              "!ImportValue scalar",
              "!ImportValue sequence",
              "!Select scalar",
              "!Select sequence",
              "!Split scalar",
              "!Split sequence",
              "!Join scalar",
              "!Join sequence",
            },
          },
        },
      },
    },
  },
}
