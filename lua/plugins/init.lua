local merge = require('utils.merge')
local ui = require('plugins.ui')
local formatting = require('plugins.formatting')
local lsp = require('plugins.lsp')
local theming = require('plugins.theming')
local ai = require('plugins.ai')
local libs = require('plugins.libs')
local fun = require('plugins.fun')
local media = require('plugins.media')
local mapping = require('plugins.mapping')
local plugs = merge(libs, ui, formatting, lsp, theming, ai, mapping, media, fun)




require("lazy").setup(
    plugs
)
