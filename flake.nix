{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    asusctl.url = "github:soulsoiledit/nixpkgs-asusctl-5.0.10/asusctl-5.0.10";
   
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixvim = {
    	url = "github:nix-community/nixvim/main";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

    wsl = {
	url = "github:nix-community/NixOS-WSL/main";
	inputs.nixpkgs.follows = "nixpkgs";
    }; 
    
    
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, asusctl, wsl, ... }: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          /etc/nixos/hardware-configuration.nix
          ./packages.nix
	
	  #relies on nixvim input 
	  ./neovim.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                nixos = import ./home.nix; 
              };
            };
          }

        ];
        
        
      };
    };

  };
  

}
