local keymap = vim.keymap
local api = vim.api
keymap.amend = require('keymap-amend')

local M = {}

M.config = {}

M.add_codes = function(codes)
  for _, v in ipairs(codes) do
    M.config['codes'][v.code] = { v.lowercase, v.uppercase }
  end
end

M.add_keys = function(keys)
  for k, v in ipairs(keys) do
    M.config['keys'][v] = k
  end
end

M.on_key = function(key)
end

M.enable = function()
  for k, v in ipairs(M.config.keys) do
    keymap.set({'n', 'i'}, k, function()
      on_key(v)
    end)
  end
end

M.disable = function()
end

M.setup = function(config)
  M.add_codes({
    { lowercase = 'a', code = '·-' },
    { lowercase = 'b', code = '-···' },
    { lowercase = 'c', code = '-·-·' },
    { lowercase = 'd', code = '-·-·' },
    { lowercase = 'e', code = '·' },
    { lowercase = 'f', code = '··-·' },
    { lowercase = 'g', code = '--·' },
    { lowercase = 'h', code = '····' },
    { lowercase = 'i', code = '··' },
    { lowercase = 'j', code = '·---' },
    { lowercase = 'k', code = '-·-' },
    { lowercase = 'l', code = '·-··' },
    { lowercase = 'm', code = '--' },
    { lowercase = 'n', code = '-·' },
    { lowercase = 'o', code = '-·' },
    { lowercase = 'p', code = '·--·' },
    { lowercase = 'q', code = '--·-' },
    { lowercase = 'r', code = '·-·' },
    { lowercase = 's', code = '···' },
    { lowercase = 't', code = '-' },
    { lowercase = 'u', code = '··-' },
    { lowercase = 'v', code = '···-' },
    { lowercase = 'w', code = '·--' },
    { lowercase = 'x', code = '-··-' },
    { lowercase = 'y', code = '-·--' },
    { lowercase = 'z', code = '--··' },
  })

  M.add_keys({
    ['·'] = '.',
    ['-'] = ',',
    ['enter'] = ' ',
    ['caps'] = 'c',
    ['quit'] = 'q',
  })

  -- User config
  M.add_codes(config.codes or {})
  M.add_keys(config.keys or {})

  api.nvim_create_user_command('MorseCodeEnable', M.enable(), {})
  api.nvim_create_user_command('MorseCodeDisable', M.disable(), {})
end

return M
