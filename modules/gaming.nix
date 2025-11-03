{ config, pkgs, ... }:

{

  # Enable Steam
  programs.steam = {
    enable = true;
    # Optionally enable Steam Play (Proton)
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    steam
    prismlauncher
    lutris-unwrapped
    heroic-unwrapped

    discord
    mangohud
  ];

  networking.firewall.allowedTCPPorts = [ 27036 27037 ];
  networking.firewall.allowedUDPPorts = [ 27031 27036 4380 ];
}