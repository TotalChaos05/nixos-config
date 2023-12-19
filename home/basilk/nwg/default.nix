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
    ./nwg-bar.nix  
    ./nwg-dock.nix  
    ./nwg-drawer.nix  
    ./nwg-launchers.nix  
    ./nwg-panel.nix
  ];
  home.packages = with pkgs;[
  
  ];
}
