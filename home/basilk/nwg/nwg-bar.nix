{
  pkgs,
  user,
  lib,
  stdenv,
  inputs,
  ...
}:
{
  imports = [
  ];
  home.packages = with pkgs;[
    nwg-bar
  ];
  wayland.windowManager.sway.config.bars = [
      {
        command = "nwg-bar";
        position = "top";
      }
      ];

  
}
