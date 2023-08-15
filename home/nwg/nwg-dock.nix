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
    nwg-dock
  ];
  wayland.windowManager.sway.extraConfig = "exec_always nwg-dock -d";
}
