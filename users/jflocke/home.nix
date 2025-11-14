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

    # programs.vscode = {
    #     enable = true;
    #     extensions = with pkgs.vscode-extensions; [
    #         dracula-theme.theme-dracula
    #         vscodevim.vim
    #         yzhang.markdown-all-in-one
    #         ms-vscode.cpptools
    #         github.copilot
    #         github.copilot-chat
    #         platformio.platformio-vscode-ide
    #         bbenoist.nix
    #         arrterian.nix-env-selector
    #         jnoortheen.nix-ide
    #         mkhl.direnv
    #         catppuccin.catppuccin-vsc
    #         # catppuccin.catppuccin-vsc-icons
    #         rust-lang.rust-analyzer
    #     ];
    # };

    home.stateVersion = "25.05";
}