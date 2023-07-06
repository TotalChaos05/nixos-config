{pkgs, lib, ...}:
{
  imports = [./waybar.nix];
  services.flameshot.enable = true;
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

  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = 32.9546;
    longitude = 97.0150;
    temperature.night = 2000;
  };
    services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
      }
      {
        timeout = 600;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
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