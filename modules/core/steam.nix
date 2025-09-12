{ config, pkgs, ... }:

{
  # Enable Steam
  programs.steam = {
    enable = true;
    # Optionally enable Steam Play (Proton)
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Optional: Add 32-bit libraries for compatibility
  environment.systemPackages = with pkgs; [
    steam
    # Add additional 32-bit libraries if needed
    # libglvnd-32bit
    # alsaLib-32bit
  ];

  # Optional: Open firewall for Steam multiplayer
  networking.firewall.allowedTCPPorts = [ 27036 27037 ];
  networking.firewall.allowedUDPPorts = [ 27031 27036 4380 ];
}