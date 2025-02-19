-- Initialize M once
local M = {}

local nav = require("mappings.nav")
local ui = require("mappings.ui")
local settings = require("mappings.settings")
local editing = require("mappings.editing")
local help = require("mappings.help")

require("mapper").setup(nav, ui, settings, editing, help)
