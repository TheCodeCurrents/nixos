{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Jakob Flocke";
    userEmail = "jflocke@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
  

  home.packages = [ pkgs.git-credential-manager ];

}