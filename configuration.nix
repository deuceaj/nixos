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
#      <home-manager/nixos>
    ];

   # Set the system state version
  system.stateVersion = "22.05";

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

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    bspwm
    btop
    corectrl
    cinnamon.nemo    
    discord
    dunst
    firefox-devedition-bin
    neovim
    nitrogen
    polkit-gnome
    sddm
    sxhkd
    rofi
    wget
    vscode  

  #     thunderbird
     ];
  # };


  # Set up SDDM as the default display manager.
  services.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  # Configure BSPWM and SXHKD as your window manager and hotkey daemon.
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.desktopManager.sxhkd.enable = true;

  # Set up Rofi as your application launcher.
  services.xserver.desktopManager.rofi.enable = true;

  # Set up Nitrogen as your wallpaper manager.
  services.xserver.desktopManager.nitrogen.enable = true;

  # Set up CoreCtrl as your system monitor and controller.
  services.corectrl.enable = true;


  # Enable Polkit as your authentication agent.
  services.polkit.enable = true;
  security.polkit.enable = true;




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
