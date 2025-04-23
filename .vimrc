set belloff=all

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'Donaldttt/fuzzyy'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'yegappan/lsp'
Plug 'girishji/vimcomplete'
Plug 'girishji/vimsuggest'
                          
call plug#end()

colorscheme gruvbox
set background=dark
syntax enable
set number

let mapleader=' '
let g:lf_map_keys = 0

map <leader>f :FlotermNew lf<cr>
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>bc :bd!<cr>
map <leader>t :FloatermToggle<cr>
map <leader>d :wqa<cr>
map <leader>ff :FuzzyFiles<cr>
map <leader>s :wa<cr>
map <leader>q :qa <cr>
map <leader>c :LspCodeAction<cr> 
map <leader>m :FloatermNew glow<cr>

inoremap <buffer><expr> <DOWN> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <buffer><expr> <UP>   pumvisible() ? "\<C-p>" : "\<Up>"

let lspOpts = #{autoHighlightDiags: v:true, autoPopulateDiags: v:true, showDiagWithVirtualText: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
	\	  name: 'golang',
	\	  filetype: ['go', 'gomod'],
	\	  path: 'gopls',
	\	  args: ['serve'],
	\	  syncInit: v:true
	\ },
	\	  #{
	\	  name: 'vimls',
	\         filetype: 'vim',
        \         path: 'vim-language-server',
	\         args: ['--stdio']
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

hi! link EndOfBuffer Ignore
set fillchars+=eob:\  
