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

    # ── Dark mode ───────────────────────────────────────────
    # Portal provides color-scheme=prefer-dark to GTK4 apps;
    # dconf handles GTK3 apps. No custom GTK theme needed.
    dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
    };

    # ── Firefox ────────────────────────────────────────────
    programs.firefox = {
        enable = true;
        profiles.default = {
            isDefault = true;
            extensions.force = true;
            settings = {
                "ui.systemUsesDarkTheme" = 1;
                "browser.theme.content-theme" = 0;       # 0 = dark
                "browser.theme.toolbar-theme" = 0;
                "layout.css.prefers-color-scheme.content-override" = 0;  # 0 = dark
            };
        };
    };

    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (ps: with ps; [
            rustup zlib openssl.dev pkg-config
        ]);
    };

    home.packages = with pkgs; [
        mensa.packages.${pkgs.system}.default
        xdg-desktop-portal-gtk   # needed in user profile so the portal finds gtk.portal
    ];

    home.stateVersion = "25.05";
}
