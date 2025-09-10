{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/core/common.nix
      ./hardware-configuration.nix
    ];


  networking.hostName = "ideapad"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.dhcpcd = {
    enable = true;
    extraConfig = ''
      hostname
      clientid
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jflocke = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;


}

