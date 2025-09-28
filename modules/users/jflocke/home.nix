{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./hyprland.nix
        ./gnome.nix
    ];

    programs.git = {
        enable = true;
        userName  = "Jakob Flocke";
        userEmail = "jflocke@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    home.packages = with pkgs; [
        pkgs.jellyfin
        pkgs.jellyfin-web
        pkgs.jellyfin-ffmpeg

        aaxtomp3

        logisim-evolution
    ];

    home.stateVersion = "25.05";
}