{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    inputs.wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "samuel";
 

  users = {
    mutableUsers = true;
    groups = {
      samuel.gid = 1000;
    };
   
    users.samuel = {
      isNormalUser = true;
      home = "/home/samuel";
      shell = pkgs.zsh;
      uid = 1000;
      group = "samuel";
      extraGroups = [ "wheel" "networkmanager"  ]; 
    };
  };

    

  environment = {
    shells = with pkgs; [ zsh bash dash ];
    binsh = "${pkgs.dash}/bin/dash";

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      
    };

  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
   	
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";  

}
  
