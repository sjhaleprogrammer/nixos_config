{ config, pkgs, ... }:


{
  nixpkgs.config.allowUnfree = true;
 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  
  
  

  services.xserver.excludePackages = (with pkgs; [ 
    xterm 
  ]);

  environment.systemPackages = with pkgs; [
    

  
	    
    #video player
    celluloid

    #zsh shit
    starship
    

    #ide 
    vscodium
    direnv
    
    #task-manager
    mission-center
    
    #recording 
    obs-studio
    
    #communication
    webcord

    #browser
    brave

    #xbox controllers
    xboxdrv
      

   
    #libraries
    ntfs3g
    linuxHeaders
    linux-firmware
    fakeroot
    alsa-utils
    alsa-firmware
    gjs
   
    #utilities
    pywal
    killall
    pamixer
    brightnessctl
    upower
    streamlink
    wget
    unzip
    time
    socat
    rsync
    ripgrep
    fzf
    neofetch
    mpc-cli
    mlocate
    inotify-tools
    groff
    ffmpegthumbnailer
    jellyfin-ffmpeg
    fd
    dialog
    bat
    which
    poppler_utils
    p7zip
    atool
    unrar
    odt2txt
    xlsx2csv
    jq
    mediainfo
    imagemagick
    libnotify
    mangohud
    
   

    # native wayland support (unstable)
    wineWowPackages.waylandFull
    
    # asus system 
    asusctl
    supergfxctl
    
    #virtual machines
    /*
    virt-manager
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    */

   
    appimage-run #runs appimages 
    steam-run #runs linux binaries
    bottles #for wine applications

    #gaming
    retroarchFull #emulation
    
    

    

  ];

  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];


  


  #virtmanager
  
  /*
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  */



  #podman
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  #asus system services
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
      settings = {
        vfio_enable = true;
        hotplug_type = "Asus"; 
      };
    };
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils pkgs.lsof ];



  #gnome exclusive services
  services.switcherooControl.enable = true;



  

  
}
