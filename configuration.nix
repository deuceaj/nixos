# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ...
}: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix;
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      # rust-overlay.url = "github:oxalica/rust-overlay";
      # impermanence.url = "github:nix-community/impermanence";
      nur.url = "github:nix-community/NUR";
      hyprpicker.url = "github:hyprwm/hyprpicker";
      hypr-contrib.url = "github:hyprwm/contrib";
      flake-parts.url = "github:hercules-ci/flake-parts";
      # sops-nix.url = "github:Mic92/sops-nix";
      picom.url = "github:yaocccc/picom";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "Alpha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };



services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };



security.rtkit.enable = true;
security.polkit.enable = true;
security.sudo.wheelNeedsPassword = false; # User does not need to give password when using sudo.
  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };



home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.bspwm.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  
  sound = {                                # Deprecated due to pipewire
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };




  services = {
    avahi = {                                   # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = {                               # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  
    openssh = {                             # SSH: secure shell (remote connection to shell of server)
      enable = true;                        # local: $ ssh <user>@<ip>
      allowSFTP = true;                     # SFTP: secure file transfer protocol (send file to server)
     
    };

  };



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.deuce = {
    isNormalUser = true;
    description = "deuce";
    extraGroups = [
      "wheel""video""audio""camera""networkmanager""lp""scanner""kvm""libvirtd"
    ];
    shell = pkgs.zsh;                       # Default shell
    directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          # "Codelearning"
          ".npm-global"
          ".config"
          # ".thunderbird"
          # ".go-musicfox"
          "Flakes"
          "Kvm"
          # ".cabal"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
    packages = with pkgs; [
      libnotify
      xclip
      xorg.xrandr
      cinnamon.nemo
      networkmanagerapplet
      xorg.xev
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      # pkgs.rust-bin.stable.latest.default
      lxappearance
      imagemagick
      flameshot


    ];
  };



 


  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };




  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bspwm
    firefox-devedition-bin
    neovim
    polkit_gnome
    polybar
    rofi
    steam
    sxhkd
    vscode
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #
  # };

  programs.corectrl.enable = true;
  programs.corectrl.gpuOverclock.enable = true;
  programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  




  # List services that you want to enable:








 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ...
  # ];
  # networking.firewall.allowedUDPPorts = [ ...
  # ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https: //nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
