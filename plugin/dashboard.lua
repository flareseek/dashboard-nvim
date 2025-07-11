-- version 0.2.3

local g = vim.api.nvim_create_augroup('dashboard', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = g,
  callback = function()
    for _, v in pairs(vim.v.argv) do
      if v == '-' then
        vim.g.read_from_stdin = 1
        break
      end
    end
  end,
})

vim.api.nvim_create_autocmd('UIEnter', {
  group = g,
  callback = function()
    if
      vim.fn.argc() == 0
      and vim.api.nvim_buf_get_name(0) == ''
      and vim.g.read_from_stdin == nil
    then
      require('dashboard'):instance()
    end
  end,
})

vim.api.nvim_create_user_command('Dashboard', function()
  require('dashboard'):instance()
end, {})
