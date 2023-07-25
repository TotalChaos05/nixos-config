{pkgs,lib, ...}:
  let user = import ../user.nix; in {
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
#  services.kdeconnect.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = /home/${user}/Music;
    extraConfig = ''
audio_output {
    type                    "fifo"
    name                    "my_fifo"
    path                    "/tmp/mpd.fifo"
    format                  "44100:16:2"
}
audio_output {
        type            "pipewire"
        name            "PipeWire Output"
}
'';
  };
  services.mpdris2.enable = true;
}
