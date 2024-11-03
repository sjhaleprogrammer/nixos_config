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
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    nixvim = {
        url = "github:nix-community/nixvim/nixos-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = { nixpkgs, home-manager, nixvim, nixpkgs-unstable, ... }@inputs:

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    # Define arguments to be passed into various configurations
    extraSpecialArgs = { inherit system inputs; };
  in {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./kernel.nix
          /etc/nixos/hardware-configuration.nix
          ./packages.nix
          ./virtualization.nix

          nixvim.nixosModules.nixvim 
          ./neovim.nix


          # Home Manager configuration
          home-manager.nixosModules.home-manager{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.samuel = import ./home.nix {
              inherit pkgs pkgs-unstable inputs;
            };
          }
        ];
      };
    };
  };
 


}
