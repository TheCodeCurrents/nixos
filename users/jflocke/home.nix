{ config, pkgs, mensa, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./git.nix
        ./nixvim.nix
        ./apps.nix
        ./hyprland/hyprland.nix
    ];

    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (ps: with ps; [
            rustup zlib openssl.dev pkg-config
        ]);
    };

    home.packages = with pkgs; [
        mensa.packages.${pkgs.system}.default
    ];

    home.stateVersion = "25.05";
}
