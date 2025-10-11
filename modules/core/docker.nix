{ config, pkgs, ... }:
{
  
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    package = pkgs.docker;
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    appimage-run
  ];

}