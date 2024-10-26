{
  description = "Flake for building my gnome system";
  


  nixConfig = {
    substituters = [
      "https://cache.nixos.org"

      # nix community's cache server
      "https://nix-community.cachix.org"

      # sjhaleprogrammer's cache server
      "https://sjhaleprogrammer.cachix.org"
    ];
    trusted-public-keys = [
	"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
	"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
	"sjhaleprogrammer.cachix.org-1:Yxwp/6ytc91ydFbxWE8JunnPioBLb5VbdIn+jnMtHkg="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05"; 

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  ./kernel.nix
          /etc/nixos/hardware-configuration.nix
          ./packages.nix

          #relies on nixvim input 
          ./neovim.nix

	  ./virtualization.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                samuel = import ./home.nix;
              };
            };
          }

        ];


      };
    };

  };


}
