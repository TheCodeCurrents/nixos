{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/core/common.nix
      ./hardware-configuration.nix
    ];


  networking.hostName = "ideapad"; # Define your hostname.
  networking.networkmanager.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jflocke = {
    isNormalUser = true;
    extraGroups = [ "wheel", "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      networkmanager_dmenu  # dmenu-based Wi-Fi selector
      nmcli                 # CLI tool
      nmtui                 # TUI tool
    ];
  };

  programs.firefox.enable = true;


}

