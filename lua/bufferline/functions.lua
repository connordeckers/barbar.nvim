local get_current_buf = vim.api.nvim_get_current_buf

--- @type bufferline.api
local api = require("bufferline.api")

--- @type bbye
local bbye = require("bufferline.bbye")

--- @type bufferline.render
local render = require("bufferline.render")

--- @type bufferline.state
local state = require("bufferline.state")

--- @class bufferline.functions
local fn = {
	-- Enable barbar.nvim
	enable = render.enable,

	-- Disable barbar.nvim
	disable = render.disable,

	-- Pick a buffer
	pick = api.pick_buffer,

	-- Un/pin a buffer
	pin = api.toggle_pin,

	-- Go to the next buffer
	--- @param count integer
	next = function(count)
		api.goto_buffer_relative(math.max(1, count or 1))
	end,

	-- Go to the previous buffer
	--- @param count integer
	previous = function(count)
		api.goto_buffer_relative(math.max(1, count or 1) * -1)
	end,

	-- Go to the buffer at the specified index
	--- @param index integer
	index = function(index)
		api.goto_buffer(tonumber(index or 1) or 1)
	end,

	-- Reorder the bufferline
	order_by = {
		-- Order the bufferline by buffer number
		buf_number = api.order_by_buffer_number,

		-- Order the bufferline by window number
		win_number = api.order_by_window_number,

		-- Order the bufferline by directory
		directory = api.order_by_directory,

		-- Order the bufferline by language
		lang = api.order_by_language,
	},

	move = {
		-- Move the current buffer to the right
		--- @param count integer
		next = function(count)
			api.move_current_buffer(math.max(1, count or 1))
		end,

		-- Move the current buffer to the left
		--- @param count integer
		previous = function(count)
			api.move_current_buffer(math.max(1, count or 1) * -1)
		end,

		-- Move current buffer to the front
		start = function()
			api.move_current_buffer_to(1)
		end,
	},

	close = {
		-- Close every buffer except the current one
		all_but_current = api.close_all_but_current,

		-- Close every buffer except those in visible windows
		all_but_visible = api.close_all_but_visible,

		-- Close every buffer except pinned buffers
		all_but_pinned = api.close_all_but_pinned,

		-- Close every buffer except pinned buffers or the current buffer
		all_but_current_or_pinned = api.close_all_but_current_or_pinned,

		-- Close all buffers to the left of the current buffer
		buffers_left = api.close_buffers_left,

		-- Close all buffers to the right of the current buffer
		buffers_right = api.close_buffers_right,

		-- Close the current buffer.
		this = function(params)
			local focus_buffer = state.find_next_buffer(get_current_buf())
			params = vim.tbl_deep_extend("force", { focus_next = true }, params or {})
			bbye.bdelete(
				params.bang,
				params.args,
				params.smods or params.mods,
				params.focus_next and focus_buffer or nil
			)
		end,

		-- Wipe out the buffer
		wipeout = function(params)
			bbye.bwipeout(params.bang, params.args, params.smods or params.mods)
		end,
	},

	scroll = {
		-- Scroll the bufferline left
		--- @param count integer
		left = function(count)
			render.scroll(math.max(1, count or 1) * -1)
		end,

		-- Scroll the bufferline right
		--- @param count integer
		right = function(count)
			render.scroll(math.max(1, count or 1))
		end,
	},
}

-- Go to the first buffer
fn.first = function()
	return fn.index(1)
end

-- Go to the last buffer
fn.last = function()
	return fn.index(-1)
end

return fn
