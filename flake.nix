{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      
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

  outputs = inputs@{ nixpkgs, home-manager, nixvim, wsl, ... }: {
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

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.samuel = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
	     

        ];
        
        
      };
    };

  };
  

}
