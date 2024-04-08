{ config, pkgs, lib, ... }:



{

    # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

 
  
  

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

  
  programs.oh-my-posh = {
    enable = true;
    useTheme = "powerlevel10k_rainbow";

  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable  = true;
    syntaxHighlighting.enable = true;
    
    initExtra = ''
      (cat /home/samuel/.cache/wal/sequences &)
    '';
  };




 
}
