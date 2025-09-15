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

    home.sessionVariables = {
        SHELL = "${pkgs.fish}/bin/fish";
    };
}