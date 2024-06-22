local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Nav Bar
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }
  -- Syntax Highlight
	, { "nvim-treesitter/nvim-treesitter" }
	-- LSP
	, { "neovim/nvim-lspconfig" }
  -- Auto Complete
  , { "hrsh7th/nvim-cmp" }
  , { "hrsh7th/cmp-nvim-lsp" }
  , { "hrsh7th/cmp-buffer" }
  , { "hrsh7th/cmp-path" }
  , { "hrsh7th/cmp-cmdline" }
	-- Manager for LSPs
	, { "williamboman/mason.nvim" }
	-- Autopairs
	, { "windwp/nvim-autopairs" }
	-- Comment
	, { "terrortylor/nvim-comment" }
	-- Git Signs 
	, { "lewis6991/gitsigns.nvim" }
	-- Themes
	, { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
	-- Telescope
	, { 
		"nvim-telescope/telescope.nvim", tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" }
	}
	-- VimTex
	, {
    "lervag/vimtex",
    init = function()
			local g = vim.g
			g.vimtex_view_method = "zathura"
			g.vimtex_compiler_method = "latexmk"
			g.vimtex_quickfix_mode = 1
			g.vimtex_compiler_latexmk = {
				out_dir = "dist"
			}
    end,
		ft = "tex",
    lazy = false,
  }
	-- LuaShip
	, {
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	}
	-- Markdown Preview
	, {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
		init = function()
			-- local g = vim.g
			-- set to 1, the preview server is available to others in your network.
			-- By default, the server listens on localhost (127.0.0.1)
			-- default: 0
			-- g.mkdp_open_to_the_world = 1
		end,
    build = function() vim.fn["mkdp#util#install"]() end,
	}
})

