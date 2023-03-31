# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  

  # Default UEFI setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Dual Booting using grub
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # /boot will probably work too
    };
    grub = {                          # Using grub means first 2 lines can be removed
      enable = true;
      #device = ["nodev"];            # Generate boot menu but not actually installed
      devices = ["nodev"];            # Install grub
      efiSupport = true;
      configurationLimit = 5;
      useOSProber = true;             # Or use extraEntries like seen with Legacy
    };                                # OSProber will probably not find windows partition on first install
  };


  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "Alpha"; # Define your hostname.

 
  #Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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


# Enable the X11 windowing system.
     services = {
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = “none+bspwm”;
      };
      desktopManager.xfce.enable = true;
      windowManager.bspwm.enable = true;
      layout = "us";
    };
  };





  

  
  
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
        hsphfpd.enable = true;         # HSP & HFP daemon
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
    };




  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.deuce = {
  	isNormalUser = true;
	  extraGroups = [ "wheel" "video" " audio" " networkmanager" "libvirt" "lp" "scanner"]; # Enable ‘sudo’ for the user.  
	  initialPassword = "password";
    shell = pkgs.zsh;
    ackages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };


	environment.systemPackages = with pkgs; [
		alacritty
    bspwm
    cinnamon.nemo
    corectrl
    dunst
    firefox-devedition-bin
    neovim
    nitrogen
    sxhkd
    rofi
    wget
    vscode  
  #     thunderbird
     ];
  # };





  programs.corectrl.enable = true;
  programs.corectrl.gpuOverclock.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ################################################
  # List services that you want to enable:
  ################################################
 
   services.openssh.enable = true;
   services.xserver.windowManager.bspwm.enable = true;
   security.polkit.enable = true;

  ################################################
  # Open ports in the firewall.
  ################################################
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;




  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

