local function has_pedro_aws_profile()
  local aws_config_path = vim.fn.expand '~/.aws/config'
  if vim.fn.filereadable(aws_config_path) == 0 then
    return false
  end

  local content = vim.fn.readfile(aws_config_path)
  for _, line in ipairs(content) do
    if line:match '%[profile PedroAWS%]' then
      return true
    end
  end
  return false
end

local provider = has_pedro_aws_profile() and 'bedrock' or 'claude'

return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    prompt_logger = {
      enabled = true,
      log_dir = vim.fn.stdpath 'cache' .. '/avante_prompts',
    },
    provider = provider,
    providers = {
      bedrock = {
        model = 'us.anthropic.claude-sonnet-4-20250514-v1:0',
        aws_profile = 'PedroAWS',
        aws_region = 'us-west-2',
      },
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-sonnet-4-20250514',
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
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
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
