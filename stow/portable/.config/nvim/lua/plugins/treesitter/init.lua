local parsers = {
	"bash",
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local filetypes = {
	"bash",
	"css",
	"go",
	"help",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"python",
	"rust",
	"sh",
	"typescript",
	"typescriptreact",
	"vim",
	"yaml",
	"zsh",
}

local function use_configured_compiler()
	if (not vim.env.CC or vim.env.CC == "") and vim.fn.executable("clang") == 1 then
		vim.env.CC = "clang"
	end
end

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = function()
		use_configured_compiler()

		local treesitter = require("nvim-treesitter")

		treesitter.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		treesitter.install(parsers, { max_jobs = 4 }):wait(300000)
		treesitter.update(parsers, { max_jobs = 4 }):wait(300000)
	end,
	config = function()
		use_configured_compiler()

		local treesitter = require("nvim-treesitter")

		treesitter.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
			pattern = filetypes,
			callback = function(event)
				if pcall(vim.treesitter.start, event.buf) then
					vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
