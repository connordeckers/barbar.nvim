--- @type bufferline.functions
local methods = require("bufferline.functions")

local helpers = {
	with_prop = function(method, prop, default)
		return function(args)
			method(args[prop] or default)
		end
	end,
}

helpers.with_count = function(method, default)
	return helpers.with_prop(method, "count", default)
end

--- @class bufferline.commands
--- All command keys will be prefixed by 'Buffer'
local commands = {
	["Next"] = {
		action = helpers.with_count(methods.next),
		args = { count = true, desc = "Go to the next buffer" },
	},

	["Previous"] = {
		action = helpers.with_count(methods.previous),
		args = { count = true, desc = "Go to the previous buffer" },
	},

	["Goto"] = {
		action = helpers.with_prop(methods.index, "args", 1),
		args = { desc = "Go to the buffer at the specified index", nargs = 1 },
	},

	["First"] = { action = methods.first, args = { desc = "Go to the first buffer" } },
	["Last"] = { action = methods.last, args = { desc = "Go to the last buffer" } },

	["Move"] = {
		action = helpers.with_count(methods.move.previous),
		args = { count = true, desc = "Synonym for `:BufferMovePrevious`" },
	},

	["MoveNext"] = {
		action = helpers.with_count(methods.move.next),
		args = { count = true, desc = "Move the current buffer to the right" },
	},

	["MovePrevious"] = {
		action = helpers.with_count(methods.move.previous),
		args = { count = true, desc = "Move the current buffer to the left" },
	},

	["MoveStart"] = {
		action = methods.move.start,
		args = { desc = "Move current buffer to the front" },
	},

	["Pick"] = {
		action = methods.pick,
		args = { desc = "Pick a buffer" },
	},

	["Pin"] = {
		action = methods.pin,
		args = { desc = "Un/pin a buffer" },
	},

	["OrderByBufferNumber"] = {
		action = methods.order_by.buf_number,
		args = { desc = "Order the bufferline by buffer number" },
	},

	["OrderByDirectory"] = {
		action = methods.order_by.directory,
		args = { desc = "Order the bufferline by directory" },
	},

	["OrderByLanguage"] = {
		action = methods.order_by.lang,
		args = { desc = "Order the bufferline by language" },
	},

	["OrderByWindowNumber"] = {
		action = methods.order_by.win_number,
		args = { desc = "Order the bufferline by window number" },
	},

	["Close"] = {
		action = methods.close.this,
		args = { bang = true, complete = "buffer", desc = "Close the current buffer.", nargs = "?" },
	},

	["Delete"] = {
		action = methods.close.this,
		args = { bang = true, complete = "buffer", desc = "Synonym for `:BufferClose`", nargs = "?" },
	},

	["CloseAllButCurrent"] = {
		action = methods.close.all_but_current,
		args = { desc = "Close every buffer except the current one" },
	},

	["CloseAllButVisible"] = {
		action = methods.close.all_but_visible,
		args = { desc = "Close every buffer except those in visible windows" },
	},

	["CloseAllButPinned"] = {
		action = methods.close.all_but_pinned,
		args = { desc = "Close every buffer except pinned buffers" },
	},

	["CloseAllButCurrentOrPinned"] = {
		action = methods.close.all_but_current_or_pinned,
		args = { desc = "Close every buffer except pinned buffers or the current buffer" },
	},

	["CloseBuffersLeft"] = {
		action = methods.close.buffers_left,
		args = { desc = "Close all buffers to the left of the current buffer" },
	},

	["CloseBuffersRight"] = {
		action = methods.close.buffers_right,
		args = { desc = "Close all buffers to the right of the current buffer" },
	},

	["ScrollLeft"] = {
		action = helpers.with_count(methods.scroll.left),
		args = { count = true, desc = "Scroll the bufferline left" },
	},

	["ScrollRight"] = {
		action = helpers.with_count(methods.scroll.right),
		args = { count = true, desc = "Scroll the bufferline right" },
	},
}

return commands
