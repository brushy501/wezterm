local term = require("wezterm")

local M = {}

function M.options(config)
	config.use_fancy_tab_bar = false
	config.status_update_interval = 1000
	config.tab_max_width = 9999
	config.hide_tab_bar_if_only_one_tab = false
	config.allow_win32_input_mode = true
	config.tab_bar_at_bottom = true

	local function get_current_terminal_app(pane)
		local process = pane:get_foreground_process_name()
		return process
	end

	-- all the icons to represent the terminal cli applications
	local title_icon = {
		cmd = term.nerdfonts.cod_terminal_cmd .. "  ",
		wezterm = term.nerdfonts.cod_terminal .. "  ",
		pwsh = term.nerdfonts.md_powershell .. "  ",
		starship = term.nerdfonts.cod_rocket .. "  ",
		nvim = term.nerdfonts.custom_neovim .. "  ",
		zoxide = term.nerdfonts.md_folder_table .. "  ",
		ssh = term.nerdfonts.md_ssh .. "  ",
		Debug = term.nerdfonts.cod_debug .. "  ",
		Launcher = term.nerdfonts.md_launch .. "  ",
		["musikcube-cmd"] = term.nerdfonts.md_music .. "  ",
		fzf = term.nerdfonts.md_file_search_outline .. "  ",
		bash = term.nerdfonts.cod_terminal_bash .. "  ",
		python = term.nerdfonts.md_language_python .. "  ",
		lua = term.nerdfonts.md_language_lua .. "  ",
		git = term.nerdfonts.md_git .. "  ",
		go = term.nerdfonts.dev_go .. "  ",
		Default = " ",
	}

	function basename(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	term.on("update-right-status", function(window, pane)
		-- workspace name
		local stat = window:active_workspace()
		if stat == "Home" then
			stat = ""
		else
			stat = term.nerdfonts.dev_terminal_badge
		end

		local cmd = get_current_terminal_app(pane)
		local result = ""
		if cmd then
			result = basename(cmd)
			result = result:gsub(".exe", "")
			if result == "musikcube-cmd" then
				result = term.nerdfonts.md_music
			end
		else
			result = term.nerdfonts.dev_terminal_badge
		end

		-- Display the workspace name
		if window:active_key_table() then
			stat = window:active_key_table()
		end

		-- Get the current time
		local time = term.strftime("%a %b %-d %H:%M")

		local bat = ""
		for _, b in ipairs(term.battery_info()) do
			bat = "🔋" .. string.format("%.0f%%", b.state_of_charge * 100)
		end

		window:set_right_status(term.format({
			{ Text = term.nerdfonts.oct_table .. " " .. stat },
			{ Text = " | " },
			{ Text = term.nerdfonts.oct_terminal .. " " .. result },
			{ Text = " | " },
			{ Text = bat .. " " },
			{ Text = " | " },
			{ Text = term.nerdfonts.md_clock .. " " .. time .. " " },
		}))
	end)

	-- This function returns the suggested title for a tab.
	-- It prefers the title that was set via `tab:set_title()`
	-- or `wezterm cli set-tab-title`, but falls back to the
	-- title of the active pane in that tab.
	local function tab_title(tab_info)
		local title = tab_info.tab_title
		-- if the tab title is explicitly set, take that
		if title and #title > 0 then
			title = title:gsub("\\", " ")
			return title
		end
		-- Otherwise, use the title from the active pane
		-- in that tab
		title = tab_info.active_pane.title
		title = title:gsub("\\", " ")
		title = title:gsub(".exe", "")
		return title
	end

	term.on("format-tab-title", function(tab)
		--print(title_icon)

		local title_name = tab_title(tab)
		--[[ print(title_name) ]]
		if string.len(title_name) >= 20 then
			title_name = string.sub(title_name, 1, 20) .. "..."
		end

		for index, icon in pairs(title_icon) do
			if index == title_name then
				print("Index is " .. index .. " and icon is " .. icon)
				return " " .. icon .. title_name .. "  "
			elseif index == "musikcube-cmd" then
				return " " .. icon .. title_name .. " "
			end
		end
	end)
end

return M
