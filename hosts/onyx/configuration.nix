{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/common.nix
      ./hardware-configuration.nix
      ./wireguard.nix
    ];

  networking.hostName = "onyx";
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaSettings = true;
  };
  services.xserver.videoDrivers = ["nvidia"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.fish.enable = true;

  system.stateVersion = "25.05";

}
