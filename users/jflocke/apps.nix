{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ── Media ──────────────────────────────────────────────
    spotify
    gimp
    obs-studio
    ffmpeg-full
    davinci-resolve

    # ── Office ─────────────────────────────────────────────
    onlyoffice-desktopeditors

    # ── EDA / FPGA ─────────────────────────────────────────
    kicad
    logisim-evolution
    verilator
    yosys
    openfpgaloader

    # ── Misc ───────────────────────────────────────────────
    remmina
    ansible
    winboat
    protonvpn-gui

    stm32cubemx

    # Custom override kept as-is
    (ripes.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or []) ++ [
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      ];
    }))
  ];
}
