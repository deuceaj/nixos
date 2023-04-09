# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "virtio_pci" "sr_mod" "virtio_blk"];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { #device = "/dev/disk/by-uuid/e08e8ee8-6348-4f66-accc-e80313abc978";
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { # device = "/dev/disk/by-uuid/F0D5-4EF6";
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { 
      # device = "/dev/disk/by-uuid/67891c06-a3b9-48e9-bd74-1154f1ec5f01"; 
      device = "/dev/disk/by-label/nixos";
      }
    ];


  
  fileSystems."/media/Epsilon" =
    { device = "/dev/disk/by-uuid/bd7b8781-f98f-45e3-8e5e-fee3d9fd8bbd";
      fsType = "btrfs";
    options = [ "nofail" ];
    };

  
  #   fileSystems."/media/Gamma" =
  #   { device = "/dev/disk/by-uuid/b1121d57-4180-4ad1-af4f-158af3b18883";
  #     fsType = "btrfs";
  #   options = [ "nofail" ];
  #   };


  # fileSystems."/media/Delta" =
  #   { #truenas smb storage
  #     device = "//192.168.2.10/Delta";
  #     fsType = "cifs";
  #     options = let
  #       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #     in ["${automount_opts},mfsymlinks,uid=1000,gid=100,credentials=/home/deuce/.local/.smbcredentials"];
  #   };


  fileSystems."/media/Theta" =
    { #truenas smb storage
      device = "//192.168.2.10/Theta";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},mfsymlinks,uid=1000,gid=100,credentials=/home/deuce/.local/.smbcredentials"];
    };

    fileSystems."/media/Vega" =
    { #truenas smb storage
      device = "//192.168.2.10/Vega";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},mfsymlinks,uid=1000,gid=100,credentials=/home/deuce/.local/.smbcredentials"];
    };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
