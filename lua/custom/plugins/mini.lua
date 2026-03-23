-- mini.nvim: Collection of small independent plugins/modules.
-- Modules enabled:
--   mini.ai        - Extended a/i textobjects (around/inside function args, quotes, etc.)
--   mini.splitjoin  - Toggle between single-line and multi-line statements (gS)
--   mini.align      - Align text interactively (ga in visual mode)
--   mini.surround   - Add/delete/replace surroundings (parentheses, quotes, tags, etc.)
--   mini.bracketed  - Jump forward/backward by various targets using [/] brackets
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Extended textobjects for a (around) and i (inside) motions.
    -- Examples:
    --   va)  - visually select around parentheses
    --   yinq - yank inside next quote
    --   ci'  - change inside quotes
    require('mini.ai').setup { n_lines = 500 }

    -- Toggle single-line <-> multi-line: gS on a line or selection
    require('mini.splitjoin').setup()

    -- Align text: ga in visual mode, then enter delimiter (e.g. = or |)
    require('mini.align').setup()

    -- Surround operations using gs prefix:
    --   gsa{motion}{char} - add surrounding (e.g. gsaiw" wraps word in quotes)
    --   gsd{char}         - delete surrounding (e.g. gsd" removes surrounding quotes)
    --   gsr{old}{new}     - replace surrounding (e.g. gsr"' changes " to ')
    --   gsf{char}         - find next surrounding
    --   gsF{char}         - find previous surrounding
    --   gsh{char}         - highlight surrounding
    --   gsn               - update search range (n_lines)
    require('mini.surround').setup {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    }

    -- Bracket-based navigation: [b/]b (buffers), [d/]d (diagnostics),
    -- [q/]q (quickfix), [t/]t (treesitter), etc.
    require('mini.bracketed').setup {
      undo = { suffix = '' }, -- disable undo navigation: conflicts with u and <C-r>
    }
  end,
}
