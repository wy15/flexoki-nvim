local M = {}
local config = require("flexoki.config")

local function set_highlights()
	local utilities = require("flexoki.utilities")
	local palette = require("flexoki.palette")
	local styles = config.options.styles

	local groups = {}
	for group, color in pairs(config.options.groups) do
		groups[group] = utilities.parse_color(color)
	end

	local function make_border(fg)
		fg = fg or groups.border
		return {
			fg = fg,
			bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.surface
				or "NONE",
		}
	end

	local highlights = {}
	local legacy_highlights = {
		["@attribute.diff"] = { fg = palette.orange_two },
		["@boolean"] = { link = "Boolean" },
		["@class"] = { fg = palette.cyan_two },
		["@conditional"] = { link = "Conditional" },
		["@field"] = { fg = palette.cyan_two },
		["@include"] = { link = "Include" },
		["@interface"] = { fg = palette.cyan_two },
		["@macro"] = { link = "Macro" },
		["@method"] = { fg = palette.magenta_two },
		["@namespace"] = { link = "Include" },
		["@number"] = { link = "Number" },
		["@parameter"] = { fg = palette.purple_two, italic = styles.italic },
		["@preproc"] = { link = "PreProc" },
		["@punctuation"] = { fg = palette.subtle },
		["@punctuation.bracket"] = { link = "@punctuation" },
		["@punctuation.delimiter"] = { link = "@punctuation" },
		["@punctuation.special"] = { link = "@punctuation" },
		["@regexp"] = { link = "String" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { fg = palette.text },
		["@text.danger"] = { fg = groups.error },
		["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@text.emphasis"] = { italic = styles.italic },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { link = "SpecialComment" },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = styles.bold },
		["@text.title"] = { link = "Title" },
		["@text.title.1.markdown"] = { link = "markdownH1" },
		["@text.title.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@text.title.2.markdown"] = { link = "markdownH2" },
		["@text.title.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@text.title.3.markdown"] = { link = "markdownH3" },
		["@text.title.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@text.title.4.markdown"] = { link = "markdownH4" },
		["@text.title.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@text.title.5.markdown"] = { link = "markdownH5" },
		["@text.title.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@text.title.6.markdown"] = { link = "markdownH6" },
		["@text.title.6.marker.markdown"] = { link = "markdownH6Delimiter" },
		["@text.underline"] = { underline = true },
		["@text.uri"] = { fg = groups.link },
		["@text.warning"] = { fg = groups.warn },
		["@todo"] = { link = "Todo" },

		-- lukas-reineke/indent-blankline.nvim
		IndentBlanklineChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceCharBlankline = { fg = palette.muted, nocombine = true },
	}
	local default_highlights = {
		ColorColumn = { bg = palette.surface },
		Conceal = { bg = "NONE" },
		CurSearch = { fg = palette.text, bg = palette.yellow_one },
		Cursor = { fg = palette.base, bg = palette.text },
		CursorColumn = { bg = palette.overlay },
		-- CursorIM = {},
		CursorLine = { bg = palette.overlay },
		CursorLineNr = { fg = palette.text, bold = styles.bold },
		-- DarkenedPanel = { },
		-- DarkenedStatusline = {},
		DiffAdd = { fg = palette.base, bg = palette.green_two },
		DiffChange = { fg = palette.surface, bg = palette.purple_two },
		DiffDelete = { fg = palette.surface, bg = palette.red_two },
		DiffText = { fg = palette.base, bg = groups.git_text },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },
		Directory = { fg = palette.cyan_two, bold = styles.bold },
		-- EndOfBuffer = {},
		ErrorMsg = { fg = groups.error, bold = styles.bold },
		FloatBorder = make_border(),
		FloatTitle = { fg = palette.cyan_two, bg = groups.panel, bold = styles.bold },
		FoldColumn = { fg = palette.muted },
		Folded = { fg = palette.text, bg = palette.overlay, italic = styles.italic },
		IncSearch = { fg = palette.text, bg = palette.yellow_two },
		LineNr = { fg = palette.muted },
		MatchParen = { fg = palette.blue_two, bg = palette.blue_one, blend = 20 },
		ModeMsg = { fg = palette.subtle },
		MoreMsg = { fg = palette.purple_two },
		NonText = { fg = palette.muted },
		Normal = { fg = palette.text, bg = palette.base },
		NormalFloat = { bg = groups.panel },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
		NvimInternalError = { link = "ErrorMsg" },
		Pmenu = { fg = palette.subtle, bg = groups.panel },
		PmenuExtra = { fg = palette.muted, bg = groups.panel },
		PmenuExtraSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuKind = { fg = palette.cyan_two, bg = groups.panel },
		PmenuKindSel = { fg = palette.subtle, bg = palette.overlay },
		PmenuSbar = { bg = groups.panel },
		PmenuSel = { fg = palette.text, bg = palette.overlay },
		PmenuThumb = { bg = palette.muted },
		Question = { fg = palette.orange_two },
		-- QuickFixLink = {},
		-- RedrawDebugNormal = {},
		RedrawDebugClear = { fg = palette.base, bg = palette.orange_two },
		RedrawDebugComposed = { fg = palette.base, bg = palette.blue_two },
		RedrawDebugRecompose = { fg = palette.base, bg = palette.red_two },
		Search = { fg = palette.text, bg = palette.yellow_two },
		SignColumn = { fg = palette.text, bg = "NONE" },
		SpecialKey = { fg = palette.cyan_two },
		SpellBad = { fg = palette.red_one, underline = true },
		SpellCap = { fg = palette.yellow_two, underline = true },
		SpellLocal = { fg = palette.green_two, underline = true },
		SpellRare = { fg = palette.purple_two, underline = true },
		StatusLine = { fg = palette.subtle, bg = groups.panel },
		StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		StatusLineTerm = { fg = palette.base, bg = palette.blue_two },
		StatusLineTermNC = { fg = palette.base, bg = palette.blue_two, blend = 60 },
		Substitute = { fg = palette.text, bg = palette.green_two },
		TabLine = { fg = palette.subtle, bg = palette.overlay },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = palette.highlight_low, bold = styles.bold },
		Title = { fg = palette.cyan_two, bold = styles.bold },
		VertSplit = { fg = groups.border },
		Visual = { bg = palette.highlight_med },
		-- VisualNOS = {},
		WarningMsg = { fg = groups.warn, bold = styles.bold },
		-- Whitespace = {},
		WildMenu = { link = "IncSearch" },
		WinBar = { fg = palette.subtle, bg = groups.panel },
		WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		WinSeparator = { fg = groups.border },

		DiagnosticError = { fg = groups.error },
		DiagnosticHint = { fg = palette.blue_two },
		DiagnosticInfo = { fg = groups.info },
		DiagnosticOk = { fg = groups.ok },
		DiagnosticWarn = { fg = palette.yellow_two },
		DiagnosticDefaultError = { link = "DiagnosticError" },
		DiagnosticDefaultHint = { link = "DiagnosticHint" },
		DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
		DiagnosticDefaultOk = { link = "DiagnosticOk" },
		DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingOk = { link = "DiagnosticOk" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignOk = { link = "DiagnosticOk" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
		DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
		DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
		DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true },
		DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
		DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
		DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
		DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
		DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 },
		DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

		Added = { fg = palette.green_two },
		Removed = { fg = palette.red_two },
		Changed = { fg = palette.orange_two },

		Boolean = { fg = palette.magenta_two },
		Character = { fg = palette.cyan_two },
		Comment = { fg = palette.subtle, italic = styles.italic },
		Conditional = { fg = palette.green_two },
		Constant = { fg = palette.yellow_two },
		Debug = { fg = palette.magenta_two },
		Define = { fg = palette.magenta_two },
		Delimiter = { fg = palette.subtle },
		Error = { fg = palette.red_two, bg = palette.base, bold = styles.bold },
		Exception = { fg = palette.green_two },
		Float = { fg = palette.purple_two },
		Function = { fg = palette.orange_two },
		Identifier = { fg = palette.blue_two },
		Include = { fg = palette.red_two },
		Keyword = { fg = palette.green_two },
		Label = { fg = palette.green_two },
		LspCodeLens = { fg = palette.subtle },
		LspCodeLensSeparator = { fg = palette.muted },
		LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 },
		LspReferenceRead = { bg = palette.highlight_low },
		LspReferenceText = { bg = palette.highlight_low },
		LspReferenceWrite = { bg = palette.highlight_low },
		Macro = { fg = palette.magenta_two },
		Number = { fg = palette.purple_two },
		Operator = { fg = palette.subtle },
		PreCondit = { fg = palette.magenta_two },
		PreProc = { link = "PreCondit" },
		Repeat = { fg = palette.green_two },
		Special = { fg = palette.subtle },
		SpecialChar = { fg = palette.magenta_two },
		SpecialComment = { fg = palette.text },
		Statement = {},
		StorageClass = { fg = palette.orange_two },
		String = { fg = palette.cyan_two },
		Structure = { fg = palette.orange_two },
		Tag = { fg = palette.cyan_two },
		Todo = { link = "@comment.todo" },
		Type = { fg = palette.green_two },
		TypeDef = { fg = palette.orange_two },
		Typedef = { fg = palette.orange_two },
		Underlined = { underline = true },

		healthError = { fg = groups.error },
		healthSuccess = { fg = groups.info },
		healthWarning = { fg = groups.warn },

		htmlArg = { fg = palette.purple_two },
		htmlBold = { bold = styles.bold },
		htmlEndTag = { fg = palette.subtle },
		htmlH1 = { link = "markdownH1" },
		htmlH2 = { link = "markdownH2" },
		htmlH3 = { link = "markdownH3" },
		htmlH4 = { link = "markdownH4" },
		htmlH5 = { link = "markdownH5" },
		htmlItalic = { italic = styles.italic },
		htmlLink = { link = "markdownUrl" },
		htmlTag = { fg = palette.subtle },
		htmlTagN = { fg = palette.text },
		htmlTagName = { fg = palette.cyan_two },

		markdownDelimiter = { fg = palette.subtle },
		markdownH1 = { fg = groups.h1, bold = styles.bold },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = groups.h2, bold = styles.bold },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = groups.h3, bold = styles.bold },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = groups.h4, bold = styles.bold },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = groups.h5, bold = styles.bold },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = groups.h6, bold = styles.bold },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

		mkdCode = { fg = palette.cyan_two, italic = styles.italic },
		mkdCodeDelimiter = { fg = palette.magenta_two },
		mkdCodeEnd = { fg = palette.cyan_two },
		mkdCodeStart = { fg = palette.cyan_two },
		mkdFootnotes = { fg = palette.cyan_two },
		mkdID = { fg = palette.cyan_two, underline = true },
		mkdInlineURL = { link = "markdownUrl" },
		mkdLink = { link = "markdownUrl" },
		mkdLinkDef = { link = "markdownUrl" },
		mkdListItemLine = { fg = palette.text },
		mkdRule = { fg = palette.subtle },
		mkdURL = { link = "markdownUrl" },

		--- Identifiers
		["@variable"] = { fg = palette.text, italic = styles.italic },
		["@variable.builtin"] = { fg = palette.red_two },
		["@variable.parameter"] = { fg = palette.purple_two, italic = styles.italic },
		["@variable.member"] = { fg = palette.blue_two },

		["@constant"] = { fg = palette.orange_two },
		["@constant.builtin"] = { fg = palette.orange_two, bold = styles.bold },
		["@constant.macro"] = { fg = palette.orange_two },

		["@module"] = { fg = palette.text },
		["@module.builtin"] = { fg = palette.text, bold = styles.bold },
		["@label"] = { link = "Label" },

		--- Literals
		["@string"] = { link = "String" },
		-- ["@string.documentation"] = {},
		["@string.regexp"] = { fg = palette.purple_two },
		["@string.escape"] = { fg = palette.blue_two },
		["@string.special"] = { link = "String" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = groups.link },
		-- ["@string.special.path"] = {},

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },
		["@float"] = { link = "Number" },

		--- Types
		["@type"] = { fg = palette.cyan_two },
		["@type.builtin"] = { fg = palette.cyan_two, bold = styles.bold },
		-- ["@type.definition"] = {},
		-- ["@type.qualifier"] = {},

		-- ["@attribute"] = {},
		["@property"] = { fg = palette.blue_two, italic = styles.italic },

		--- Functions
		["@function"] = { fg = palette.orange_two },
		["@function.builtin"] = { fg = palette.orange_two },
		-- ["@function.call"] = {},
		["@function.macro"] = { link = "Function" },
		["@function.method"] = { fg = palette.orange_two },
		["@function.method.call"] = { fg = palette.orange_two },

		["@constructor"] = { fg = palette.cyan_two },
		["@operator"] = { link = "Operator" },

		--- Keywords
		["@keyword"] = { link = "Keyword" },
		-- ["@keyword.coroutine"] = {},
		-- ["@keyword.function"] = {},
		["@keyword.operator"] = { fg = palette.subtle },
		["@keyword.import"] = { fg = palette.red_two },
		["@keyword.storage"] = { fg = palette.cyan_two },
		["@keyword.repeat"] = { fg = palette.green_two },
		["@keyword.return"] = { fg = palette.green_two },
		["@keyword.debug"] = { fg = palette.magenta_two },
		["@keyword.exception"] = { fg = palette.green_two },
		["@keyword.conditional"] = { fg = palette.green_two },
		["@keyword.conditional.ternary"] = { fg = palette.green_two },
		["@keyword.directive"] = { fg = palette.purple_two },
		["@keyword.directive.define"] = { fg = palette.purple_two },

		--- Punctuation
		["@punctuation.delimiter"] = { fg = palette.subtle },
		["@punctuation.bracket"] = { fg = palette.subtle },
		["@punctuation.special"] = { fg = palette.subtle },

		--- Comments
		["@comment"] = { link = "Comment" },
		-- ["@comment.documentation"] = {},

		["@comment.error"] = { fg = groups.error },
		["@comment.warning"] = { fg = groups.warn },
		["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 20 },
		["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 20 },
		["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 20 },
		["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 20 },

		--- Markup
		["@markup.strong"] = { bold = styles.bold },
		["@markup.italic"] = { italic = styles.italic },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = palette.cyan_two, bold = styles.bold },

		["@markup.quote"] = { fg = palette.text },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "@type" },

		-- ["@markup.link"] = {},
		["@markup.link.markdown_inline"] = { fg = palette.subtle },
		["@markup.link.label.markdown_inline"] = { fg = palette.cyan_two },
		["@markup.link.url"] = { fg = groups.link },

		-- ["@markup.raw"] = { bg = palette.surface },
		-- ["@markup.raw.block"] = { bg = palette.surface },
		["@markup.raw.delimiter.markdown"] = { fg = palette.subtle },

		["@markup.list"] = { fg = palette.blue_two },
		["@markup.list.checked"] = { fg = palette.cyan_two, bg = palette.cyan_two, blend = 10 },
		["@markup.list.unchecked"] = { fg = palette.text },

		-- Markdown headings
		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@diff.delta"] = { bg = groups.git_change, blend = 20 },

		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { fg = palette.purple_two },
		["@tag.delimiter"] = { fg = palette.subtle },

		--- Non-highlighting captures
		-- ["@none"] = {},
		["@conceal"] = { link = "Conceal" },
		["@conceal.markdown"] = { fg = palette.subtle },

		-- ["@spell"] = {},
		-- ["@nospell"] = {},

		--- Semantic
		["@lsp.type.comment"] = {},
		["@lsp.type.comment.c"] = { link = "@comment" },
		["@lsp.type.comment.cpp"] = { link = "@comment" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.namespace.python"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
		["@lsp.type.variable.svelte"] = { link = "@variable" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },

		--- Plugins
		-- romgrk/barbar.nvim
		BufferCurrent = { fg = palette.text, bg = palette.overlay },
		BufferCurrentIndex = { fg = palette.text, bg = palette.overlay },
		BufferCurrentMod = { fg = palette.cyan_two, bg = palette.overlay },
		BufferCurrentSign = { fg = palette.subtle, bg = palette.overlay },
		BufferCurrentTarget = { fg = palette.orange_two, bg = palette.overlay },
		BufferInactive = { fg = palette.subtle },
		BufferInactiveIndex = { fg = palette.subtle },
		BufferInactiveMod = { fg = palette.cyan_two },
		BufferInactiveSign = { fg = palette.muted },
		BufferInactiveTarget = { fg = palette.orange_two },
		BufferTabpageFill = { fg = "NONE", bg = "NONE" },
		BufferVisible = { fg = palette.subtle },
		BufferVisibleIndex = { fg = palette.subtle },
		BufferVisibleMod = { fg = palette.cyan_two },
		BufferVisibleSign = { fg = palette.muted },
		BufferVisibleTarget = { fg = palette.orange_two },

		-- lewis6991/gitsigns.nvim
		GitSignsAdd = { link = "SignAdd" },
		GitSignsChange = { link = "SignChange" },
		GitSignsDelete = { link = "SignDelete" },
		GitSignsAddInline = { fg = palette.green_two },
		GitSignsChangeInline = { fg = palette.yellow_two },
		GitSignsDeleteInline = { fg = palette.red_two },
		SignAdd = { fg = groups.git_add, bg = "NONE" },
		SignChange = { fg = groups.git_change, bg = "NONE" },
		SignDelete = { fg = groups.git_delete, bg = "NONE" },

		-- mvllow/modes.nvim
		ModesCopy = { bg = palette.orange_two },
		ModesDelete = { bg = palette.red_two },
		ModesInsert = { bg = palette.cyan_two },
		ModesReplace = { bg = palette.blue_two },
		ModesVisual = { bg = palette.purple_two },

		-- kyazdani42/nvim-tree.lua
		NvimTreeEmptyFolderName = { fg = palette.muted },
		NvimTreeFileDeleted = { fg = groups.git_delete },
		NvimTreeFileDirty = { fg = groups.git_dirty },
		NvimTreeFileMerge = { fg = groups.git_merge },
		NvimTreeFileNew = { fg = palette.cyan_two },
		NvimTreeFileRenamed = { fg = groups.git_rename },
		NvimTreeFileStaged = { fg = groups.git_stage },
		NvimTreeFolderIcon = { fg = palette.subtle },
		NvimTreeFolderName = { fg = palette.cyan_two },
		NvimTreeGitDeleted = { fg = groups.git_delete },
		NvimTreeGitDirty = { fg = groups.git_dirty },
		NvimTreeGitIgnored = { fg = groups.git_ignore },
		NvimTreeGitMerge = { fg = groups.git_merge },
		NvimTreeGitNew = { fg = groups.git_add },
		NvimTreeGitRenamed = { fg = groups.git_rename },
		NvimTreeGitStaged = { fg = groups.git_stage },
		NvimTreeImageFile = { fg = palette.text },
		NvimTreeNormal = { link = "Normal" },
		NvimTreeOpenedFile = { fg = palette.text, bg = palette.overlay },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeRootFolder = { fg = palette.cyan_two, bold = styles.bold },
		NvimTreeSpecialFile = { link = "NvimTreeNormal" },
		NvimTreeWindowPicker = { link = "StatusLineTerm" },

		-- nvim-neotest/neotest
		NeotestAdapterName = { fg = palette.purple_two },
		NeotestBorder = { fg = palette.highlight_med },
		NeotestDir = { fg = palette.cyan_two },
		NeotestExpandMarker = { fg = palette.highlight_med },
		NeotestFailed = { fg = palette.red_two },
		NeotestFile = { fg = palette.text },
		NeotestFocused = { fg = palette.orange_two, bg = palette.highlight_med },
		NeotestIndent = { fg = palette.highlight_med },
		NeotestMarked = { fg = palette.magenta_two, bold = styles.bold },
		NeotestNamespace = { fg = palette.orange_two },
		NeotestPassed = { fg = palette.blue_two },
		NeotestRunning = { fg = palette.orange_two },
		NeotestWinSelect = { fg = palette.muted },
		NeotestSkipped = { fg = palette.subtle },
		NeotestTarget = { fg = palette.red_two },
		NeotestTest = { fg = palette.orange_two },
		NeotestUnknown = { fg = palette.subtle },
		NeotestWatching = { fg = palette.purple_two },

		-- nvim-neo-tree/neo-tree.nvim
		NeoTreeGitAdded = { fg = groups.git_add },
		NeoTreeGitConflict = { fg = groups.git_merge },
		NeoTreeGitDeleted = { fg = groups.git_delete },
		NeoTreeGitIgnored = { fg = groups.git_ignore },
		NeoTreeGitModified = { fg = groups.git_dirty },
		NeoTreeGitRenamed = { fg = groups.git_rename },
		NeoTreeGitUntracked = { fg = groups.git_untracked },
		NeoTreeTabActive = { fg = palette.text, bg = palette.overlay },
		NeoTreeTabInactive = { fg = palette.subtle },
		NeoTreeTabSeparatorActive = { link = "WinSeparator" },
		NeoTreeTabSeparatorInactive = { link = "WinSeparator" },
		NeoTreeTitleBar = { link = "StatusLineTerm" },

		-- folke/flash.nvim
		FlashLabel = { fg = palette.base, bg = palette.red_two },

		-- folke/which-key.nvim
		WhichKey = { fg = palette.purple_two },
		WhichKeyBorder = make_border(),
		WhichKeyDesc = { fg = palette.orange_two },
		WhichKeyFloat = { bg = groups.panel },
		WhichKeyGroup = { fg = palette.cyan_two },
		WhichKeyIcon = { fg = palette.blue_two },
		WhichKeyIconAzure = { fg = palette.blue_two },
		WhichKeyIconBlue = { fg = palette.blue_two },
		WhichKeyIconCyan = { fg = palette.cyan_two },
		WhichKeyIconGreen = { fg = palette.green_two },
		WhichKeyIconGrey = { fg = palette.subtle },
		WhichKeyIconOrange = { fg = palette.magenta_two },
		WhichKeyIconPurple = { fg = palette.purple_two },
		WhichKeyIconRed = { fg = palette.red_two },
		WhichKeyIconYellow = { fg = palette.orange_two },
		WhichKeyNormal = { link = "NormalFloat" },
		WhichKeySeparator = { fg = palette.subtle },
		WhichKeyTitle = { link = "FloatTitle" },
		WhichKeyValue = { fg = palette.magenta_two },

		-- lukas-reineke/indent-blankline.nvim
		IblIndent = { fg = palette.overlay },
		IblScope = { fg = palette.cyan_two },
		IblWhitespace = { fg = palette.overlay },

		-- hrsh7th/nvim-cmp
		CmpItemAbbr = { fg = palette.subtle },
		CmpItemAbbrDeprecated = { fg = palette.subtle, strikethrough = true },
		CmpItemAbbrMatch = { fg = palette.text, bold = styles.bold },
		CmpItemAbbrMatchFuzzy = { fg = palette.text, bold = styles.bold },
		CmpItemKind = { fg = palette.subtle },
		CmpItemKindClass = { link = "StorageClass" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindMethod = { link = "PreProc" },
		CmpItemKindSnippet = { link = "String" },
		CmpItemKindVariable = { link = "Identifier" },

		-- NeogitOrg/neogit
		-- https://github.com/NeogitOrg/neogit/blob/master/lua/neogit/lib/hl.lua#L109-L198
		NeogitChangeAdded = { fg = groups.git_add, bold = styles.bold, italic = styles.italic },
		NeogitChangeBothModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeCopied = { fg = groups.git_untracked, bold = styles.bold, italic = styles.italic },
		NeogitChangeDeleted = { fg = groups.git_delete, bold = styles.bold, italic = styles.italic },
		NeogitChangeModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeNewFile = { fg = groups.git_stage, bold = styles.bold, italic = styles.italic },
		NeogitChangeRenamed = { fg = groups.git_rename, bold = styles.bold, italic = styles.italic },
		NeogitChangeUpdated = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffContextHighlight = { bg = palette.surface },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitFilePath = { fg = palette.cyan_two, italic = styles.italic },
		NeogitHunkHeader = { bg = groups.panel },
		NeogitHunkHeaderHighlight = { bg = groups.panel },

		-- vimwiki/vimwiki
		VimwikiHR = { fg = palette.subtle },
		VimwikiHeader1 = { link = "markdownH1" },
		VimwikiHeader2 = { link = "markdownH2" },
		VimwikiHeader3 = { link = "markdownH3" },
		VimwikiHeader4 = { link = "markdownH4" },
		VimwikiHeader5 = { link = "markdownH5" },
		VimwikiHeader6 = { link = "markdownH6" },
		VimwikiHeaderChar = { fg = palette.subtle },
		VimwikiLink = { link = "markdownUrl" },
		VimwikiList = { fg = palette.purple_two },
		VimwikiNoExistsLink = { fg = palette.red_two },

		-- nvim-neorg/neorg
		NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
		NeorgHeading1Title = { link = "markdownH1" },
		NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
		NeorgHeading2Title = { link = "markdownH2" },
		NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
		NeorgHeading3Title = { link = "markdownH3" },
		NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
		NeorgHeading4Title = { link = "markdownH4" },
		NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
		NeorgHeading5Title = { link = "markdownH5" },
		NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
		NeorgHeading6Title = { link = "markdownH6" },
		NeorgMarkerTitle = { fg = palette.cyan_two, bold = styles.bold },

		-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
		DefinitionCount = { fg = palette.magenta_two },
		DefinitionIcon = { fg = palette.magenta_two },
		DefinitionPreviewTitle = { fg = palette.magenta_two, bold = styles.bold },
		LspFloatWinBorder = make_border(),
		LspFloatWinNormal = { bg = groups.panel },
		LspSagaAutoPreview = { fg = palette.subtle },
		LspSagaCodeActionBorder = make_border(palette.magenta_two),
		LspSagaCodeActionContent = { fg = palette.cyan_two },
		LspSagaCodeActionTitle = { fg = palette.orange_two, bold = styles.bold },
		LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
		LspSagaDefPreviewBorder = make_border(),
		LspSagaDiagnosticBorder = make_border(palette.orange_two),
		LspSagaDiagnosticHeader = { fg = palette.cyan_two, bold = styles.bold },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
		LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
		LspSagaFinderSelection = { fg = palette.orange_two },
		LspSagaHoverBorder = { link = "LspFloatWinBorder" },
		LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
		LspSagaRenameBorder = make_border(palette.blue_two),
		LspSagaRenamePromptPrefix = { fg = palette.red_two },
		LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
		LspSagaSignatureHelpBorder = make_border(palette.cyan_two),
		ReferencesCount = { fg = palette.magenta_two },
		ReferencesIcon = { fg = palette.magenta_two },
		SagaShadow = { bg = palette.overlay },
		TargetWord = { fg = palette.purple_two },

		-- ray-x/lsp_signature.nvim
		LspSignatureActiveParameter = { bg = palette.overlay },

		-- rlane/pounce.nvim
		PounceAccept = { fg = palette.red_two, bg = palette.red_two, blend = 20 },
		PounceAcceptBest = { fg = palette.orange_two, bg = palette.orange_two, blend = 20 },
		PounceGap = { link = "Search" },
		PounceMatch = { link = "Search" },

		-- ggandor/leap.nvim
		LeapLabelPrimary = { link = "IncSearch" },
		LeapLabelSecondary = { link = "StatusLineTerm" },
		LeapMatch = { link = "MatchParen" },

		-- phaazon/hop.nvim
		-- smoka7/hop.nvim
		HopNextKey = { fg = palette.red_two, bg = palette.red_two, blend = 20 },
		HopNextKey1 = { fg = palette.cyan_two, bg = palette.cyan_two, blend = 20 },
		HopNextKey2 = { fg = palette.blue_two, bg = palette.blue_two, blend = 20 },
		HopUnmatched = { fg = palette.muted },

		-- nvim-telescope/telescope.nvim
		TelescopeBorder = make_border(),
		TelescopeMatching = { fg = palette.magenta_two },
		TelescopeNormal = { link = "NormalFloat" },
		TelescopePromptNormal = { link = "TelescopeNormal" },
		TelescopePromptPrefix = { fg = palette.subtle },
		TelescopeSelection = { fg = palette.text, bg = palette.overlay },
		TelescopeSelectionCaret = { fg = palette.magenta_two, bg = palette.overlay },
		TelescopeTitle = { fg = palette.cyan_two, bold = styles.bold },

		-- ibhagwan/fzf-lua
		FzfLuaBorder = make_border(),
		FzfLuaBufFlagAlt = { fg = palette.subtle },
		FzfLuaBufFlagCur = { fg = palette.subtle },
		FzfLuaCursorLine = { fg = palette.text, bg = palette.overlay },
		FzfLuaFilePart = { fg = palette.text },
		FzfLuaHeaderBind = { fg = palette.magenta_two },
		FzfLuaHeaderText = { fg = palette.red_two },
		FzfLuaNormal = { link = "NormalFloat" },
		FzfLuaTitle = { link = "FloatTitle" },

		-- rcarriga/nvim-notify
		NotifyDEBUGBorder = make_border(),
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyDEBUGTitle = { fg = palette.muted },
		NotifyERRORBorder = make_border(groups.error),
		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyERRORTitle = { fg = groups.error },
		NotifyINFOBorder = make_border(groups.info),
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyINFOTitle = { fg = groups.info },
		NotifyTRACEBorder = make_border(palette.purple_two),
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyTRACETitle = { fg = palette.purple_two },
		NotifyWARNBorder = make_border(groups.warn),
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyWARNTitle = { fg = groups.warn },
		NotifyBackground = { bg = palette.surface },
		-- rcarriga/nvim-dap-ui
		DapUIBreakpointsCurrentLine = { fg = palette.orange_two, bold = styles.bold },
		DapUIBreakpointsDisabledLine = { fg = palette.muted },
		DapUIBreakpointsInfo = { link = "DapUIThread" },
		DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
		DapUIBreakpointsPath = { fg = palette.cyan_two },
		DapUIDecoration = { link = "DapUIBreakpointsPath" },
		DapUIFloatBorder = make_border(),
		DapUIFrameName = { fg = palette.text },
		DapUILineNumber = { link = "DapUIBreakpointsPath" },
		DapUIModifiedValue = { fg = palette.cyan_two, bold = styles.bold },
		DapUIScope = { link = "DapUIBreakpointsPath" },
		DapUISource = { fg = palette.purple_two },
		DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
		DapUIThread = { fg = palette.orange_two },
		DapUIValue = { fg = palette.text },
		DapUIVariable = { fg = palette.text },
		DapUIWatchesEmpty = { fg = palette.red_two },
		DapUIWatchesError = { link = "DapUIWatchesEmpty" },
		DapUIWatchesValue = { link = "DapUIThread" },

		-- glepnir/dashboard-nvim
		DashboardCenter = { fg = palette.orange_two },
		DashboardFooter = { fg = palette.purple_two },
		DashboardHeader = { fg = palette.blue_two },
		DashboardShortcut = { fg = palette.red_two },

		-- SmiteshP/nvim-navic
		NavicIconsArray = { fg = palette.orange_two },
		NavicIconsBoolean = { fg = palette.magenta_two },
		NavicIconsClass = { fg = palette.cyan_two },
		NavicIconsConstant = { fg = palette.orange_two },
		NavicIconsConstructor = { fg = palette.orange_two },
		NavicIconsEnum = { fg = palette.orange_two },
		NavicIconsEnumMember = { fg = palette.cyan_two },
		NavicIconsEvent = { fg = palette.orange_two },
		NavicIconsField = { fg = palette.cyan_two },
		NavicIconsFile = { fg = palette.muted },
		NavicIconsFunction = { fg = palette.blue_two },
		NavicIconsInterface = { fg = palette.cyan_two },
		NavicIconsKey = { fg = palette.purple_two },
		NavicIconsKeyword = { fg = palette.blue_two },
		NavicIconsMethod = { fg = palette.purple_two },
		NavicIconsModule = { fg = palette.magenta_two },
		NavicIconsNamespace = { fg = palette.muted },
		NavicIconsNull = { fg = palette.red_two },
		NavicIconsNumber = { fg = palette.orange_two },
		NavicIconsObject = { fg = palette.orange_two },
		NavicIconsOperator = { fg = palette.subtle },
		NavicIconsPackage = { fg = palette.muted },
		NavicIconsProperty = { fg = palette.cyan_two },
		NavicIconsString = { fg = palette.orange_two },
		NavicIconsStruct = { fg = palette.cyan_two },
		NavicIconsTypeParameter = { fg = palette.cyan_two },
		NavicIconsVariable = { fg = palette.text },
		NavicSeparator = { fg = palette.subtle },
		NavicText = { fg = palette.subtle },

		-- folke/noice.nvim
		NoiceCursor = { fg = palette.highlight_high, bg = palette.text },

		-- folke/trouble.nvim
		TroubleText = { fg = palette.subtle },
		TroubleCount = { fg = palette.purple_two, bg = palette.surface },
		TroubleNormal = { fg = palette.text, bg = groups.panel },

		-- echasnovski/mini.nvim
		MiniAnimateCursor = { reverse = true, nocombine = true },
		MiniAnimateNormalFloat = { link = "NormalFloat" },

		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
		MiniClueDescSingle = { link = "NormalFloat" },
		MiniClueNextKey = { link = "DiagnosticFloatingHint" },
		MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
		MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
		MiniClueTitle = { bg = groups.panel, bold = styles.bold },

		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniDepsChangeAdded = { fg = groups.git_add },
		MiniDepsChangeRemoved = { fg = groups.git_delete },
		MiniDepsHint = { link = "DiagnosticHint" },
		MiniDepsInfo = { link = "DiagnosticInfo" },
		MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
		MiniDepsPlaceholder = { link = "Comment" },
		MiniDepsTitle = { link = "Title" },
		MiniDepsTitleError = { link = "DiffDelete" },
		MiniDepsTitleSame = { link = "DiffText" },
		MiniDepsTitleUpdate = { link = "DiffAdd" },

		MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
		MiniDiffOverContext = { bg = palette.surface },
		MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		MiniDiffSignAdd = { fg = groups.git_add },
		MiniDiffSignChange = { fg = groups.git_change },
		MiniDiffSignDelete = { fg = groups.git_delete },

		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = palette.text },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniFilesTitleFocused = { fg = palette.magenta_two, bg = groups.panel, bold = styles.bold },

		MiniHipatternsFixme = { fg = palette.base, bg = groups.error, bold = styles.bold },
		MiniHipatternsHack = { fg = palette.base, bg = groups.warn, bold = styles.bold },
		MiniHipatternsNote = { fg = palette.base, bg = groups.info, bold = styles.bold },
		MiniHipatternsTodo = { fg = palette.base, bg = groups.hint, bold = styles.bold },

		MiniIconsAzure = { fg = palette.cyan_two },
		MiniIconsBlue = { fg = palette.blue_two },
		MiniIconsCyan = { fg = palette.cyan_two },
		MiniIconsGreen = { fg = palette.green_two },
		MiniIconsGrey = { fg = palette.subtle },
		MiniIconsOrange = { fg = palette.magenta_two },
		MiniIconsPurple = { fg = palette.purple_two },
		MiniIconsRed = { fg = palette.red_two },
		MiniIconsYellow = { fg = palette.orange_two },

		MiniIndentscopeSymbol = { fg = palette.muted },
		MiniIndentscopeSymbolOff = { fg = palette.orange_two },

		MiniJump = { sp = palette.orange_two, undercurl = true },

		MiniJump2dDim = { fg = palette.subtle },
		MiniJump2dSpot = { fg = palette.orange_two, bold = styles.bold, nocombine = true },
		MiniJump2dSpotAhead = { fg = palette.cyan_two, bg = palette.surface, nocombine = true },
		MiniJump2dSpotUnique = { fg = palette.magenta_two, bold = styles.bold, nocombine = true },

		MiniMapNormal = { link = "NormalFloat" },
		MiniMapSymbolCount = { link = "Special" },
		MiniMapSymbolLine = { link = "Title" },
		MiniMapSymbolView = { link = "Delimiter" },

		MiniNotifyBorder = { link = "FloatBorder" },
		MiniNotifyNormal = { link = "NormalFloat" },
		MiniNotifyTitle = { link = "FloatTitle" },

		MiniOperatorsExchangeFrom = { link = "IncSearch" },

		MiniPickBorder = { link = "FloatBorder" },
		MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
		MiniPickBorderText = { bg = groups.panel },
		MiniPickIconDirectory = { link = "Directory" },
		MiniPickIconFile = { link = "MiniPickNormal" },
		MiniPickHeader = { link = "DiagnosticFloatingHint" },
		MiniPickMatchCurrent = { link = "CursorLine" },
		MiniPickMatchMarked = { link = "Visual" },
		MiniPickMatchRanges = { fg = palette.cyan_two },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPreviewLine = { link = "CursorLine" },
		MiniPickPreviewRegion = { link = "IncSearch" },
		MiniPickPrompt = { bg = groups.panel, bold = styles.bold },

		MiniStarterCurrent = { nocombine = true },
		MiniStarterFooter = { fg = palette.subtle },
		MiniStarterHeader = { link = "Title" },
		MiniStarterInactive = { link = "Comment" },
		MiniStarterItem = { link = "Normal" },
		MiniStarterItemBullet = { link = "Delimiter" },
		MiniStarterItemPrefix = { link = "WarningMsg" },
		MiniStarterSection = { fg = palette.magenta_two },
		MiniStarterQuery = { link = "MoreMsg" },

		MiniStatuslineDevinfo = { fg = palette.subtle, bg = palette.overlay },
		MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
		MiniStatuslineFilename = { fg = palette.muted, bg = palette.surface },
		MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
		MiniStatuslineModeCommand = { fg = palette.base, bg = palette.red_two, bold = styles.bold },
		MiniStatuslineModeInsert = { fg = palette.base, bg = palette.cyan_two, bold = styles.bold },
		MiniStatuslineModeNormal = { fg = palette.base, bg = palette.magenta_two, bold = styles.bold },
		MiniStatuslineModeOther = { fg = palette.base, bg = palette.magenta_two, bold = styles.bold },
		MiniStatuslineModeReplace = { fg = palette.base, bg = palette.blue_two, bold = styles.bold },
		MiniStatuslineModeVisual = { fg = palette.base, bg = palette.purple_two, bold = styles.bold },

		MiniSurround = { link = "IncSearch" },

		MiniTablineCurrent = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
		MiniTablineFill = { link = "TabLineFill" },
		MiniTablineHidden = { fg = palette.subtle, bg = groups.panel },
		MiniTablineModifiedCurrent = { fg = palette.overlay, bg = palette.text, bold = styles.bold },
		MiniTablineModifiedHidden = { fg = groups.panel, bg = palette.subtle },
		MiniTablineModifiedVisible = { fg = groups.panel, bg = palette.text },
		MiniTablineTabpagesection = { link = "Search" },
		MiniTablineVisible = { fg = palette.text, bg = groups.panel },

		MiniTestEmphasis = { bold = styles.bold },
		MiniTestFail = { fg = palette.red_two, bold = styles.bold },
		MiniTestPass = { fg = palette.cyan_two, bold = styles.bold },

		MiniTrailspace = { bg = palette.red_two },

		-- goolord/alpha-nvim
		AlphaButtons = { fg = palette.cyan_two },
		AlphaFooter = { fg = palette.orange_two },
		AlphaHeader = { fg = palette.blue_two },
		AlphaShortcut = { fg = palette.magenta_two },

		-- github/copilot.vim
		CopilotSuggestion = { fg = palette.muted, italic = styles.italic },

		-- nvim-treesitter/nvim-treesitter-context
		TreesitterContext = { bg = palette.overlay },
		TreesitterContextLineNumber = { fg = palette.magenta_two, bg = palette.overlay },

		-- RRethy/vim-illuminate
		IlluminatedWordRead = { bg = palette.overlay },
		IlluminatedWordText = { bg = palette.overlay },
		IlluminatedWordWrite = { bg = palette.overlay },

		-- HiPhish/rainbow-delimiters.nvim
		RainbowDelimiterBlue = { fg = palette.blue_two },
		RainbowDelimiterCyan = { fg = palette.cyan_two },
		RainbowDelimiterGreen = { fg = palette.green_two },
		RainbowDelimiterOrange = { fg = palette.magenta_two },
		RainbowDelimiterRed = { fg = palette.red_two },
		RainbowDelimiterViolet = { fg = palette.purple_two },
		RainbowDelimiterYellow = { fg = palette.orange_two },

		-- MeanderingProgrammer/render-markdown.nvim
		RenderMarkdownBullet = { fg = palette.magenta_two },
		RenderMarkdownChecked = { fg = palette.cyan_two },
		RenderMarkdownCode = { bg = palette.overlay },
		RenderMarkdownCodeInline = { fg = palette.text, bg = palette.overlay },
		RenderMarkdownDash = { fg = palette.muted },
		RenderMarkdownH1Bg = { bg = groups.h1, blend = 20 },
		RenderMarkdownH2Bg = { bg = groups.h2, blend = 20 },
		RenderMarkdownH3Bg = { bg = groups.h3, blend = 20 },
		RenderMarkdownH4Bg = { bg = groups.h4, blend = 20 },
		RenderMarkdownH5Bg = { bg = groups.h5, blend = 20 },
		RenderMarkdownH6Bg = { bg = groups.h6, blend = 20 },
		RenderMarkdownQuote = { fg = palette.subtle },
		RenderMarkdownTableFill = { link = "Conceal" },
		RenderMarkdownTableHead = { fg = palette.subtle },
		RenderMarkdownTableRow = { fg = palette.subtle },
		RenderMarkdownUnchecked = { fg = palette.subtle },

		-- MagicDuck/grug-far.nvim
		GrugFarHelpHeader = { fg = palette.blue_two },
		GrugFarHelpHeaderKey = { fg = palette.orange_two },
		GrugFarHelpWinActionKey = { fg = palette.orange_two },
		GrugFarHelpWinActionPrefix = { fg = palette.cyan_two },
		GrugFarHelpWinActionText = { fg = palette.blue_two },
		GrugFarHelpWinHeader = { link = "FloatTitle" },
		GrugFarInputLabel = { fg = palette.cyan_two },
		GrugFarInputPlaceholder = { link = "Comment" },
		GrugFarResultsActionMessage = { fg = palette.cyan_two },
		GrugFarResultsChangeIndicator = { fg = groups.git_change },
		GrugFarResultsHeader = { fg = palette.blue_two },
		GrugFarResultsLineNo = { fg = palette.purple_two },
		GrugFarResultsLineColumn = { link = "GrugFarResultsLineNo" },
		GrugFarResultsMatch = { link = "CurSearch" },
		GrugFarResultsPath = { fg = palette.cyan_two },
		GrugFarResultsStats = { fg = palette.purple_two },

		-- yetone/avante.nvim
		AvanteTitle = { fg = palette.highlight_high, bg = palette.magenta_two },
		AvanteReversedTitle = { fg = palette.magenta_two },
		AvanteSubtitle = { fg = palette.highlight_med, bg = palette.cyan_two },
		AvanteReversedSubtitle = { fg = palette.cyan_two },
		AvanteThirdTitle = { fg = palette.highlight_med, bg = palette.purple_two },
		AvanteReversedThirdTitle = { fg = palette.purple_two },

		-- folke/todo-comments.nvim
		TodoBgTODO = { link = "@comment.todo" },
		TodoBgWARN = { fg = groups.warn, bg = groups.warn, blend = 20 },
		TodoBgHACK = { link = "@comment.warn" },
		TodoBgFIX = { fg = groups.error, bg = groups.error, blend = 20 },
		TodoBgNOTE = { link = "@comment.note" },
		TodoBgPERF = { link = "@comment.info" },
		TodoBgTEST = { link = "@comment.info" },
		TodoFgTODO = { fg = groups.todo },
		TodoFgWARN = { fg = groups.warn },
		TodoFgHACK = { link = "TodoFgWARN" },
		TodoFgFIX = { fg = groups.error },
		TodoFgNOTE = { fg = groups.note },
		TodoFgPERF = { fg = groups.info },
		TodoFgTEST = { link = "TodoFgPERF" },
		TodoSignTODO = { fg = groups.todo },
		TodoSignWARN = { fg = groups.warn },
		TodoSignHACK = { link = "TodoSignWARN" },
		TodoSignFIX = { fg = groups.error },
		TodoSignNOTE = { fg = groups.note },
		TodoSignPERF = { fg = groups.info },
		TodoSignTEST = { link = "TodoSignPERF" },

		InclineNormal = { bg = palette.overlay },
		InclineNormalNC = { bg = palette.overlay },

		-- sindrets/diffview.nvim
		DiffViewDiffAdd = { bg = palette.green_zero },
	}
	local transparency_highlights = {
		DiagnosticVirtualTextError = { fg = groups.error },
		DiagnosticVirtualTextHint = { fg = groups.hint },
		DiagnosticVirtualTextInfo = { fg = groups.info },
		DiagnosticVirtualTextOk = { fg = groups.ok },
		DiagnosticVirtualTextWarn = { fg = groups.warn },

		FloatBorder = { fg = palette.muted, bg = "NONE" },
		FloatTitle = { fg = palette.cyan_two, bg = "NONE", bold = styles.bold },
		Folded = { fg = palette.text, bg = "NONE", italic = styles.italic },
		NormalFloat = { bg = "NONE" },
		Normal = { fg = palette.text, bg = "NONE" },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
		Pmenu = { fg = palette.subtle, bg = "NONE" },
		PmenuKind = { fg = palette.cyan_two, bg = "NONE" },
		SignColumn = { fg = palette.text, bg = "NONE" },
		StatusLine = { fg = palette.subtle, bg = "NONE" },
		StatusLineNC = { fg = palette.muted, bg = "NONE" },
		TabLine = { bg = "NONE", fg = palette.subtle },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = "NONE", bold = styles.bold },

		-- ["@markup.raw"] = { bg = "none" },
		["@markup.raw.markdown_inline"] = { fg = palette.orange_two },
		-- ["@markup.raw.block"] = { bg = "none" },

		TelescopeNormal = { fg = palette.subtle, bg = "NONE" },
		TelescopePromptNormal = { fg = palette.text, bg = "NONE" },
		TelescopeSelection = { fg = palette.text, bg = "NONE", bold = styles.bold },
		TelescopeSelectionCaret = { fg = palette.magenta_two },

		TroubleNormal = { bg = "NONE" },

		WhichKeyFloat = { bg = "NONE" },
		WhichKeyNormal = { bg = "NONE" },

		IblIndent = { fg = palette.overlay, bg = "NONE" },
		IblScope = { fg = palette.cyan_two, bg = "NONE" },
		IblWhitespace = { fg = palette.overlay, bg = "NONE" },

		TreesitterContext = { bg = "NONE" },
		TreesitterContextLineNumber = { fg = palette.magenta_two, bg = "NONE" },

		MiniFilesTitleFocused = { fg = palette.magenta_two, bg = "NONE", bold = styles.bold },

		MiniPickPrompt = { bg = "NONE", bold = styles.bold },
		MiniPickBorderText = { bg = "NONE" },
	}

	if config.options.enable.legacy_highlights then
		for group, highlight in pairs(legacy_highlights) do
			highlights[group] = highlight
		end
	end
	for group, highlight in pairs(default_highlights) do
		highlights[group] = highlight
	end
	if styles.transparency then
		for group, highlight in pairs(transparency_highlights) do
			highlights[group] = highlight
		end
	end

	-- Reconcile highlights with config
	if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
		for group, highlight in pairs(config.options.highlight_groups) do
			local existing = highlights[group] or {}
			-- Traverse link due to
			-- "If link is used in combination with other attributes; only the link will take effect"
			-- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
			while existing.link ~= nil do
				existing = highlights[existing.link] or {}
			end
			local parsed = vim.tbl_extend("force", {}, highlight)

			if highlight.fg ~= nil then
				parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
			end
			if highlight.bg ~= nil then
				parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
			end
			if highlight.sp ~= nil then
				parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
			end

			if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
				parsed.inherit = nil
				highlights[group] = vim.tbl_extend("force", existing, parsed)
			else
				parsed.inherit = nil
				highlights[group] = parsed
			end
		end
	end

	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end
		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end
		vim.api.nvim_set_hl(0, group, highlight)
	end

	--- Terminal
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.overlay -- black
		vim.g.terminal_color_8 = palette.subtle -- bright black
		vim.g.terminal_color_1 = palette.red_two -- red
		vim.g.terminal_color_9 = palette.red_two -- bright red
		vim.g.terminal_color_2 = palette.blue_two -- green
		vim.g.terminal_color_10 = palette.blue_two -- bright green
		vim.g.terminal_color_3 = palette.orange_two -- yellow_two
		vim.g.terminal_color_11 = palette.orange_two -- bright yellow_two
		vim.g.terminal_color_4 = palette.cyan_two -- blue
		vim.g.terminal_color_12 = palette.cyan_two -- bright blue
		vim.g.terminal_color_5 = palette.purple_two -- magenta
		vim.g.terminal_color_13 = palette.purple_two -- bright magenta
		vim.g.terminal_color_6 = palette.magenta_two -- cyan
		vim.g.terminal_color_14 = palette.magenta_two -- bright cyan
		vim.g.terminal_color_7 = palette.text -- white
		vim.g.terminal_color_15 = palette.text -- bright white

		-- Support StatusLineTerm & StatusLineTermNC from vim
		vim.cmd([[
		augroup flexoki
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! flexoki
		augroup END
		]])
	end
end

---@param variant Variant | nil
function M.colorscheme(variant)
	config.extend_options({ variant = variant })

	vim.opt.termguicolors = true
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "flexoki"

	set_highlights()
end

---@param options Options
function M.setup(options)
	config.extend_options(options or {})
end

return M
