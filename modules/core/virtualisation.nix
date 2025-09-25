{ config, pkgs, ... }:
{
  
  virtualisation.libvirtd.enable = true;
  users.users.jakob.extraGroups = [ "libvirtd" ];

  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [ gnome-boxes ];

}