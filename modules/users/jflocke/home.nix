{ config, pkgs, ... }:
{
    home.username = "jflocke";
    home.homeDirectory = "/home/jflocke";
    
    programs.git = {
        enable = true;
        userName  = "Jakob Flocke";
        userEmail = "jflocke@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    home.packages = with pkgs; [
        ripgrep
        fd
        bat
        eza
        # starship
        tmux
        zoxide
        fzf
        curl
        zellij
    ];

    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };

    home.stateVersion = "25.05";
}
