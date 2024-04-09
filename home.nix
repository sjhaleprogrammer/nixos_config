{ config, pkgs, lib, ... }:



{

    # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [ pkgs.zplug ];
  
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";
  home.stateVersion = "23.05";
  

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "samuel";
    userEmail = "samworlds1231337@gmail.com";
    extraConfig = {
      safe = {
        directory = "/etc/nixos";
      };
    };
  
  };

  
 

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable  = true;
    syntaxHighlighting.enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "dracula/zsh"; tags = [ as:theme ]; } ];
    }; 
  };




 
}
