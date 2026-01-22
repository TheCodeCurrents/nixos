{ config, pkgs, ... }:

let
  # Wrap your existing 2pa-byps.sh into an executable in the Nix store
  speakerScript = pkgs.writeShellScriptBin "turn-on-speakers" ''
    #!${pkgs.bash}/bin/bash

    # Wait until the I2C bus exists
    until ls /sys/class/i2c-dev/i2c-* 1>/dev/null 2>&1; do
      sleep 1
    done

    # Include the original script contents
    ${builtins.readFile ./2pa-byps.sh}
  '';
in
{
  environment.systemPackages = with pkgs; [
    util-linux   # for logger, etc.
    kmod         # for modprobe
    i2c-tools    # for i2cdetect/i2cset
    gawk         # for awk command in the script

    sof-firmware
    alsa-ucm-conf
  ];

  boot.kernelModules = [ "i2c-dev" "snd_sof_pci" "snd_sof_intel_hda" ];

  # Service to enable speakers at boot
  systemd.services.turn-on-speakers = {
    description = "Enable Lenovo Yoga Pro 9i speakers via I2C";
    after = [ "systemd-modules-load.service" "basic.target" ];
    wants = [ "systemd-modules-load.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${speakerScript}/bin/turn-on-speakers";  # <--- important /bin path
      User = "root";

      # Ensure access to i2c devices
      DeviceAllow = "/dev/i2c-* rwm";

      # Disable extra sandboxing so the script can run safely
      ProtectSystem = "off";
      ProtectHome = "off";
      PrivateTmp = false;
    };

    wantedBy = [ "multi-user.target" ];
  };

  # Re-run after resume/suspend to ensure speakers stay enabled
  systemd.services.turn-on-speakers-suspend = {
    description = "Re-enable speakers after suspend/hibernate";
    after = [ "sleep.target" ];
    wants = [ "sleep.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${speakerScript}/bin/turn-on-speakers";
      User = "root";
      DeviceAllow = "/dev/i2c-* rwm";
      ProtectSystem = "off";
      ProtectHome = "off";
      PrivateTmp = false;
    };

    wantedBy = [ "sleep.target" ];
  };
}
