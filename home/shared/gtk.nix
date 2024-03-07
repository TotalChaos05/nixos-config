{
  pkgs,
  lib,
  ...
}:
{
  
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
         color-scheme = lib.mkDefault "prefer-dark";
      };
    };
  };
}
