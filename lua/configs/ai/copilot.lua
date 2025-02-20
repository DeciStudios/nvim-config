local add_source = require("configs.formatting.cmp.add_source")
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 150,
		keymap = {
			accept = "<Tab>",
			dismiss = "<C-]>",
			next = false, -- we'll handle this through cmp
			prev = false, -- we'll handle this through cmp
		},
	},
	filetypes = {
		markdown = true,
		help = false,
		gitcommit = false,
		gitrebase = false,
		["."] = false,
	},
})
add_source({ name = "copilot", group_index = 2 })
