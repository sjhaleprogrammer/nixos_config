{
  description = "Flake for building my gnome system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kde2nix.url = "github:nix-community/kde2nix";
    
  };

  outputs = inputs@{ nixpkgs, home-manager, kde2nix, ... }: {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          kde2nix.nixosModules.plasma6
          ./configuration.nix
          /etc/nixos/hardware-configuration.nix
          ./packages.nix  

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.samuel = import ./home.nix;
          }

        ];
        specialArgs = {
          inherit inputs;
        };
        
      };
    };

  };
  

}
