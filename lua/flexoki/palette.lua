local options = require("flexoki.config").options

local variants = {
	moon = {
		_nc = "#1f1d30",
		base = "#100f0f",
		surface = "#1f1d2e",
		overlay = "#1c1b1a",
		muted = "#575653",
		subtle = "#878580",
		text = "#cecdc3",
		yellow_one = "#ad8301",
		red_one = "#af3029",
		orange_one = "#bc5215",
		magenta_one = "#a02f6f",
		blue_one = "#205ea6",
		cyan_one = "#24837b",
		purple_one = "#5e409d",
		green_one = "#66800b",
		yellow_two = "#d0a215",
		red_two = "#d14d41",
		orange_two = "#da702c",
		magenta_two = "#ce5d97",
		blue_two = "#4385be",
		cyan_two = "#3aa99f",
		purple_two = "#8b7ec8",
		green_two = "#879a39",
		highlight_low = "#282726",
		highlight_med = "#343331",
		highlight_high = "#403e3c",
		none = "none",
		green_zero = "#EDEECF",
	},
	dawn = {
		_nc = "#f2f0e5",
		base = "#fffcf0",
		surface = "#f2f0e5",
		overlay = "#e6e4d9",
		muted = "#b7b5ac",
		subtle = "#6f6e69",
		text = "#100f0f",
		yellow_two = "#ad8301",
		red_two = "#af3029",
		orange_two = "#bc5215",
		magenta_two = "#a02f6f",
		blue_two = "#205ea6",
		cyan_two = "#24837b",
		purple_two = "#5e409d",
		green_two = "#66800b",
		yellow_one = "#d0a215",
		red_one = "#d14d41",
		orange_one = "#da702c",
		magenta_one = "#ce5d97",
		blue_one = "#4385be",
		cyan_one = "#3aa99f",
		purple_one = "#8b7ec8",
		green_one = "#879a39",
		highlight_low = "#e6e4d9",
		highlight_med = "#dad8ce",
		highlight_high = "#cecdc3",
		none = "none",
		green_zero = "#EDEECF",
	},
}

if options.palette ~= nil and next(options.palette) then
	-- handle variant specific overrides
	for variant_name, override_palette in pairs(options.palette) do
		if variants[variant_name] then
			variants[variant_name] = vim.tbl_extend("force", variants[variant_name], override_palette or {})
		end
	end
end

if variants[options.variant] ~= nil then
	return variants[options.variant]
end

return vim.o.background == "light" and variants.dawn or variants.moon
