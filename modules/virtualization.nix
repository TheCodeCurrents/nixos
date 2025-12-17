{ lib, pkgs, ... }:
{

  boot.kernelModules = [ "vboxdrv" "vboxnetflt" "vboxnetadp" ];

  virtualisation.libvirtd.enable = true;

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  users.users.jflocke.extraGroups = lib.mkAfter [ "libvirtd" "vboxusers" ];

  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-boxes
    qemu
  ];

}