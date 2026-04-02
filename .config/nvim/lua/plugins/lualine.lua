return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      -- theme = 'gruvbox_dark',
      theme = 'codedark',
    },
    tabline = {
      lualine_a = {'buffers'},
      lualine_c = {},
      lualine_x = {
        { 'filename', path = 2 },
      },
      lualine_y = {},
      lualine_z = {'tabs'}
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
};
