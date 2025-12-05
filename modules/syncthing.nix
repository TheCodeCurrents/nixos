{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "jflocke";
    group = "users";
    dataDir = "/home/jflocke/syncthing";
    configDir = "/home/jflocke/.config/syncthing";
  };
}