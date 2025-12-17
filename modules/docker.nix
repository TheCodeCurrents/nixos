{ lib, pkgs, ... }:
{
  
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker;
  };

  users.users.jflocke.extraGroups = lib.mkAfter [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    appimage-run
  ];

}