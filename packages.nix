{ config, pkgs, inputs, ... }:


{
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  


  services.xserver.excludePackages = (with pkgs; [ 
    xterm 
  ]);

  environment.systemPackages = with pkgs; [
    

	    
    #video player
    mpv

    #zsh shit
    starship
    
    #ide 
    vscodium
    direnv
    
    #task-manager
    btop
    
    #recording 
    obs-studio
    
    #communication
    discord

    #browser
    brave

    #xbox controllers
    xboxdrv

    #images
    feh

    #app launcher
    dmenu



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
    
    
   

    # native wayland support 
    wineWowPackages.stable
    
    # asus system 
    asusctl
    supergfxctl
    
    #virtual machines
    virt-manager
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice

    #gaming
    lutris
    mangohud

    #appimage support
    appimage-run
    
    

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
  programs.dconf.enable = true;
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


  #asus system services
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [ pkgs.pciutils ];
  services.power-profiles-daemon.enable = true;


  #gnome exclusive services
  services.switcherooControl.enable = true;

  
}
