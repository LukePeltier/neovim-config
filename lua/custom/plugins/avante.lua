return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = 'bedrock',
    behaviour = {
      enable_cursor_planning_mode = true,
    },
    providers = {
      bedrock = {
        model = 'us.anthropic.claude-sonnet-4-20250514-v1:0',
        aws_profile = 'PedroAWS',
        aws_region = 'us-west-2',
      },
      azure = {
        endpoint = os.getenv 'AZURE_OPENAI_ENDPOINT',
        deployment = 'o4-mini', -- your desired model (or use gpt-4o, etc.)
        timeout = 60000,
        extra_request_body = {
          temperature = 1,
          max_completion_tokens = 20480, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = 'medium', -- low|medium|high, only used for reasoning models
        },
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'stevearc/dressing.nvim', -- for input provider dressing
    'folke/snacks.nvim', -- for input provider snacks
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
