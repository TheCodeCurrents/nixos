{ config, pkgs, ... }:

{
  # "Most of the apps" moved out of `home.nix` into this dedicated module.
  # I left shells/launchers/terminal utilities and editor-specific config alone
  # since those tend to belong in other modules (e.g. `terminal.nix`, `gnome.nix`,
  # `nixvim.nix`, etc.).
  home.packages = with pkgs; [
    # EDA / FPGA / EE
    kicad
    logisim-evolution
    saleae-logic-2

    # Editors / IDEs
    zed-editor
    lapce

    # Media / creative
    spotify
    davinci-resolve
    gimp
    blender
    obs-studio
    obs-cli
    ffmpeg-full

    # Office
    wpsoffice
    onlyoffice-desktopeditors

    # Dev toolchains (kept here since you had them in "apps" previously)
    rustc
    cargo
    esp-generate
    zig
    typst
    gcc
    nodejs_22
    pnpm
    platformio
    cargo-pio

    verilator
    ghdl

    arduino-ide

    ansible

    # Boot / disk tools
    udisks

    # Misc
    winboat
    remmina

    # Custom override kept as-is
    (ripes.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or []) ++ [
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      ];
    }))
  ];
}
