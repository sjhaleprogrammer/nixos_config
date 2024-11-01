{ config, pkgs, pkgs-unstable, lib, inputs, ... }:



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
  
  
  #neovim
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    neovim = pkgs-unstable.neovim; 
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
      ]))
    ];
    hm-activation = true;
    backup = true;
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
  
  programs.direnv = {
	enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };

  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };



  };

  home.pointerCursor =
    let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 26;
        package =
          pkgs.runCommand "moveUp" { } ''
            mkdir -p $out/share/icons
            ln -s ${pkgs.fetchzip {
              url = url;
              hash = hash;
            }} $out/share/icons/${name}
          '';
      };
    in
    getFrom
      "https://github.com/manu-mannattil/adwaita-cursors/releases/download/v1.2/adwaita-cursors.tar.gz"
      "sha256-zKa55zn4UO/cCTx2Es0xKxUwjFe5/k5xWI9RLJYpvsQ="
      "Adwaita";




}
