require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'bower_components',
      'static/plugins',
    },
    prompt_prefix = '   ',
    selection_caret = ' ',
    entry_prefix = ' ',
    sorting_strategy = 'descending',
    layout_config = {
      horizontal = {
        prompt_position = 'bottom',
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  extensions = {
    fzf = {},
  },
}

-- Enable telescope extensions, if they are installed
pcall(require('telescope').load_extension, 'fzf')
