{ pkgs, inputs, system, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [

    (self: super: {
      asusctl = super.callPackage <nixpkgs/pkgs/applications/system/asusctl> {
        rustPlatform = super.rustPlatform // {
          buildRustPackage = args:
            super.rustPlatform.buildRustPackage (args // {
              pname = "asusctl";
              version = "6.0.12";

              src = super.fetchFromGitLab {
                owner = "asus-linux";
                repo = "asusctl";
                rev = "6.0.12";
                hash = "sha256-fod3ZkJktmJGHF8nSSp9lVMg/qYKQd4EiauFGTSvbsg=";
              };

              cargoLock = {
                lockFile = super.fetchurl {
                  url =
                    "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/master/pkgs/applications/system/asusctl/Cargo.lock";
                  sha256 =
                    "sha256-KOMTuFTWpiIOUY3Ttfzwy+r4mPc5b5tmP979ujhhtWc=";
                };
                outputHashes = {
                  "const-field-offset-0.1.5" =
                    "sha256-QtlvLwe27tLLdWhqiKzXoUvBsBcZbfwY84jXUduzCKw=";
                  "supergfxctl-5.2.4" =
                    "sha256-MQJJaTajPQ45BU6zyMx0Wwf7tAPcT4EURWWbZxrbGzE=";
                };
              };

              postPatch =
                "  files=\"\n    asusd-user/src/config.rs\n    asusd-user/src/daemon.rs\n    asusd/src/ctrl_anime/config.rs\n    rog-aura/src/aura_detection.rs\n    rog-control-center/src/lib.rs\n    rog-control-center/src/main.rs\n    rog-control-center/src/tray.rs\n  \"\n  for file in $files; do\n    substituteInPlace $file --replace /usr/share $out/share\n  done\n\n  substituteInPlace data/asusd.rules --replace systemctl ${pkgs.systemd}/bin/systemctl\n  substituteInPlace data/asusd.service \\\n    --replace /usr/bin/asusd $out/bin/asusd \\\n    --replace /bin/sleep ${pkgs.coreutils}/bin/sleep\n  substituteInPlace data/asusd-user.service \\\n    --replace /usr/bin/asusd-user $out/bin/asusd-user \\\n    --replace /usr/bin/sleep ${pkgs.coreutils}/bin/sleep\n\n  substituteInPlace Makefile \\\n    --replace /usr/bin/grep ${
                      lib.getExe pkgs.gnugrep
                    }\n";

              nativeBuildInputs = [ pkgs.pkg-config ];

              buildInputs = [
                pkgs.fontconfig
                pkgs.libGL
                pkgs.libinput
                pkgs.libxkbcommon
                pkgs.mesa
                pkgs.seatd
                pkgs.systemd
                pkgs.wayland
              ];

              # force linking to all the dlopen()ed dependencies
              RUSTFLAGS = map (a: "-C link-arg=${a}") [
                "-Wl,--push-state,--no-as-needed"
                "-lEGL"
                "-lfontconfig"
                "-lwayland-client"
                "-Wl,--pop-state"
              ];

              # upstream has minimal tests, so don't rebuild twice
              doCheck = false;

              postInstall = "  make prefix=$out install-data\n";

              meta = with lib; {
                description =
                  "Control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops";
                homepage = "https://gitlab.com/asus-linux/asusctl";
                license = licenses.mpl20;
                platforms = [ "x86_64-linux" ];
                maintainers = with maintainers; [ k900 aacebedo ];
              };

            });
        };
      };
    })

  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # And ensure gnome-settings-daemon udev rules are enabled 
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  #minimal gnome
  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    #gnome-text-editor
    #snapshot
    #loupe
    gnome-photos
    gnome-tour
    gnome-connections
    simple-scan
    gnome-usage
  ]) ++ (with pkgs.gnome; [
    #gnome-calculator
    gnome-system-monitor
    #file-roller
    #baobab
    cheese
    #gnome-disk-utility
    gnome-logs
    seahorse
    eog
    gnome-maps
    gnome-font-viewer
    yelp
    gnome-calendar
    gnome-contacts
    gnome-music
    gnome-software
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    gnome-weather
    gnome-clocks
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  services.xserver.excludePackages = (with pkgs; [ xterm ]);

  environment.systemPackages = with pkgs; [

    switcheroo-control # dbus for dual gpu

    #gmome
    gnomeExtensions.appindicator
    gnomeExtensions.supergfxctl-gex
    gnomeExtensions.screen-rotate # 2 in 1 extension
    gnomeExtensions.gsnap
    gnomeExtensions.quick-settings-audio-panel
    #gnomeExtensions.rounded-window-corners-reborn# waiting for update >:(
    gnomeExtensions.auto-move-windows
    gnomeExtensions.vitals
    gnome.gnome-tweaks

    #terminal
    ptyxis

    #video player
    celluloid

    #zsh shit
    starship

    #recording 
    obs-studio

    #browser
    firefox

    #xbox controllers
    xboxdrv

    #discord
    vesktop

    #school shit 

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
    mangohud

    appimage-run # runs appimages
    steam-run # runs linux binaries

  ];

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
  };

  fonts.packages = with pkgs; [
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];

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
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils pkgs.lsof ];

  #gnome exclusive services
  services.switcherooControl.enable = true;

}
