
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    util-linux
    kmod
    i2c-tools
  ];

  boot.kernelModules = [ "i2c-dev" ];

  systemd.services.turn-on-speakers = {
    description = "Turn on speakers using i2c configuration";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target" ];

    serviceConfig = {
      User = "root";
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c \"${./2pa-byps.sh} | ${pkgs.util-linux}/bin/logger\"";
    };
      wantedBy = [ "multi-user.target" "sleep.target" ];
  };
}