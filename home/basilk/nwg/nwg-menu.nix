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
    nwg-menu
  ];
  wayland.windowManager.sway.extraConfig = "exec_always nwg-menu";
}
