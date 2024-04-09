{inputs, pkgs, ...}:

{
    imports = [inputs.nixvim.nixosModules.nixvim];
    programs.nixvim = {
	enable = true;

	
        clipboard.providers.wl-copy.enable = true;
	
	colorschemes.dracula.enable = true;

	opts = {
	   number = true;         # Show line numbers
	   shiftwidth = 4;        # Tab width should be 2 spaces

        };


	plugins = {
	 
	  airline.enable = true;

	  cmp-nvim-lsp.enable = true;

	  cmp.enable = true;
	  
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
		astro.enable = true;
		html.enable = true;
		pyright.enable = true;
		tsserver.enable = true;
		#rust-analyzer.enable = true;
		nil_ls.enable = true;
		clangd.enable = true;
	    };

	  };

        };


        highlight = {
	   MacchiatoRed.fg = "#ed8796";
	};
	
	extraConfigLua = ''
	  vim.cmd(':NvimTreeOpen')
	'';



    };

}
