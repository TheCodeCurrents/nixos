{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/common.nix
      ../../modules/gaming.nix
      ../../modules/virtualization.nix
      ../../modules/docker.nix
      # ../../modules/syncthing.nix
      ../../modules/ollama.nix
      ./hardware.nix
    ];

  networking.hostName = "yoga"; # Define your hostname.
  networking.networkmanager.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  hardware.nvidia.prime = {
    offload = {
      # programs have to be launched explicitly with the gpu
      enable = true;
      enableOffloadCmd = true;
    };

    # integrated
    intelBusId = "PCI:0:2:0";
    
    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.open = false;
}
