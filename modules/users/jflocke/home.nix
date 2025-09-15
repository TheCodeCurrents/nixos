{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";

    imports = [
        ./fish.nix
    ];

    programs.git = {
        enable = true;
        userName  = "Jakob Flocke";
        userEmail = "jflocke@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    programs.starship = {
        enable = true;
        # Configuration written to ~/.config/starship.toml
        settings = {
            add_newline = false;

            # character = {
            #   success_symbol = "[➜](bold green)";
            #   error_symbol = "[➜](bold red)";
            # };

            # package.disabled = true;
        };
    };

    home.packages = with pkgs; [
    ];

    home.stateVersion = "25.05";
}
