{ config, pkgs, ... }:

{
    # Shell setup
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

    # Starship prompt
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

    # zoxide for smarter cd
    programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
            "--cmd cd"
        ];
    };

    # fzf configuration
    programs.fzf = {
        enable = true;
        enableFishIntegration = true;
        # Optionally, you can add extra options:
        # defaultOptions = [ "--height 40%" "--border" ];
    };
}