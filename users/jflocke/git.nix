{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "jflocke@proton.me";
        name = "Jakob Flocke";
      };
      pull.rebase = false;
      init.defaultBranch = "main";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  
  home.packages = [ pkgs.git-credential-manager ];
}