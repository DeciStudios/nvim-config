local M = {}
local cmp = require("cmp")

M.copilot = {
	n = {
		["<leader>gcc"] = {
			function()
				require("CopilotChat").open()
			end,
			"Open Copilot chat",
		},
		["<leader>gco"] = {
			function()
				require("copilot").toggle()
			end,
			"Toggle Copilot",
		},
		["<leader>gci"] = {
			function()
				require("CopilotChat").open({
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end,
			"Open Copilot inline chat",
		},
		["<leader>gcs"] = {
			function()
				require("configs.ai.copilotchat_save_load_win").open_window(true)
			end,
			"Save Copilot chat",
		},
		["<leader>gcl"] = {
			function()
				require("configs.ai.copilotchat_save_load_win").open_window(false)
			end,
			"Load Copilot chat",
		},
		["<leader>gcn"] = {
			function()
				require("configs.ai.copilotchat_save_load_win").new_chat()
			end,
			"New Copilot chat",
		},
	},
}

return M
