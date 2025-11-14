{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./hyprland.nix
        ./gnome.nix
        ./git.nix
        ./nixvim.nix
        # ./fpga.nix
    ];

    programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
    };

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

        gcc

        platformio
        cargo-pio

        ventoy-full-gtk
        udisks

        onlyoffice-desktopeditors
    ];

    home.stateVersion = "25.05";
}