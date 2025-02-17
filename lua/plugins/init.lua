local merge = require('utils.merge')
local ui = require('plugins.ui')
local fs = require('plugins.fs')
local git = require('plugins.git')
local lsp = require('plugins.lsp')
local theming = require('plugins.theming')
local ai = require('plugins.ai')

local plugs = merge(ui, fs, git, lsp, theming, ai)


require("lazy").setup(
    plugs
)
