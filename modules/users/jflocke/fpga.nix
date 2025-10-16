{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    yosys
    nextpnr
    # nextpnrWithGui
    openfpgaloader
    verilator
    verible
    gtkwave
  ];

}