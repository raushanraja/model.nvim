if vim.g.did_setup_model then
  return
end

vim.filetype.add({
  extension = {
    mchat = 'markdown',
  },
})

require('model').setup()
