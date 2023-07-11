{pkgs, lib, ...}:
{
    programs.foot.enable = true;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  programs.swaylock = {
    enable = true;
    settings = {
      image = lib.mkDefault "~/wallpaper.png";
      scaling = "fill";
    };
  };
  programs.rbw = {
    enable = true;
  };
  programs.starship.enable = true;
  programs.helix.enable = true;
  programs.imv.enable = true;
  programs.thunderbird = {
    enable = true;
    package = pkgs.betterbird;
    profiles = {};
  };
}
