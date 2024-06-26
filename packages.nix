{ pkgs, inputs, ... }:


{
  nixpkgs.config.allowUnfree = true;
 
  

  services.xserver.excludePackages = (with pkgs; [ 
    xterm 
  ]);

  environment.systemPackages = with pkgs; [
    

    #libraries
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
    wget
    unzip
    time
    socat
    rsync
    ripgrep
    fzf
    fastfetch
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
    podman-compose
 
    

    
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
      defaultNetwork.settings.transmission_paused = true;
    };
  };

 
  
  

  
}
