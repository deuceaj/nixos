# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
   user="deuce";
in
   


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <nixpkgs/nixos/modules/installer/iso-image/installation-cd-minimal.nix>
      <nixpkgs/nixos/modules/admin/users.nix>
      <nixpkgs/nixos/modules/services/x11/sddm.nix>
      <nixpkgs/nixos/modules/services/x11/desktop-managers/bspwm.nix>
      <nixpkgs/nixos/modules/programs/rofi.nix>
      <nixpkgs/nixos/modules/programs/sxhkd.nix>
      <nixpkgs/nixos/modules/programs/nitrogen.nix>
      <nixpkgs/nixos/modules/services/systemd/corectl.nix>
      <nixpkgs/nixos/modules/security/polkit/polkit-gnome.nix>
#      <home-manager/nixos>
    ];

   # Set the system state version
  system.stateVersion = "22.11";

  # Configure GRUB with dual boot
  boot.loader.grub = {
    enable = true;
    version = 2;
    useOSProber = true;
    devices = [ "/dev/sda" ];
    extraEntries = ''
      menuentry "Windows 10" {
        insmod ntfs
        search --no-floppy --fs-uuid --set=root 201C496E1C493FD0
        chainloader +1
      }
    '';
  };

  # Set the hostname
  networking.hostName = "Alpha";

  # Set the timezone
  time.timeZone = "America/New_York";

  # Configure the user
  users.users.${user} = {
    isNormalUser = true;
    hashedPassword = "${pkgs.lib.mkpasswd "hello"}";
  };

  # Enable the required services
  services = {
    "sddm" = {
      enable = true;
      displayManager.theme = "breeze";
    };
    "corectl" = {
      enable = true;
    };
    "polkit-gnome" = {
      enable = true;
    };
    "openssh" = {
      enable = true;
    };
    "input-remapper" = {
      enable = true;
    };



  };

  # Configure bspwm
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "bspwm";
    };
    windowManager.bspwm = {
      enable = true;
    };
  };

  # Configure Rofi, Sxhkd, and Nitrogen
  programs.rofi = {
    enable = true;
  };
  programs.sxhkd = {
    enable = true;
    extraConfig = ''
      # Example keybindings
      alt + Return
          alacritty
    '';
  };
  programs.nitrogen = {
    enable = true;
    wallpaper = "/path/to/wallpaper.jpg";
  };


# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    # bspwm
    btop
    cinnamon.nemo    
    discord
    dunst
    firefox-devedition-bin
    neovim
    # nitrogen
    # sxhkd
    # rofi
    wget
    vscode  
  #     thunderbird
     ];
  # };


 ################################################
  # Enable sound.
  ################################################
   sound = {
      enable = true;
      mediaKeys.enable = true;
    };
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };
    };
    hardware = {
      bluetooth = {
        enable = true;
        hsphfpd.enable = false;         # HSP & HFP daemon
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
    };


}
