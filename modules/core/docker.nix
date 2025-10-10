{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    docker-buildx
  ];

  virtualisation.docker = {
    enable = true;
    extraOptions = ''
      {
        "data-root": "/var/lib/docker"
      }
    '';
  };

  users.groups.docker.members = [ "jflocke" ];

}