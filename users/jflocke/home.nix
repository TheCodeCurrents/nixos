{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./gnome.nix
        ./git.nix
        ./nixvim.nix
        ./apps.nix
        ./hyprland/hyprland.nix
    ];

    programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
    };

    home.packages = with pkgs; [
        # Most apps moved to `apps.nix`; keep core dev/tooling here.
        rustc
        cargo
        esp-generate

        zig

        typst

        gcc

        nodejs_22
        pnpm

        platformio
        cargo-pio

        udisks
    ];

    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (ps: with ps; [
            rustup zlib openssl.dev pkg-config avrdude
        ]);
    };


    home.stateVersion = "25.05";
}
