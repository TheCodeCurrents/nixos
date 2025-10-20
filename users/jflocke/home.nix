{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./hyprland.nix
        ./gnome.nix
        ./git.nix
        # ./fpga.nix
    ];

    home.packages = with pkgs; [
        pkgs.jellyfin
        pkgs.jellyfin-web
        pkgs.jellyfin-ffmpeg

        phoronix-test-suite

        aaxtomp3

        logisim-evolution

        wpsoffice
        
        rustc
        cargo

        ventoy-full-gtk
        udisks
    ];

    home.stateVersion = "25.05";
}