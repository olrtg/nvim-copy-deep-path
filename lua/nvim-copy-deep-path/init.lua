local M = {}

function M.copy()
	local ft = vim.bo.filetype

	if ft ~= "json" and ft ~= "yaml" then
		vim.notify("Not a JSON/YAML file", vim.log.levels.ERROR)
		return
	end

	local node_types = {
		json = {
			pair = "pair",
			string = "string_content",
		},
		yaml = {
			pair = "block_mapping_pair",
			string = "plain_scalar",
		},
	}

	local node = vim.treesitter.get_node()
	assert(node, "No node found")

	---@type string[]
	local keys = {}

	while node do
		if node:type() == node_types[ft].pair then
			for _, child in ipairs(node:field("key")) do
				while child do
					local deep_child = child:named_child(0)

					if deep_child == nil then
						break
					end

					if deep_child:type() == node_types[ft].string then
						table.insert(keys, vim.treesitter.get_node_text(deep_child, 0))
					end

					child = deep_child
				end
			end
		end

		node = node:parent()
	end

	local path = table.concat(vim.fn.reverse(keys), ".")
	vim.fn.setreg("+", path)
end

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("CopyJsonPath", M.copy, {})
end

return M
