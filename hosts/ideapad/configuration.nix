{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/core/common.nix
      ./hardware-configuration.nix
    ];

  # OpenGL
  hardware.opengl.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  networking.hostName = "ideapad";
  networking.networkmanager.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jflocke = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
      networkmanager_dmenu
      networkmanager
    ];
  };

  programs.firefox.enable = true;

}

