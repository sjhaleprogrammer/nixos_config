{ pkgs, ... }:


{
        programs.neovim = {
                  enable = true;
		  defaultEditor = true;
		  vimAlias = true;
                  configure = {
                    customRC = ''

		      autocmd VimEnter * highlight Normal guibg=none ctermbg=none
		      autocmd VimEnter * Neotree 

                      set number
                      set shiftwidth=8
                      set tabstop=8
                      set expandtab
                      set smartindent

                      colorscheme dracula


                      if &diff
                        colorscheme blue
                      endif


                      luafile ${./neovim.lua}

                    '';

                    packages.myVimPackage = with pkgs.vimPlugins; {
                      start = [

                        dracula-nvim
                        airline

                        cmp_luasnip
                        cmp-nvim-lsp
                        cmp-buffer
                        cmp-path
                        cmp-cmdline

                        indent-blankline-nvim
                        gitsigns-nvim
                        
                        neo-tree-nvim
                        nvim-web-devicons


                        telescope-nvim
                        codeium-nvim
                        conform-nvim
                        nvim-treesitter
                        nvim-lspconfig
                        
                      ];
                    };
                  };


        };


        environment.systemPackages = with pkgs; [
                wl-clipboard
                gcc
                tree-sitter
                nodejs-slim
        ];

}
