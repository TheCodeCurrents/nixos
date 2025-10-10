{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/core/common.nix
      ./hardware-configuration.nix
      ./wireguard.nix
    ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;

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

  networking.hostName = "yoga";
  networking.networkmanager.enable = true;

  programs.fish.enable = true;

  programs.firefox.enable = true;

}
