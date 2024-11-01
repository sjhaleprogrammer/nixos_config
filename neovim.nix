{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixvim.nixosModules.nixvim ];
  
  programs.nixvim = {
    enable = true;


    clipboard.providers.wl-copy.enable = true;


    opts = {
      number = true; # Show line numbers
      shiftwidth = 4; # Tab width should be 2 spaces

    };


    plugins = {
	 
	  airline.enable = true;

	  cmp.enable = true;
	  cmp_luasnip.enable = true;
	  cmp-nvim-lsp.enable = true;
	  cmp-buffer.enable = true;
	  cmp-path.enable = true;
	  cmp-cmdline.enable = true;



	  gitsigns.enable = true;  

	  nvim-tree.enable = true;

	  telescope.enable = true;
	  
	  codeium-vim.enable = true;

          treesitter = {
	          enable = true;
		  gccPackage = pkgs.gcc;
          };
	
	  
	

	  lsp = {
	    enable = true;
	    servers = {
	        prolog_ls.enable = true;
          astro.enable = true;
          html.enable = true;
          pyright.enable = true;
          tsserver.enable = true;
          #rust-analyzer.enable = true;
          nil-ls.enable = true;
          clangd.enable = true;
          java-language-server.enable = true;
	    };

	  };

    };



    highlight = {
      MacchiatoRed.fg = "#ed8796";
    };

    extraConfigLua = ''

	  vim.cmd('highlight Normal guibg=none ctermbg=none')
	  vim.cmd(':NvimTreeOpen')

	  	  
	  local cmp = require'cmp'

	  cmp.setup({
	    snippet = {
	      -- REQUIRED - you must specify a snippet engine
	      expand = function(args)
		-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
	      end,
	    },
	    window = {
	      -- completion = cmp.config.window.bordered(),
	      -- documentation = cmp.config.window.bordered(),
	    },
	    mapping = cmp.mapping.preset.insert({
	      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	      ['<C-f>'] = cmp.mapping.scroll_docs(4),
	      ['<C-Space>'] = cmp.mapping.complete(),
	      ['<C-e>'] = cmp.mapping.abort(),
	      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	    }),
	    sources = cmp.config.sources({
	      { name = 'nvim_lsp' },
	      { name = 'vsnip' }, -- For vsnip users.
	      -- { name = 'luasnip' }, -- For luasnip users.
	      -- { name = 'ultisnips' }, -- For ultisnips users.
	      -- { name = 'snippy' }, -- For snippy users.
	    }, {
	      { name = 'buffer' },
	    })
	  })

	  -- Set configuration for specific filetype.
	  cmp.setup.filetype('gitcommit', {
	    sources = cmp.config.sources({
	      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	    }, {
	      { name = 'buffer' },
	    })
	  })

	  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	  cmp.setup.cmdline({ '/', '?' }, {
	    mapping = cmp.mapping.preset.cmdline(),
	    sources = {
	      { name = 'buffer' }
	    }
	  })

	  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	  cmp.setup.cmdline(':', {
	    mapping = cmp.mapping.preset.cmdline(),
	    sources = cmp.config.sources({
	      { name = 'path' }
	    }, {
	      { name = 'cmdline' }
	    }),
	    matching = { disallow_symbol_nonprefix_matching = false }
	  })



	'';


    };

}
