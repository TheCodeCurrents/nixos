{ pkgs, config, lib, ... }:

let
  host = config.networking.hostName;

  yogaId = "FHJ4CRS-AT3NHXY-CS4QCEH-TT6QKW2-TESB25L-UGHTPTQ-4QPEV75-ILSD3AB";
  onyxId = "MOLWIGA-LTJYPSJ-F4TCCJW-5AZQXHN-WF4USGP-KQHC35G-TB67PTM-XDOSUQT";
  orionId = "QXHHST3-2ZBZFZM-EXE4QPN-5PP6R6O-PU72R2Z-CZKO2MV-4SUIZ3R-TCK7EQG";

  perHostDevices = {
    onyx = {
      yoga = { id = yogaId; };
    };
    yoga = {
      onyx = { id = onyxId; };
    };
    ideapad = {
      yoga = { id = yogaId; };
      onyx = { id = onyxId; };
    };
  };

  devices = (perHostDevices.${host} or { }) // {
    orion = { id = orionId; };
  };

  folderDevices = builtins.attrNames (perHostDevices.${host} or { });

  # helper: build full device entries for folders
  folderDeviceAttrs =
    if folderDevices != [] then
      builtins.map (deviceName: {
        name = deviceName;
        deviceID = devices.${deviceName}.id;
      }) folderDevices
    else
      null;

in
{
  environment.systemPackages = [ pkgs.syncthing ];

  services.syncthing = {
    enable = true;
    user = "jflocke";
    group = "users";
    dataDir = "/home/jflocke/syncthing";
    configDir = "/home/jflocke/.config/syncthing";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      inherit devices;

      folders = lib.filterAttrs (name: folder: folder != null) {
        "shared" = lib.mkIf (folderDeviceAttrs != null) {
          path = "/home/jflocke/syncthing/shared";
          devices = folderDeviceAttrs;
        };
        "docs" = lib.mkIf (folderDeviceAttrs != null) {
          path = "/home/jflocke/Docs";
          devices = folderDeviceAttrs;
        };
      };
    };
  };
}
