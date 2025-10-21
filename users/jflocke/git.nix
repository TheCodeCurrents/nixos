{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Jakob Flocke";
    userEmail = "jflocke@proton.me";
    extraConfig = {
      pull.rebase = false;
      init.defaultBranch = "main";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      pull.rebase = "false";
    };
  };
  
  home.packages = [ pkgs.git-credential-manager ];
}