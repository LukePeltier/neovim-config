return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    prompt_logger = {
      enabled = true,
      log_dir = vim.fn.stdpath 'cache' .. '/avante_prompts',
    },
    provider = 'bedrock',
    providers = {
      bedrock = {
        model = 'us.anthropic.claude-sonnet-4-20250514-v1:0',
        aws_profile = 'PedroAWS',
        aws_region = 'us-west-2',
      },
      ['bedrock_opus'] = {
        __inherited_from = 'bedrock',
        model = 'us.anthropic.claude-opus-4-1-20250805-v1:0',
        aws_profile = 'PedroAWS',
        aws_region = 'us-west-2',
      },
    },
    input = {
      provider = 'snacks',
      provider_opts = {
        title = 'Avante Input',
        icon = ' ',
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
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
