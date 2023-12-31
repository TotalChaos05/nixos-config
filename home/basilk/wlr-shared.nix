
{pkgs, lib, ...}:
{
  imports = [./waybar.nix];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    plugins = [ pkgs.rofi-calc pkgs.rofimoji pkgs.rofi-top pkgs.rofi-screenshot];
    extraConfig = {
      modi = "window,drun,calc,ssh,run,top,";
      combi-modes = "run,window,drun,";
    };
  };
  programs.swaylock = {
    enable = true;
    settings = {
      image = lib.mkDefault "~/.wallpaper.png";
      scaling = "fill";
    };
  };
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 360;
        command = "${pkgs.swayfx}/bin/swaymsg output '*' dpms off";
        resumeCommand = "${pkgs.swayfx}/bin/swaymsg output '*' dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -F -l -f -c 000000";
      }
    ];
  };
}
