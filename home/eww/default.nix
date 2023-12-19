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
  home.packages = [
    pkgs.eww-wayland
  ];
  programs.eww = {
    package = pkgs.eww-wayland;
    configDir = ./config;
  };
}
