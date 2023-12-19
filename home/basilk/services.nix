{pkgs,lib, ...}:
  let user = import ../user.nix; in {
    
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
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
