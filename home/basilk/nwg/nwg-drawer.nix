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
    nwg-drawer
  ];
  wayland.windowManager.sway.extraConfig = lib.mkAfter "bindsym $mod+F1 exec nwg-drawer";
}
