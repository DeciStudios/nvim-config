local M = {}

local function run_in_horizontal_terminal(cmd)
	local terminals = require("configs.ui.terminal")
	terminals.horizontal:toggle()

	local term = terminals.horizontal.term
	if term and term.job_id then
		local full_cmd = cmd .. " && exit\n"
		vim.fn.chansend(term.job_id, full_cmd)
	else
		vim.notify("Terminal not ready", vim.log.levels.WARN)
	end
end
local function run_command(cmd)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "modifiable", true)

	vim.cmd("botright split")
	vim.api.nvim_win_set_buf(0, buf)
	local win = vim.api.nvim_get_current_win()

	local function close_window()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	-- Allow easy closing with 'q' or 'Enter'
	vim.keymap.set("n", "q", close_window, { buffer = buf, nowait = true, silent = true })
	vim.keymap.set("n", "<CR>", close_window, { buffer = buf, nowait = true, silent = true })

	vim.fn.jobstart(cmd, {
		stdout_buffered = false,
		stderr_buffered = false,
		on_stdout = function(_, data)
			if not data then
				return
			end
			local clean = {}
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(clean, line)
				end
			end
			if #clean > 0 then
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, clean)
			end
		end,
		on_stderr = function(_, data)
			if not data then
				return
			end
			local clean = {}
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(clean, line)
				end
			end
			if #clean > 0 then
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, clean)
			end
		end,
		on_exit = function()
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "[Process finished – press q or Enter to close]" })
		end,
	})
end

M.tasks = {
	n = {
		["<leader>ro"] = {
			function()
				run_command({ "odin", "run", "." })
			end,
			"Run Odin project",
		},
		["<leader>bo"] = {
			function()
				run_command({ "odin", "build", "." })
			end,
			"Build Odin project",
		},
		["<leader>rl"] = {
			function()
				run_command({ "love", "." })
			end,
			"Run Love2D project",
		},
		["<leader>bl"] = {
			function()
				run_command({
					"sh",
					"-c",
					"rm -f build.love && zip -9 -r build.love . -x build.love -x .git/**\\* -x .gitignore",
				})
			end,
			"Build Love2D project (.love)",
		},
		["<leader>bp"] = {
			function()
				local sdk = os.getenv("PLAYDATE_SDK_PATH") or "~/PlaydateSDK"
				run_command({ sdk .. "/bin/pdc", ".", "build.pdx" })
			end,
			"Build Playdate project (.pdx)",
		},

		["<leader>rp"] = {
			function()
				local sdk = os.getenv("PLAYDATE_SDK_PATH") or "~/PlaydateSDK"
				-- first build, then run in simulator
				run_command({
					"sh",
					"-c",
					string.format("%s/bin/pdc . build.pdx && %s/bin/PlaydateSimulator build.pdx", sdk, sdk),
				})
			end,
			"Run Playdate project",
		},
	},
}

return M
