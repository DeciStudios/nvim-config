-- Initialize M once
local M = {}

local nav = require("mappings.nav")
local ui = require("mappings.ui")
local settings = require("mappings.settings")
local editing = require("mappings.editing")
local help = require("mappings.help")
local ai = require("mappings.ai")
local notes = require("mappings.notes")
require("mapper").setup(nav, ui, notes, ai, settings, editing, help)
