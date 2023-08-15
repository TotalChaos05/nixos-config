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
    nwg-panel
  ];
  wayland.windowManager.sway.extraConfig = "exec_always nwg-panel";
  }
