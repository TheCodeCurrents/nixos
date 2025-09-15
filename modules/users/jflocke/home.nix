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
    ];

    home.stateVersion = "25.05";
}
