{ config, pkgs, ... }:

let
  host = config.networking.hostName;

  yogaId = "yoga-id"; # placeholder
  onyxId = "MOLWIGA-LTJYPSJ-F4TCCJW-5AZQXHN-WF4USGP-KQHC35G-TB67PTM-XDOSUQT"; # placeholder

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

  # Optional: if you want a shared folder between them, you can
  # also make the folder's device list conditional:
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
      };
    };
  };
}
