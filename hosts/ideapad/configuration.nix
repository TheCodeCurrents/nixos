{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/common.nix
      ../../modules/gaming.nix
      ../../modules/virtualization.nix
      ../../modules/docker.nix
      ../../modules/syncthing.nix
      ../../modules/wayland-wm.nix
      ./hardware-configuration.nix
    ];

  # OpenGL
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  networking.hostName = "ideapad";

}
