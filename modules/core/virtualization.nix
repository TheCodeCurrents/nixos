{ config, pkgs, ... }:
{
  
  virtualisation.libvirtd.enable = true;
  users.users.jflocke.extraGroups = [ "libvirtd" "user-with-access-to-virtualbox" ];

  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-boxes
    virtualbox
    qemu
  ];

}