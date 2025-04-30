require "paq" {
	"savq/paq-nvim",
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	"ellisonleao/gruvbox.nvim",
	"nvim-lualine/lualine.nvim",
	"ptzz/lf.vim",
	"voldikss/vim-floaterm",
	"neovim/nvim-lspconfig",
	{ "saghen/blink.cmp", opts = { keymap = { preset = "enter" } }, build = 'cargo +nightly build --release' },
	"rafamadriz/friendly-snippets",
	"xzbdmw/colorful-menu.nvim",
	{ "folke/trouble.nvim", cmd = "Trouble"},
}

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", ":Lf<cr>")
vim.keymap.set("n", "n", ":bnext<cr>")
vim.keymap.set("n", "<leader>bc", ":bd<cr>")
vim.keymap.set("n", "<leader>s", ":wa<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>d", ":wqa<cr>")
vim.keymap.set("n", "<leader>t", ":FloatermToggle<cr>")
vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>")

require('lualine').setup {
	options = {
		theme = 'gruvbox'
	},
}


local lspconfig = {
	default_capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
		textDocument = {
			completion = {
				dynamicRegistration = false,
				completionItem = {
					snippetSupport = true,
					commitCharactersSupport = true,
					deprecatedSupport = true,
					preselectSupport = true,
					tagSupport = {
						valueSet = {
							1, -- Deprecated
						},
					},
					insertReplaceSupport = true,
					resolveSupport = {
						properties = {
							"documentation",
							"additionalTextEdits",
							"insertTextFormat",
							"insertTextMode",
							"command",
						},
					},
					insertTextModeSupport = {
						valueSet = {
							1, -- asIs
							2, -- adjustIndentation
						},
					},
					labelDetailsSupport = true,
				},
				contextSupport = true,
				insertTextMode = 1,
				completionList = {
					itemDefaults = {
						"commitCharacters",
						"editRange",
						"insertTextFormat",
						"insertTextMode",
						"data",
					},
				},
			},
		},
	}),
}

function lspconfig.onattach(client, buff)
	local opts = { buffer = buf, tabstop = 2 }
end

vim.lsp.config('*', 

	{
  	capabilities = require("blink.cmp").get_lsp_capabilities(lspconfig.default_capabilities),
 		on_attach = lspconfig.on_attach,
  	vim.diagnostic.config({
    	virtual_text = true, -- show inline error messages
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
	}
)

vim.lsp.enable({
	"gopls",
	"luals",
})
vim.lsp.config("gopls", {
  vim.diagnostic.config({
      virtual_text = true, -- show inline error messages
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
})
require("blink.cmp").setup({
	completion = {
		documentation = {
			auto_show = true,
			treesitter_highlighting = true,
		}
	}
})

