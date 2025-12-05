{ config, pkgs, ... }:

let
  host = config.networking.hostName;

  yogaId = "FHJ4CRS-AT3NHXY-CS4QCEH-TT6QKW2-TESB25L-UGHTPTQ-4QPEV75-ILSD3AB";
  onyxId = "MOLWIGA-LTJYPSJ-F4TCCJW-5AZQXHN-WF4USGP-KQHC35G-TB67PTM-XDOSUQT";

  devices =
    if host == "onyx" then {
      # onyx should only know about yoga
      yoga = { id = yogaId; };
    } else if host == "yoga" then {
      # yoga should only know about onyx
      onyx = { id = onyxId; };
    } else {
      # fallback in case this config ever gets reused elsewhere
      yoga = { id = yogaId; };
      onyx = { id = onyxId; };
    };
    
  folderDevices =
    if host == "onyx" then [ "yoga" ]
    else if host == "yoga" then [ "onyx" ]
    else [ ];
in
{
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

      # you can put your folders here; example:
      folders = {
        "shared" = {
          path = "/home/jflocke/syncthing/shared";
          devices = folderDevices;
        };
        "docs" = {
          path = "/home/jflocke/Docs";
          devices = folderDevices;
        };
      };
    };
  };
}
