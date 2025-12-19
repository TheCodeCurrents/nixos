{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./terminal.nix
        ./gnome.nix
        ./git.nix
        ./nixvim.nix
    ];

    programs.nixvim = {
        enable = true;
        colorschemes.catppuccin.enable = true;
        plugins.lualine.enable = true;
    };

    home.packages = with pkgs; [

        logisim-evolution
        zed-editor
        
        spotify

        wpsoffice
        davinci-resolve
        gimp
        
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

        ventoy-full-gtk
        udisks

        onlyoffice-desktopeditors

        foot
        fuzzel

        winboat
        
        (ripes.overrideAttrs (old: {
            cmakeFlags = (old.cmakeFlags or []) ++ [
                "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
            ];
        }))
    ];

    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (ps: with ps; [
            rustup zlib openssl.dev pkg-config avrdude
        ]);
    };


    home.stateVersion = "25.05";
}