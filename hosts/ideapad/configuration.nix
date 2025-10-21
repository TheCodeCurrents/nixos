{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/common.nix
      ./hardware-configuration.nix
    ];

  # OpenGL
  hardware.opengl.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  networking.hostName = "ideapad";
  networking.networkmanager.enable = true;

  programs.fish.enable = true;

  programs.firefox.enable = true;

}
