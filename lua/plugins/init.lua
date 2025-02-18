local merge = require('utils.merge')
local ui = require('plugins.ui')
local formatting = require('plugins.formatting')
local lsp = require('plugins.lsp')
local theming = require('plugins.theming')
local ai = require('plugins.ai')
local libs = require('plugins.libs')
local plugs = merge(ui, formatting, lsp, theming, ai, libs)




require("lazy").setup(
    plugs
)
