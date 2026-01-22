{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/common.nix
      ../../modules/gaming.nix
      ../../modules/virtualization.nix
      ../../modules/docker.nix
      ../../modules/syncthing.nix
      ../../modules/ollama.nix
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

  environment.systemPackages = with pkgs; [
    libglvnd
    glfw
    nvidia-vaapi-driver
  ];
}
