-- Get aws credentials from 'aws' command
local function get_credentials(name)
  local result = vim.system({ 'aws', 'configure', 'export-credentials', '--profile', 'PedroAWS' }, { text = true }):wait(10000)

  local credentials = vim.json.decode(result.output)

  if name == 'AccessKeyId' then
    return credentials.AccessKeyId
  end

  if name == 'SecretAccessKey' then
    return credentials.SecretAccessKey
  end

  if name == 'SessionToken' then
    return credentials.SessionToken
  end

  return ''
end

-- Parse bedrock streaming response into format expected by regular anthropic adapter
local function parse_bedrock_stream(chunk)
  local decoded_chunks = {}
  for bedrock_data_match in chunk:gmatch 'event(%b{})' do
    local ok, json_data = pcall(vim.json.decode, bedrock_data_match)
    if ok and json_data.bytes then
      local decoded_data = vim.base64.decode(json_data.bytes)
      table.insert(decoded_chunks, decoded_data)
    end
  end
  return decoded_chunks
end

-- Success marker from upstream anthropic adapter
local STATUS_SUCCESS = 'success'

-- Merge content strings
local function merge_content(target, source)
  if not source or source == '' then
    return target
  end
  return (target or '') .. source
end

-- Merge dicts of type { content: str, signature: str }
local function merge_reasoning(target, source)
  if not source then
    return target
  end
  target = target or { content = nil, signature = nil }
  target.content = merge_content(target.content, source.content)
  target.signature = merge_content(target.signature, source.signature)
  return target
end

return {
  'olimorris/codecompanion.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-treesitter/nvim-treesitter' },
  },
  keys = {
    {
      '<leader>at',
      '<cmd>CodeCompanionChat Toggle<CR>',
      desc = 'CodeCompanion Chat Toggle',
    },
    {
      '<leader>ao',
      '<cmd>CodeCompanionActions<CR>',
      mode = { 'n', 'v' },
      desc = 'CodeCompanion Action Palette',
    },
    {
      '<leader>ae',
      ':CodeCompanion ',
      mode = { 'n', 'v' },
      desc = 'CodeCompanion Inline',
    },
  },
  opts = {
    adapters = {
      http = {
        opts = {
          show_model_choices = true,
        },
        bedrock = function()
          local anthropic = require 'codecompanion.adapters.http.anthropic'

          ---@class Bedrock.Adapter: CodeCompanion.Adapter
          return require('codecompanion.adapters').extend('anthropic', {
            name = 'bedrock',
            formatted_name = 'Bedrock',
            url = 'https://bedrock-runtime.${aws_region}.amazonaws.com/model/${model}/${endpoint}',
            env = {
              aws_access_key_id = function()
                return get_credentials 'AccessKeyId'
              end,
              aws_region = 'schema.region.default',
              aws_secret_access_key = function()
                return get_credentials 'SecretAccessKey'
              end,
              aws_session_token = function()
                return get_credentials 'SessionToken'
              end,
              endpoint = function(self)
                if self.opts.stream then
                  return 'invoke-with-response-stream'
                else
                  return 'invoke'
                end
              end,
              model = 'schema.model.default',
            },
            headers = {
              ['x-amz-security-token'] = '${aws_session_token}',
            },
            raw = {
              '--aws-sigv4',
              'aws:amz:${aws_region}:bedrock',
              '--user',
              '${aws_access_key_id}:${aws_secret_access_key}',
            },
            handlers = {
              setup = function(_)
                return true
              end,
              tokens = function(self, data)
                local total_tokens = 0
                if self.opts.stream then
                  for _, message in ipairs(parse_bedrock_stream(data)) do
                    total_tokens = total_tokens + (anthropic.handlers.tokens(self, message) or 0)
                  end
                else
                  total_tokens = anthropic.handlers.tokens(self, data)
                end
                return total_tokens
              end,
              chat_output = function(self, data, tools)
                if not self.opts.stream then
                  return anthropic.handlers.chat_output(self, data, tools)
                end

                local output = { role = nil, reasoning = nil, content = nil }
                local chunks = parse_bedrock_stream(data)
                if not chunks or #chunks == 0 then
                  return { status = STATUS_SUCCESS, output = output }
                end

                for _, message in ipairs(chunks) do
                  local part = anthropic.handlers.chat_output(self, message, tools)
                  if not part then
                    goto continue
                  end

                  -- Handle error status
                  if part.status ~= STATUS_SUCCESS then
                    return { status = part.status, output = output }
                  end

                  -- Merge successful response data
                  if part.output then
                    output.role = output.role or part.output.role
                    output.reasoning = merge_reasoning(output.reasoning, part.output.reasoning)
                    output.content = merge_content(output.content, part.output.content)
                  end

                  ::continue::
                end
                return {
                  status = STATUS_SUCCESS,
                  output = output,
                }
              end,
            },
            schema = {
              model = {
                mapping = 'temp',
                default = 'us.anthropic.claude-3-7-sonnet-20250219-v1:0',
                choices = {
                  ['us.anthropic.claude-sonnet-4-20250514-v1:0'] = { opts = { can_reason = true, has_vision = true } },
                  ['us.anthropic.claude-3-7-sonnet-20250219-v1:0'] = { opts = { can_reason = true, has_vision = true } },
                },
              },
              region = {
                type = 'string',
                default = 'us-west-2',
                desc = 'AWS region',
                choices = {
                  'us-east-1',
                  'us-east-2',
                  'us-west-1',
                  'us-west-2',
                },
              },
              anthropic_version = {
                mapping = 'parameters',
                type = 'string',
                optional = false,
                default = 'bedrock-2023-05-31',
                desc = 'Bedrock anthropic API version',
              },
            },
          })
        end,
        azure_openai = function()
          -- Emit an autocmd event before returning the adapter
          return require('codecompanion.adapters').extend('azure_openai', {
            env = {
              api_key = os.getenv 'AZURE_OPENAI_API_KEY',
              endpoint = os.getenv 'AZURE_OPENAI_ENDPOINT',
              api_version = '2025-01-01-preview',
            },
            schema = {
              model = {
                default = 'gpt-4.1',
                choices = {
                  'gpt-4.1',
                  'gpt-4.1-mini',
                },
              },
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = 'anthropic',
      },
      inline = {
        adapter = 'anthropic',
      },
    },
  },
}
