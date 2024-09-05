return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  opts = {
    filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
  },
  config = function(_, opts)
    local ufo = require 'ufo'

    -- Configure ufo
    ufo.setup(opts)

    -- Autocmd for detaching ufo for excluded filetypes
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
      pattern = opts.filetype_exclude,
      callback = function()
        ufo.detach()
      end,
    })

    -- Set fold level start
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.opt.foldlevelstart = 99

    -- Toggle fold with 'z<Enter>' for all folds at the first level
    --
    local folded = false
    vim.keymap.set('n', 'z<CR>', function()
      if folded then
        -- Open all folds
        ufo.openAllFolds()
      else
        -- Close all folds at the first level
        ufo.closeFoldsWith(1)
      end
      folded = not folded
    end, { noremap = true, silent = true, desc = 'Toggle fold all functions at first level' })

    -- Map 'zc' to toggle folds
    vim.keymap.set('n', 'zc', 'za', { noremap = true, silent = true })

    -- Map '<CR>' to open folds if they exist
    vim.keymap.set('n', '<CR>', 'zo', { noremap = true, silent = true })

    -- Map 'zB' to close all folds
  end,
}
