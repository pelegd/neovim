require('keymaps')
require('plugins')
require('impatient') --Uses impatient plugin to load faster
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true
vim.wo.relativenumber = true

---
-- Old VIM Script Commands
--
vim.cmd([[
set spell
]])

---
-- Suppress errors in Windows
-- 

vim.notify = function (msg, log_level, _opts)
    if msg:match("exit code") then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
    vim.api.nvim_echo({{msg}}, true, {})
    end
  end

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd('colorscheme nord')


-- LSP and Linting Config
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    'bashls',
    'luau_lsp',
    'marksman',
    'powershell_es',
  },
	automatic_installation = true,
})

require'lspconfig'.bashls.setup{}
require'lspconfig'.luau_lsp.setup{}
require'lspconfig'.marksman.setup{}
require'lspconfig'.powershell_es.setup{
  bundle_path = '~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/',
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

require("null-ls").setup({
	sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.code_actions.cspell,
			require("null-ls").builtins.diagnostics.codespell,
			require("null-ls").builtins.completion.spell,
			require("null-ls").builtins.code_actions.proselint,
			require("null-ls").builtins.diagnostics.write_good,
	},
})

-- File Explorer nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

--Pretty Status bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'nord',
	},
}

-- Add Ctrl + X and initialize toggle term 
require("toggleterm").setup {
	open_mapping = [[<c-x>]],
	shade_terminals = false
}

-- Add projects capability to telescope
require('telescope').load_extension('projects')

-- Smarter Indent setup
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
