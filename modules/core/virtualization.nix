{ config, pkgs, ... }:
{
  
  virtualisation.libvirtd.enable = true;
  users.users.jflocke.extraGroups = [ "libvirtd" ];

  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-boxes
    virtualbox
    qemu
  ];

}