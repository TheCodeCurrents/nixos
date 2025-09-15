{ config, pkgs, ... }:

{
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
        # Configure fish shell
        shellAliases = {
            btw = "echo I use nixos, btw";
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

    programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = "--cmd cd" ;
    };

    home.sessionVariables = {
        SHELL = "${pkgs.fish}/bin/fish";
    };
}