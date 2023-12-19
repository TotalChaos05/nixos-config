{pkgs, lib, inputs, ...}:
{
  home.packages = with pkgs; [
    wob
    sov
    iwgtk
    brightnessctl
    terminus_font
    ubuntu_font_family
    wdisplays
    wlogout
    zsh
    gnome.gnome-system-monitor
  ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
}
