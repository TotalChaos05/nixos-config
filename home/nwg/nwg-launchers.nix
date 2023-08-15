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
    nwg-launchers
  ];
  #wayland.windowManager.sway.extraConfig = "exec_always nwg-launchers";
}
