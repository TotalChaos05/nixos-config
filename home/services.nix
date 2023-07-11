{pkgs,lib, ...}:
{
    services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "hyprland-session.target";
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
    imports = [./waybar.nix];
  services.flameshot.enable = true;


  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = 32.9546;
    longitude = -97.0150;
    temperature.night = 2000;
  };
  services.playerctld.enable = true;
  services.kdeconnect.enable = true;
  
}
