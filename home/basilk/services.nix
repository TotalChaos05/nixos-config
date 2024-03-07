{
  pkgs,
  lib,
  config,
  ...
}: let
  user = import ../../user.nix;
in {
  services.easyeffects.enable = true;

  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd

    ];
  };
  
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
    enable = false;
    musicDirectory = "${config.home.homeDirectory}/Music";
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
  #services.kdeconnect = {
  #  enable = true;
  #  indicator = true;
  #};
  services.syncthing.enable = true;
}
